/****** Object:  UserDefinedTableType [jobs_internal].[id_list]    Script Date: 6/26/2024 1:14:42 PM ******/
CREATE TYPE [jobs_internal].[id_list] AS TABLE(
	[id] [uniqueidentifier] NULL
)
GO
/****** Object:  UserDefinedTableType [jobs_internal].[target_group_members]    Script Date: 6/26/2024 1:14:42 PM ******/
CREATE TYPE [jobs_internal].[target_group_members] AS TABLE(
	[membership_type] [nvarchar](50) NOT NULL,
	[target_type] [nvarchar](50) NOT NULL,
	[refresh_credential_name] [nvarchar](128) NULL,
	[subscription_id] [uniqueidentifier] NULL,
	[resource_group_name] [nvarchar](128) NULL,
	[server_name] [nvarchar](128) NULL,
	[database_name] [nvarchar](128) NULL,
	[elastic_pool_name] [nvarchar](128) NULL,
	[shard_map_name] [nvarchar](128) NULL
)
GO
/****** Object:  UserDefinedFunction [jobs_internal].[fn_has_credential_perms]    Script Date: 6/26/2024 1:14:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION[jobs_internal].[fn_has_credential_perms](@credential_name NVARCHAR(128))
RETURNS BIT
AS
BEGIN
    DECLARE @result BIT;
    IF (@credential_name IS NULL)
        SET @result = 1
    ELSE
        SET @result = HAS_PERMS_BY_NAME(quotename(@credential_name), 'DATABASE SCOPED CREDENTIAL', 'REFERENCES')

    RETURN @result
END
GO
/****** Object:  View [jobs_internal].[database_credentials]    Script Date: 6/26/2024 1:14:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [jobs_internal].[database_credentials] AS
SELECT *
FROM sys.database_credentials
GO
/****** Object:  View [jobs_internal].[visible_targets_formatted]    Script Date: 6/26/2024 1:14:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [jobs_internal].[visible_targets_formatted] AS
SELECT
    T.target_id,
    T.target_type,
    T.subscription_id,
    T.resource_group_name,
    T.server_name,
    T.database_name,
    T.refresh_credential_name,
    T.elastic_pool_name,
    T.shard_map_name
FROM [jobs_internal].targets T
LEFT OUTER JOIN [jobs_internal].database_credentials C
    ON T.refresh_credential_name COLLATE SQL_Latin1_General_CP1_CI_AS = C.name
WHERE T.target_type <> 'TargetGroup'
GO
/****** Object:  View [jobs_internal].[visible_target_groups]    Script Date: 6/26/2024 1:14:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [jobs_internal].[visible_target_groups] AS
SELECT *
FROM [jobs_internal].targets T
WHERE target_type = 'TargetGroup'
  AND delete_requested_time IS NULL
GO
/****** Object:  View [jobs].[target_groups]    Script Date: 6/26/2024 1:14:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [jobs].[target_groups] AS
SELECT
    target_group_name,
    target_id AS target_group_id
FROM [jobs_internal].visible_target_groups
GO
/****** Object:  View [jobs].[target_group_members]    Script Date: 6/26/2024 1:14:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [jobs].[target_group_members] AS
SELECT
    TG.target_group_name,
    TG.target_id AS target_group_id,
    IIF(TGM.include = 1, 'Include', 'Exclude') AS membership_type,
    T.target_type,
    T.target_id,
    T.refresh_credential_name,
    T.subscription_id,
    T.resource_group_name,
    T.server_name,
    T.database_name,
    T.elastic_pool_name,
    T.shard_map_name
FROM [jobs_internal].visible_target_groups TG
INNER JOIN [jobs_internal].target_group_memberships TGM 
    ON TG.target_id = TGM.parent_target_id
INNER JOIN [jobs_internal].visible_targets_formatted T 
    ON TGM.child_target_id = T.target_id
GO
/****** Object:  View [jobs_internal].[visible_jobs]    Script Date: 6/26/2024 1:14:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [jobs_internal].[visible_jobs] AS
SELECT *
FROM [jobs_internal].jobs J
WHERE J.delete_requested_time IS NULL AND J.is_system = 0
GO
/****** Object:  View [jobs_internal].[current_job_version_numbers]    Script Date: 6/26/2024 1:14:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [jobs_internal].[current_job_version_numbers] AS 
SELECT job_id, MAX(job_version_number) AS current_job_version_number
FROM [jobs_internal].job_versions
GROUP BY job_id
GO
/****** Object:  View [jobs].[jobs]    Script Date: 6/26/2024 1:14:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [jobs].[jobs] AS
SELECT
    name as job_name,
    j.job_id,
    ISNULL(current_job_version_number, 0) AS job_version,

    description,

    -- Schedule
    enabled,
    schedule_interval_type,
    schedule_interval_count,
    schedule_start_time,
    schedule_end_time
FROM [jobs_internal].visible_jobs j
LEFT OUTER JOIN [jobs_internal].current_job_version_numbers cjvn
    ON j.job_id = cjvn.job_id
GO
/****** Object:  View [jobs].[job_executions]    Script Date: 6/26/2024 1:14:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [jobs].[job_executions] AS
SELECT
    JE.root_job_execution_id AS job_execution_id,
    J.name AS job_name,
    JE.job_id,
    JE.job_version_number AS job_version,
    JS.step_name,
    JE.step_id,
    JE.is_active,
    JE.lifecycle,
    JE.create_time,
    JE.start_time,
    JE.end_time,
    JE.current_task_attempts AS current_attempts,
    JTE.start_time AS current_attempt_start_time,
    do_not_retry_until_time AS next_attempt_start_time,
    CASE
        -- Error messages
        WHEN JTE.is_active = 0 AND JTE.message IS NOT NULL THEN JTE.message
        WHEN PREV_JTE.message IS NOT NULL THEN PREV_JTE.message
         -- Any tasks in Created state that haven't been dequeued by a worker yet --
        WHEN JTE.lifecycle = 'Created' THEN 'Waiting for available worker...'
        -- Root job lifecycle messages --
        WHEN JE.step_id IS NULL THEN
            CASE
                WHEN JE.lifecycle = 'Created'                      THEN 'Job execution created.'
                WHEN JE.lifecycle = 'WaitingForChildJobExecutions' THEN 'Job execution waiting for job steps to complete.'
                WHEN JE.lifecycle = 'WaitingForRetry'              THEN 'Job execution waiting for retry.'
                WHEN JE.lifecycle = 'Succeeded'                    THEN 'Job execution succeeded.'
                WHEN JE.lifecycle = 'SucceededWithSkipped'         THEN 'Job execution succeeded, but some targets were skipped.'
                WHEN JE.lifecycle = 'Skipped'                      THEN 'Job execution skipped.'
                WHEN JE.lifecycle = 'Canceled'                     THEN 'Job execution canceled.'
                WHEN JE.lifecycle = 'Failed'                       THEN 'Job execution failed.'
                WHEN JE.lifecycle = 'TimedOut'                     THEN 'Job execution timed out.'
            END
        -- Target level execution
        WHEN T.target_id IS NOT NULL THEN
            CASE
                WHEN JE.lifecycle = 'Created'
                    THEN FORMATMESSAGE('Step %i preparing execution for target (server ''%s'', database ''%s'').', JS.step_id, T.server_name, T.database_name)
                WHEN JE.lifecycle = 'InProgress'
                    THEN FORMATMESSAGE('Step %i executing on target (server ''%s'', database ''%s'').', JS.step_id, T.server_name, T.database_name)
                WHEN JE.lifecycle = 'WaitingForRetry'
                    THEN FORMATMESSAGE('Step %i waiting for retry on target (server ''%s'', database ''%s'').', JS.step_id, T.server_name, T.database_name)
                WHEN JE.lifecycle = 'Succeeded'
                    THEN FORMATMESSAGE('Step %i succeeded execution on target (server ''%s'', database ''%s'').', JS.step_id, T.server_name, T.database_name)
                WHEN JE.lifecycle = 'Canceled'
                    THEN FORMATMESSAGE('Step %i canceled execution on target (server ''%s'', database ''%s'').', JS.step_id, T.server_name, T.database_name)
                WHEN JE.lifecycle = 'Skipped'
                    THEN FORMATMESSAGE('Step %i skipped execution because a previous execution of this job is still running on this target (server ''%s'', database ''%s'').', JS.step_id, T.server_name, T.database_name)
                WHEN JE.lifecycle = 'TimedOut'
                    THEN FORMATMESSAGE('Step %i timed out on target (server ''%s'', database ''%s'').', JS.step_id, T.server_name, T.database_name)
            END
        -- Step level execution
        WHEN JE.step_id IS NOT NULL THEN
            CASE
                WHEN JE.lifecycle = 'Created'                      THEN FORMATMESSAGE('Step %i preparing targets.', JS.step_id)
                WHEN JE.lifecycle = 'InProgress'                   THEN FORMATMESSAGE('Step %i evaluating targets.', JS.step_id)
                WHEN JE.lifecycle = 'WaitingForChildJobExecutions' THEN FORMATMESSAGE('Step %i waiting for execution on targets to complete.', JS.step_id)
                WHEN JE.lifecycle = 'WaitingForRetry'              THEN FORMATMESSAGE('Step %i waiting for retry.', JS.step_id)
                WHEN JE.lifecycle = 'Succeeded'                    THEN FORMATMESSAGE('Step %i succeeded.', JS.step_id)
                WHEN JE.lifecycle = 'SucceededWithSkipped'         THEN FORMATMESSAGE('Step %i succeeded with skipped executions on some targets.', JS.step_id)
                WHEN JE.lifecycle = 'Canceled'                     THEN FORMATMESSAGE('Step %i canceled.', JS.step_id)
                WHEN JE.lifecycle = 'Skipped'                      THEN FORMATMESSAGE('Step %i skipped executions on targets.', JS.step_id)
                WHEN JE.lifecycle = 'Failed'                       THEN FORMATMESSAGE('Step %i failed.', JS.step_id)
                WHEN JE.lifecycle = 'TimedOut'                     THEN FORMATMESSAGE('Step %i timed out.', JS.step_id)
            END
    END AS last_message,
    T.target_type,
    T.target_id,
    T.subscription_id as target_subscription_id,
    T.resource_group_name as target_resource_group_name,
    T.server_name AS target_server_name,
    T.database_name AS target_database_name,
    T.elastic_pool_name AS target_elastic_pool_name

-- Only select from visible jobs
FROM [jobs_internal].visible_jobs J
INNER JOIN [jobs_internal].job_executions JE
    ON J.job_id = JE.job_id

-- Join to determine target info
LEFT OUTER JOIN [jobs_internal].targets T
    ON JE.target_id = T.target_id AND T.target_type <> 'TargetGroup'

-- Join to determine last message
LEFT OUTER JOIN [jobs_internal].job_task_executions JTE
    ON JE.last_job_task_execution_id = JTE.job_task_execution_id
LEFT OUTER JOIN [jobs_internal].job_task_executions PREV_JTE
    ON JTE.previous_job_task_execution_id = PREV_JTE.job_task_execution_id

-- Join to determine step name
LEFT OUTER JOIN [jobs_internal].jobsteps JS
    ON JE.job_id = JS.job_id
   AND JE.step_id = JS.step_id
   AND JE.job_version_number = JS.job_version_number
GO
/****** Object:  View [jobs].[jobstep_versions]    Script Date: 6/26/2024 1:14:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [jobs].[jobstep_versions] AS
SELECT
    J.name AS job_name,
    J.job_id,
    JV.job_version_number as job_version,
    JS.step_id,
    JS.step_name,

    --Action
    JSD.command_type,
    CAST(N'Inline' AS NVARCHAR(50)) AS command_source,
    CMD.text AS command,

    --Credential
    JSD.credential_name,

    --TargetGroup
    T.target_group_name,
    T.target_id AS target_group_id,

    --Execution options
    JSD.initial_retry_interval_ms / 1000 AS initial_retry_interval_seconds,
    JSD.maximum_retry_interval_ms / 1000 AS maximum_retry_interval_seconds,
    JSD.retry_interval_backoff_multiplier,
    JSD.retry_attempts,
    JSD.step_timeout_ms / 1000 AS step_timeout_seconds,

    --Result set output location
    CAST(CASE
        WHEN JSD.result_set_destination_target_id IS NULL THEN NULL
        ELSE N'SqlDatabase'
    END AS NVARCHAR(50)) AS output_type,
    JSD.result_set_destination_credential_name as output_credential_name,
    RST.subscription_id AS output_subscription_id,
    RST.resource_group_name AS output_resource_group_name,
    RST.server_name AS output_server_name,
    RST.database_name AS output_database_name,
    JSD.result_set_destination_schema_name AS output_schema_name,
    JSD.result_set_destination_table_name AS output_table_name,

    --Additional columns appended to end
    JSD.max_parallelism

FROM [jobs_internal].visible_jobs J
INNER JOIN [jobs_internal].job_versions JV
    ON J.job_id = JV.job_id
INNER JOIN [jobs_internal].jobsteps JS
    ON JV.job_id = JS.job_id AND JV.job_version_number = JS.job_version_number
INNER JOIN [jobs_internal].jobstep_data JSD
    ON JS.jobstep_data_id = JSD.jobstep_data_id
LEFT OUTER JOIN [jobs_internal].visible_target_groups T
    ON JSD.target_id = T.target_id
LEFT OUTER JOIN [jobs_internal].command_data CMD
    ON JSD.command_data_id = CMD.command_data_id
LEFT OUTER JOIN [jobs_internal].targets RST
    ON JSD.result_set_destination_target_id = RST.target_id
GO
/****** Object:  View [jobs].[jobsteps]    Script Date: 6/26/2024 1:14:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [jobs].[jobsteps] AS
SELECT js.*
FROM [jobs].jobstep_versions js
INNER JOIN [jobs_internal].current_job_version_numbers cjvn
    ON js.job_id = cjvn.job_id
   AND js.job_version = cjvn.current_job_version_number
GO
/****** Object:  View [jobs].[job_versions]    Script Date: 6/26/2024 1:14:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [jobs].[job_versions] AS
SELECT
    j.name as job_name,
    j.job_id,
    jv.job_version_number as job_version
FROM [jobs_internal].visible_jobs j
INNER JOIN [jobs_internal].job_versions jv
    ON j.job_id = jv.job_id
GO
/****** Object:  View [jobs_internal].[target_group_members_json]    Script Date: 6/26/2024 1:14:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [jobs_internal].[target_group_members_json] AS
SELECT
    PT.target_group_name,
    ISNULL (
        (
            SELECT
                IIF(M.include = 1, 'Include', 'Exclude') AS membership_type,
                target_type AS [target_type],
                subscription_id AS [subscription_id],
                resource_group_name AS [resource_group_name],
                server_name AS [server_name],
                database_name AS [database_name],
                elastic_pool_name AS [elastic_pool_name],
                shard_map_name AS [shard_map_name],
                refresh_credential_name AS [refresh_credential_name]
            FROM [jobs_internal].target_group_memberships M
            INNER JOIN [jobs_internal].visible_targets_formatted CT
                ON M.child_target_id = CT.target_id
                WHERE M.parent_target_id = PT.target_id
            ORDER BY M.child_target_id
            FOR JSON PATH
        ),
        '[]') target_group_members
FROM [jobs_internal].visible_target_groups PT
GO
/****** Object:  StoredProcedure [jobs].[sp_add_job]    Script Date: 6/26/2024 1:14:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [jobs].[sp_add_job]
    @job_name                           NVARCHAR(128),
    @description                        NVARCHAR(512) = '',
    @enabled                            BIT = 0,
    @schedule_interval_type             NVARCHAR(50) = 'Once',
    @schedule_interval_count            INT = 1,
    @schedule_start_time                DATETIME2 = '01/01/0001 00:00:00',
    @schedule_end_time                  DATETIME2 = '12/31/9999 11:59:59',
    @job_id                             UNIQUEIDENTIFIER = NULL OUTPUT
AS
BEGIN
    SET NOCOUNT ON

    SET @job_id = NEWID()
    INSERT INTO [jobs_internal].jobs( 
        job_id, 
        name,
        delete_requested_time,
        last_job_execution_id,
        description,
        is_system,
        enabled,
        schedule_start_time,
        schedule_end_time,
        schedule_interval_type,
        schedule_interval_count
    ) VALUES ( 
        @job_id,
        @job_name,
        NULL,
        NULL,
        @description,
        0,
        @enabled,
        @schedule_start_time,
        @schedule_end_time,
        @schedule_interval_type,
        @schedule_interval_count
    )
END
GO
/****** Object:  StoredProcedure [jobs].[sp_add_jobstep]    Script Date: 6/26/2024 1:14:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [jobs].[sp_add_jobstep]
    @job_name                           NVARCHAR(128),
    @step_id                            INT = NULL OUTPUT,
    @step_name                          NVARCHAR(128) = NULL,
    @command_type                       NVARCHAR(50) = 'TSql',
    @command_source                     NVARCHAR(50) = 'Inline',
    @command                            NVARCHAR(MAX),
    @credential_name                    NVARCHAR(128) = NULL,
    @target_group_name                  NVARCHAR(128),
    @initial_retry_interval_seconds     INT = 1,
    @maximum_retry_interval_seconds     INT = 120,
    @retry_interval_backoff_multiplier  REAL = 2.0,
    @retry_attempts                     INT = 10,
    @step_timeout_seconds               INT = 43200,
    @output_type                        NVARCHAR(50) = NULL,
    @output_credential_name             NVARCHAR(128) = NULL,
    @output_subscription_id             UNIQUEIDENTIFIER = NULL,
    @output_resource_group_name         NVARCHAR(128) = NULL,
    @output_server_name                 NVARCHAR(256) = NULL,
    @output_database_name               NVARCHAR(128) = NULL,
    @output_schema_name                 NVARCHAR(128) = NULL,
    @output_table_name                  NVARCHAR(128) = NULL,
    @job_version                        INT = NULL OUTPUT,
    @max_parallelism                    INT = NULL
AS
BEGIN
    SET NOCOUNT ON
    SET XACT_ABORT ON
    BEGIN TRANSACTION

    DECLARE @error_message NVARCHAR(1000)

    -- Find job_id
    DECLARE @job_id UNIQUEIDENTIFIER
    EXEC [jobs_internal].sp_lock_job @job_name, @job_id OUTPUT

    -- Insert new version into job_versions. This outputs the new version number.
    EXEC [jobs_internal].sp_add_job_version @job_id, @job_version OUTPUT

    -- Determine range of allowed step ids
    DECLARE @max_allowed_step_id INT
    SELECT @max_allowed_step_id = ISNULL(MAX(step_id), 0) + 1
    FROM [jobs].jobstep_versions
    WHERE job_id = @job_id
    AND job_version = @job_version - 1

    -- If @step_id is NULL, it means 'add a step to the end'
    IF @step_id IS NULL
    BEGIN
        SET @step_id = @max_allowed_step_id
    END

    -- Validate @step_id
    IF @step_id <= 0 OR @step_id > @max_allowed_step_id
    BEGIN
        SET @error_message = FORMATMESSAGE('Invalid value for @step_id: ''%i''. @step_id must be greater than or equal to 1 and less than or equal to ''%i''.', @step_id, @max_allowed_step_id);
        THROW 50000, @error_message, 1
    END

    -- Validate @step_name nullness
    IF @step_name IS NULL
    BEGIN
        -- For step id 1 only, we make the API more convenient by providing a default step name.
        IF @step_id = 1
        BEGIN
            SET @step_name = 'JobStep'
        END
        ELSE
        BEGIN
            SET @error_message = FORMATMESSAGE('@step_name may only be NULL for the first job step.', @step_id);
            THROW 50000, @error_message, 1
        END
    END

    -- Validate @max_parallelism
    IF @max_parallelism IS NOT NULL AND @max_parallelism < 1
    BEGIN
        SET @error_message = FORMATMESSAGE('Invalid value for @max_parallelism: ''%i''. @max_parallelism must be NULL or greater than or equal to 1.', @max_parallelism);
        THROW 50000, @error_message, 1
    END

    -- Validate @step_name uniqueness
    DECLARE @step_id_with_same_name INT
    SELECT @step_id_with_same_name = step_id
    FROM [jobs].jobstep_versions
    WHERE job_id = @job_id
    AND job_version = @job_version - 1
    AND step_name = @step_name

    IF @step_id_with_same_name IS NOT NULL
    BEGIN
        SET @error_message = FORMATMESSAGE('A step with name ''%s'' (step id ''%i'') already exists for the job ''%s''.', @step_name, @step_id_with_same_name, @job_name);
        THROW 50000, @error_message, 1
    END

    -- Insert new data into jobstep_data
    DECLARE @jobstep_data_id UNIQUEIDENTIFIER
    EXEC [jobs_internal].sp_add_jobstep_data
        @command_type,
        @command_source,
        @command,
        @credential_name,
        @target_group_name,
        @initial_retry_interval_seconds,
        @maximum_retry_interval_seconds,
        @retry_interval_backoff_multiplier,
        @retry_attempts,
        @step_timeout_seconds,
        @output_type,
        @output_credential_name,
        @output_subscription_id,
        @output_resource_group_name,
        @output_server_name,
        @output_database_name,
        @output_schema_name,
        @output_table_name,
        @jobstep_data_id OUTPUT,
        @max_parallelism

    -- Insert new step into jobsteps that link the job_versions to the jobsteps
    -- We copy existing steps to ensure (with primary key) that we aren't overwriting a step with the same id
    -- Any existing steps with step_id >= the new step's id will be bumped up by 1.
    INSERT INTO [jobs_internal].jobsteps
    -- Select existing steps
    SELECT
        job_id,
        @job_version,
        -- If existing step is equal to or greater than the new step's id,
        -- then this existing step needs its id increased by 1 to make a gap
        -- to put the new step into
        step_id + IIF(step_id >= @step_id, 1, 0),
        jobstep_data_id,
        step_name
    FROM [jobs_internal].jobsteps
    WHERE job_id = @job_id AND job_version_number = @job_version - 1
        UNION ALL
    -- Select new step
    SELECT
        @job_id,
        @job_version,
        @step_id,
        @jobstep_data_id,
        @step_name
    COMMIT TRANSACTION
END
GO
/****** Object:  StoredProcedure [jobs].[sp_add_target_group]    Script Date: 6/26/2024 1:14:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [jobs].[sp_add_target_group]
    @target_group_name      NVARCHAR(128),
    @target_group_id        UNIQUEIDENTIFIER = NULL OUTPUT
AS
BEGIN
    SET NOCOUNT ON

    DECLARE @error_message NVARCHAR(1000)

    -- Check if target group name already exists in targets --
    IF EXISTS(SELECT 1
              FROM [jobs_internal].visible_target_groups
              WHERE target_group_name = @target_group_name)
    BEGIN
        SET @error_message = FORMATMESSAGE('Target group ''%s'' already exists.', @target_group_name);
        THROW 50000, @error_message, 1
    END

    -- Concurrency plan: not needed, just fail with unique index violation if it already exists
    SET @target_group_id = NEWID()
    INSERT INTO [jobs_internal].targets (
        target_id,
        target_type,
        target_group_name
    ) VALUES (
        @target_group_id,
        'TargetGroup',
        @target_group_name
    )
END
GO
/****** Object:  StoredProcedure [jobs].[sp_add_target_group_member]    Script Date: 6/26/2024 1:14:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [jobs].[sp_add_target_group_member]
    @target_group_name          NVARCHAR(128),
    @membership_type            NVARCHAR(50) = 'Include',
    @target_type                NVARCHAR(50),
    @refresh_credential_name    NVARCHAR(128) = NULL,
    @server_name                NVARCHAR(128) = NULL,
    @database_name              NVARCHAR(128) = NULL,
    @elastic_pool_name          NVARCHAR(128) = NULL,
    @shard_map_name             NVARCHAR(128) = NULL,
    @target_id                  UNIQUEIDENTIFIER = NULL OUTPUT
AS
BEGIN
    SET NOCOUNT ON
    SET XACT_ABORT ON
    BEGIN TRANSACTION

    DECLARE @error_message NVARCHAR(1000)

    -- Determine target group id
    DECLARE @target_group_id UNIQUEIDENTIFIER
    SET @target_group_id = (
        SELECT target_id
        FROM [jobs_internal].visible_target_groups
        WHERE target_group_name = @target_group_name
    )

    -- Check if target group id is in targets table --
    IF (@target_group_id IS NULL)
    BEGIN
        SET @error_message = FORMATMESSAGE('Target group ''%s'' does not exist.', @target_group_name);
        THROW 50000, @error_message, 1
    END

    -- Insert the single target into a table variable so we can pass it as a table-valued parameter
    DECLARE @input_targets [jobs_internal].target_group_members
    INSERT INTO @input_targets VALUES (
        @membership_type,
        @target_type,
        @refresh_credential_name,
        NULL, -- subscription_id
        NULL, -- resource_group_name
        @server_name,
        @database_name,
        @elastic_pool_name,
        @shard_map_name -- shard_map_name
    )

    -- INSERT into targets or SELECT it if a matching row exists.
    DECLARE @input_memberships TABLE (
        child_target_id UNIQUEIDENTIFIER PRIMARY KEY,
        include BIT NOT NULL -- NOT NULL to cause error when membership_type string is invalid
    )
    INSERT INTO @input_memberships
    EXEC [jobs_internal].sp_add_or_get_target_group_members @input_targets

    -- Note that @input_memberships should now have exactly 1 row

    -- Check if parent group id and child group id already exist in target group memberships
    DECLARE @existing_child_id NVARCHAR(1000) =  (SELECT TOP 1 CAST(im.child_target_id AS NVARCHAR(1000))
                                                  FROM @input_memberships im, [jobs_internal].target_group_memberships tgm
                                                  WHERE im.child_target_id = tgm.child_target_id AND
                                                        tgm.parent_target_id = @target_group_id);
    IF (@existing_child_id IS NOT NULL)
    BEGIN
        SET @error_message = FORMATMESSAGE('Target group member ''%s'' already belongs to ''%s''.', @existing_child_id, @target_group_name);
        THROW 50000, @error_message, 1
    END

    -- Insert into target_group_memberships
    INSERT INTO [jobs_internal].target_group_memberships
    SELECT
        @target_group_id as parent_target_id,
        child_target_id,
        include
    FROM @input_memberships

    SELECT @target_id = child_target_id
    FROM @input_memberships

    COMMIT TRANSACTION
END
GO
/****** Object:  StoredProcedure [jobs].[sp_delete_job]    Script Date: 6/26/2024 1:14:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [jobs].[sp_delete_job]
    @job_name           NVARCHAR(128),
    @force              BIT             = 0
AS
BEGIN
    SET NOCOUNT ON
    SET XACT_ABORT ON
    BEGIN TRANSACTION

    -- Concurrency plan: acquire lock on row in first query
    DECLARE @job_id UNIQUEIDENTIFIER
    EXEC [jobs_internal].sp_lock_job @job_name, @job_id OUTPUT

    -- Find active job executions for this job --
    DECLARE @active_job_execution_ids TABLE(job_execution_ids UNIQUEIDENTIFIER)
    INSERT INTO @active_job_execution_ids
    SELECT je.root_job_execution_id
    FROM [jobs_internal].[job_executions] je
    WHERE je.job_id = @job_id AND je.is_active = 1

    -- Check if active job executions --
    IF EXISTS(SELECT 1 FROM @active_job_execution_ids)
        IF (@force = 0)
            BEGIN
                THROW 50000, 'The job could not be deleted because there are active job executions. In order to force deletion of this job and cancel its active executions, specify `@force=1`.', 1
                RETURN
            END

        -- If force delete was requested --
        BEGIN
            -- Add each active job executions for this job to the job cancellations table --
            DECLARE @active_je_id UNIQUEIDENTIFIER
            DECLARE active_je_cursor CURSOR FOR SELECT * FROM @active_job_execution_ids

            OPEN active_je_cursor
            FETCH NEXT FROM active_je_cursor INTO @active_je_id

            WHILE @@FETCH_STATUS = 0
                BEGIN
                    EXEC [jobs].[sp_stop_job] @active_je_id
                    PRINT 'Cancelled job execution with id ' + CAST(@active_je_id AS VARCHAR(128))
                    FETCH NEXT FROM active_je_cursor INTO @active_je_id
                END
            CLOSE active_je_cursor
            DEALLOCATE active_je_cursor
        END

    -- Mark the job as deleted --
    UPDATE [jobs_internal].jobs
    SET delete_requested_time = GETUTCDATE()
    WHERE job_id = @job_id

    -- Complete Transaction --
    COMMIT TRANSACTION
END
GO
/****** Object:  StoredProcedure [jobs].[sp_delete_jobstep]    Script Date: 6/26/2024 1:14:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [jobs].[sp_delete_jobstep]
    @job_name               NVARCHAR(128),
    @step_id                INT = NULL,
    @step_name              NVARCHAR(120) = NULL,
    @job_version            INT = NULL OUTPUT
AS
BEGIN
    SET NOCOUNT ON
    SET XACT_ABORT ON
    BEGIN TRANSACTION

    DECLARE @error_message NVARCHAR(1000)

    -- Find job_id
    DECLARE @job_id UNIQUEIDENTIFIER
    EXEC [jobs_internal].sp_lock_job @job_name, @job_id OUTPUT

    -- Insert new version into job_versions. This outputs the new version number.
    EXEC [jobs_internal].sp_add_job_version @job_id, @job_version OUTPUT

    -- Find the step id (by step id or by step name) and verify it exists
    EXEC [jobs_internal].sp_find_jobstep @job_id, @job_version, @step_id OUTPUT, @step_name

    -- Insert new step into jobsteps that link the job_versions to the jobsteps
    -- We copy existing steps to ensure (with primary key) that we aren't overwriting a step with the same id
    INSERT INTO [jobs_internal].jobsteps
    -- Select non-deleted steps
    SELECT
        job_id,
        @job_version,
        -- If existing step is after the deleted step's id,
        -- then this existing step needs its id decreased by 1 to fill the hole
        step_id + IIF(step_id > @step_id, -1, 0),
        jobstep_data_id,
        step_name
    FROM [jobs_internal].jobsteps
    WHERE job_id = @job_id AND job_version_number = @job_version - 1 AND step_id <> @step_id

    COMMIT TRANSACTION
END
GO
/****** Object:  StoredProcedure [jobs].[sp_delete_target_group]    Script Date: 6/26/2024 1:14:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [jobs].[sp_delete_target_group]
    @target_group_name  NVARCHAR(128),
    @force              BIT = 0
AS
BEGIN
    SET NOCOUNT ON
    SET XACT_ABORT ON

    BEGIN TRANSACTION

    -- Concurrency plan: acquire lock on row in first query

    -- Get the target group's id
    DECLARE @target_id UNIQUEIDENTIFIER
    SELECT @target_id = target_id
    FROM [jobs_internal].targets
    WITH (UPDLOCK, SERIALIZABLE, ROWLOCK)
    WHERE target_group_name = @target_group_name
      AND delete_requested_time IS NULL

    DECLARE @error_message NVARCHAR(1000)
    IF @target_id IS NULL
    BEGIN
        SET @error_message = FORMATMESSAGE('The target group ''%s'' was not found.', @target_group_name);
        THROW 50000, @error_message, 1
    END

    -- Check for job steps using this target group
    DECLARE @job_name NVARCHAR(128)
    DECLARE @step_name NVARCHAR(128)
    DECLARE @step_id INT
    DECLARE @total_steps INT

    -- Select just 1 row, but also determine the total count of rows
    SELECT TOP (1)
        @job_name = job_name,
        @step_name = step_name,
        @total_steps = COUNT(*) OVER() -- trick to get total count of rows
    FROM jobs.jobsteps
    WHERE target_group_id = @target_id

    IF @total_steps > 0
    BEGIN
        SET @error_message = FORMATMESSAGE(
            'The target group ''%s'' cannot be deleted because it is referenced by job ''%s'' step ''%s'' and %i other job step(s).',
            @target_group_name,
            @job_name,
            @step_name,
            @total_steps - 1);
        THROW 50000, @error_message, 1
    END

    -- Check for active executions using this target group
    -- We can't just search the job_executions.taget_group_name column, because the step that uses the target group
    -- might not have begun executing. So we have to search target_group_name of all steps in the version that is
    -- being executed.
    DECLARE @job_execution_id UNIQUEIDENTIFIER
    DECLARE @job_version INT
    DECLARE @total_executions INT

    -- Select just 1 row, but also determine the total count of rows
    SELECT TOP (1)
        @job_execution_id = JE.job_execution_id,
        @job_name = JSV.job_name,
        @step_name = JSV.step_name,
        @total_executions = COUNT(*) OVER() -- trick to get total count of rows
    FROM jobs.job_executions JE
    INNER JOIN jobs.jobstep_versions JSV
        ON JE.job_id = JSV.job_id AND JE.job_version = JSV.job_version
    WHERE JSV.target_group_id = @target_id
      AND JE.is_active = 1

    IF @job_execution_id IS NOT NULL
    BEGIN
        SET @error_message = FORMATMESSAGE(
            'The target group ''%s'' cannot be deleted because it is referenced by active job execution ''%s'' (job ''%s'' step ''%s'') and %i other job executions.',
            @target_group_name,
            cast(@job_execution_id as char(36)),
            @job_name,
            @step_name,
            @total_executions - 1);
        THROW 50000, @error_message, 1
    END

    -- Mark the target group for cleanup
    UPDATE [jobs_internal].targets
    SET delete_requested_time = GETUTCDATE()
    WHERE target_id = @target_id

    COMMIT TRANSACTION
END
GO
/****** Object:  StoredProcedure [jobs].[sp_delete_target_group_member]    Script Date: 6/26/2024 1:14:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [jobs].[sp_delete_target_group_member]
    @target_group_name          NVARCHAR(128),
    @target_id                  UNIQUEIDENTIFIER
AS
BEGIN
    SET NOCOUNT ON
    SET XACT_ABORT ON
    BEGIN TRANSACTION

    DELETE mem
    FROM [jobs_internal].target_group_memberships mem
    INNER JOIN [jobs_internal].visible_target_groups tg
        ON mem.parent_target_id = tg.target_id
    WHERE tg.target_group_name = @target_group_name
    AND mem.child_target_id = @target_id

    -- Ensure that we deleted exactly one row
    IF (@@ROWCOUNT <> 1)
    BEGIN
        DECLARE @error_message NVARCHAR(1000) = FORMATMESSAGE('Target with target_id ''%s'' was not found as a member of target group ''%s''', CAST(@target_id AS NCHAR(36)),@target_group_name);
        THROW 50000, @error_message, 1
    END

    COMMIT TRANSACTION
END
GO
/****** Object:  StoredProcedure [jobs].[sp_purge_jobhistory]    Script Date: 6/26/2024 1:14:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [jobs].[sp_purge_jobhistory]
    @job_name       NVARCHAR(128) = NULL,
    @job_id         UNIQUEIDENTIFIER = NULL,
    @oldest_date    DATETIME2 = NULL
AS
BEGIN
SET NOCOUNT ON;
SET XACT_ABORT ON;

DECLARE @error_message NVARCHAR(1000)

-- If we were given job_name, determine job_id
IF @job_name IS NOT NULL
BEGIN
    -- Assert that job_id is NULL, because job_id and job_name cannot both be provided
    IF @job_id IS NOT NULL
    BEGIN
        SET @error_message = '@job_name and @job_id parameters cannot both be specified';
        THROW 50000, @error_message, 1
    END

    -- Get the job with that id
    SELECT @job_id = job_id
    FROM [jobs_internal].visible_jobs
    WHERE name = @job_name

    -- Assert that job_id is NOT NULL
    IF @job_id IS NULL
    BEGIN
        SET @error_message = FORMATMESSAGE('Job ''%s'' was not found', @job_name);
        THROW 50000, @error_message, 1
    END
END
ELSE
BEGIN
    -- Assert that job_id is NOT NULL. 
    -- For now due to safety concerns we don't allow 'purge all' semantics like Sql Agent does.
    IF @job_id IS NULL
    BEGIN
        SET @error_message = '@job_name or @job_id (and not both) must be specified.';
        THROW 50000, @error_message, 1
    END
END

-- Devnote: columns below denote which table they come from (je_job_execution_id came from JobExecution table).
-- this is helpful to know since we use outer joins
DECLARE @pending_deletes TABLE(
    je_job_execution_id UNIQUEIDENTIFIER NULL,
    jte_job_task_execution_id UNIQUEIDENTIFIER NULL
)

DECLARE @did_work bit = 1;
DECLARE @loop_number int = 0;
DECLARE @rows_affected int;
WHILE (@did_work = 1)
BEGIN
    SET @loop_number = @loop_number + 1;
    SET @did_work = 0;

    DELETE FROM @pending_deletes;

    -- Devnote: Left joins below are critical for performance. The goal is to get up to 10000 rows quickly,
    -- no matter which table supplies the values. E.g. if are rows in JobTaskExecution, fine, we'll work on them,
    -- but if there aren't - also fine, we'll get to delete rows from JobExecution
    -- Devnote: it may take several passes to purge - first JobTaskExecutions, then JobExecutions.
    -- That is Ok because below query is relatively cheap.

    INSERT INTO @pending_deletes
    SELECT TOP 2000
        JE.job_execution_id,
        JTE.job_task_execution_id
    FROM
        [jobs_internal].job_executions JE
        LEFT OUTER JOIN [jobs_internal].job_task_executions JTE
            ON JTE.job_execution_id = JE.job_execution_id
        -- Enables check on parent job execution below
        LEFT OUTER JOIN [jobs_internal].job_executions ParentJE
            ON ParentJE.job_execution_id = JE.parent_job_execution_id
    WHERE 
        -- If @job_id was specified, filter by that job id
        (@job_id IS NULL OR JE.job_id = @job_id)
        -- If @oldest_date was specified, only delete job executions that ended before then
        AND (@oldest_date IS NULL OR JE.end_time < @oldest_date)
        -- Only delete inactive job executions
        AND JE.is_active = 0
        -- If there is a parent job execution, it needs to be finished.
        AND (ParentJE.lifecycle IS NULL OR ParentJE.is_active = 0)
        -- There are no child job executions (it takes two passes to delete parent job execution)
        AND NOT EXISTS (
            SELECT *
            FROM [jobs_internal].job_executions ChildJE
            WHERE ChildJE.parent_job_execution_id = JE.job_execution_id
        )
    SET @rows_affected = @@ROWCOUNT;
    IF(@rows_affected = 0)
    BEGIN
        -- There are no rows to clean up
        BREAK;
    END

    /*
    Due to self-references, it's easier to delete all JobTaskExecutions for any given JobExecution.
    So if at least one JobTaskExecution exists, we delete all JobTaskExecutions with the same JobExecution
    Devnote: we're not checking for lifecycle of JobTaskExecutions because they belong to JobExecutions which 
    are already in terminal state.
    */

    -- Level 2: JobTaskExecution

    -- a) free JobTaskExecutions we're trying to delete from reference by JobExecution
    UPDATE JE
        SET JE.last_job_task_execution_id = NULL
    FROM
        @pending_deletes del 
        INNER JOIN [jobs_internal].job_executions JE 
            ON del.je_job_execution_id = JE.job_execution_id
    WHERE
        -- Appropriate level: We have JobExecution and JobTaskExecution. 
        -- (JobExecution may have reference to JobTaskExecution we're trying to delete)
        del.je_job_execution_id IS NOT NULL AND
        del.jte_job_task_execution_id IS NOT NULL AND

        -- Only clear reference where it exists
        JE.last_job_task_execution_id IS NOT NULL

    SET @rows_affected = @@ROWCOUNT
    IF @rows_affected > 0 SET @did_work = 1

    -- b) delete
    ;WITH unique_job_executions AS
    (
        SELECT DISTINCT je_job_execution_id
        FROM @pending_deletes
        WHERE jte_job_task_execution_id IS NOT NULL
    )
    DELETE JTE
    FROM
        unique_job_executions JE 
        INNER JOIN [jobs_internal].job_task_executions JTE 
            ON JE.je_job_execution_id = JTE.job_execution_id

    SET @rows_affected = @@ROWCOUNT
    IF @rows_affected > 0 SET @did_work = 1

    -- Level 1: JobExecution

    -- a) Cancellations
    DELETE JC
    FROM
        @pending_deletes del
        INNER JOIN [jobs_internal].job_cancellations JC
            ON del.je_job_execution_id = JC.job_execution_id

    SET @rows_affected = @@ROWCOUNT
    IF @rows_affected > 0 SET @did_work = 1
    
    -- b) Disentanglement, make sure Jobs do not point to JobExecutions to be deleted
    UPDATE J
        SET J.last_job_execution_id = NULL
    FROM
        @pending_deletes del
        INNER JOIN [jobs_internal].jobs J
            ON (@job_id IS NULL OR @job_id = J.job_id)
            AND del.je_job_execution_id = J.last_job_execution_id
    WHERE 
        J.last_job_execution_id IS NOT NULL
        -- Only disentangle the last job execution for tombstoned jobs, because last job execution affects scheduling
        -- (if there is no last job execution in a certain time range then the scheduler will schedule a new execution)
        -- and we don't want to break scheduling of non-tombstoned jobs
        AND J.delete_requested_time IS NOT NULL

    SET @rows_affected = @@ROWCOUNT
    IF @rows_affected > 0 SET @did_work = 1

    DELETE JE
    FROM
        @pending_deletes del
        INNER JOIN [jobs_internal].job_executions JE
            ON del.je_job_execution_id = JE.job_execution_id
    WHERE
        -- Appropriate level: We have JobExecution, but not JobTaskExecution
        -- Devnote: Q: we just deleted JobTaskExecutions, why can't we just delete JobExecution now? 
        -- A: we deleted a batch of them, there may be more.
        -- So only when we know that there were no JobTaskExecutions, it is safe to delete JobExecution.
        del.je_job_execution_id IS NOT NULL
        AND del.jte_job_task_execution_id IS NULL
        -- Do not delete the last job execution for non-tombstoned jobs, because last job execution affects scheduling
        -- At this point we can't delete them anyway due to foreign key that we intentionally didn't disentangle earlier
        AND JE.job_execution_id NOT IN (
            SELECT last_job_execution_id
            FROM [jobs_internal].visible_jobs
            -- This next line is important, otherwise a row with NULL value for last_job_execution_id would cause
            -- the entire NOT IN to evaluate to UNKNOWN, so no job executions would ever be deleted
            WHERE last_job_execution_id IS NOT NULL
        )

    SET @rows_affected = @@ROWCOUNT
    IF @rows_affected > 0 SET @did_work = 1

    WAITFOR DELAY '00:00:00.500'
END
END
GO
/****** Object:  StoredProcedure [jobs].[sp_start_job]    Script Date: 6/26/2024 1:14:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [jobs].[sp_start_job]
    @job_name           NVARCHAR(128),
    @job_execution_id   UNIQUEIDENTIFIER = NULL OUTPUT
AS
BEGIN
    SET NOCOUNT ON
    SET XACT_ABORT ON
    BEGIN TRANSACTION

    DECLARE @job_id UNIQUEIDENTIFIER
    EXEC [jobs_internal].sp_lock_job @job_name, @job_id OUTPUT

    DECLARE @error_message NVARCHAR(1000)
    IF @job_id IS NULL
    BEGIN
        SET @error_message = FORMATMESSAGE('Job ''%s'' was not found.', @job_name);
        THROW 50000, @error_message, 1
    END

    -- Determine job version number
    DECLARE @job_version INT
    SELECT @job_version = current_job_version_number
    FROM [jobs_internal].current_job_version_numbers
    WHERE job_id = @job_id

    IF NOT EXISTS(
        SELECT * FROM [jobs].jobsteps JS
        WHERE JS.job_name = @job_name
        AND JS.job_version = @job_version)
    BEGIN
        SET @error_message = FORMATMESSAGE('Job ''%s'' contains no steps.', @job_name);
        THROW 50000, @error_message, 1
    END

    IF @job_execution_id IS NOT NULL
    BEGIN
        IF EXISTS(
            SELECT * from [jobs].job_executions
            WHERE job_execution_id = @job_execution_id)
        BEGIN
            DECLARE @id_error_message NVARCHAR(1000) = FORMATMESSAGE('Job Execution with id ''%s'' already exists.', convert(nvarchar(50), @job_execution_id));
            THROW 50000, @id_error_message, 1
        END
    END

    SET @job_execution_id = ISNULL(@job_execution_id, NEWID())
    INSERT INTO [jobs_internal].job_executions (
        job_execution_id,
        job_id,
        job_version_number,
        step_id,
        create_time,
        start_time,
        end_time,
        infrastructure_failures,
        current_task_attempts,
        next_retry_delay_ms,
        lifecycle,
        is_active,
        target_id,
        parent_job_execution_id,
        root_job_execution_id,
        initiated_for_schedule_time
    ) VALUES (
        @job_execution_id,
        @job_id,
        @job_version,
        NULL,
        GETUTCDATE(),
        NULL,
        NULL,
        0,
        0,
        0,
        'Created',
        1,
        NULL,
        NULL,
        @job_execution_id,
        NULL
    )

    COMMIT TRANSACTION
END
GO
/****** Object:  StoredProcedure [jobs].[sp_stop_job]    Script Date: 6/26/2024 1:14:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [jobs].[sp_stop_job]
    @job_execution_id UNIQUEIDENTIFIER
AS
BEGIN
    SET NOCOUNT ON
    -- Concurrency plan: acquire lock on JobCancellation.JobExecutionId in first query

    IF NOT EXISTS ( 
        SELECT 1 
        FROM [jobs_internal].job_cancellations
        WITH (UPDLOCK, SERIALIZABLE, ROWLOCK) 
        WHERE job_execution_id = @job_execution_id 
    )
    BEGIN
        INSERT INTO [jobs_internal].job_cancellations ( 
            job_execution_id, 
            requested_time 
        ) VALUES ( 
            @job_execution_id, 
            SYSUTCDATETIME() 
        )
    END
END
GO
/****** Object:  StoredProcedure [jobs].[sp_update_job]    Script Date: 6/26/2024 1:14:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [jobs].[sp_update_job]
    @job_name                           NVARCHAR(128),
    @new_name                           NVARCHAR(128) = NULL,
    @description                        NVARCHAR(512) = NULL,
    @enabled                            BIT = NULL,
    @schedule_interval_type             NVARCHAR(50) = NULL,
    @schedule_interval_count            INT = NULL,
    @schedule_start_time                DATETIME2 = NULL,
    @schedule_end_time                  DATETIME2 = NULL
AS
BEGIN
    SET NOCOUNT ON
    SET XACT_ABORT ON
    BEGIN TRANSACTION

    DECLARE @job_id UNIQUEIDENTIFIER
    EXEC [jobs_internal].sp_lock_job @job_name, @job_id OUTPUT

    UPDATE [jobs_internal].jobs
    SET 
        name = ISNULL(@new_name, name),
        description = ISNULL(@description, description),
        enabled = ISNULL(@enabled, enabled),
        schedule_start_time = ISNULL(@schedule_start_time, schedule_start_time),
        schedule_end_time = ISNULL(@schedule_end_time, schedule_end_time),
        schedule_interval_type = ISNULL(@schedule_interval_type, schedule_interval_type),
        schedule_interval_count = ISNULL(@schedule_interval_count, schedule_interval_count)
    WHERE job_id = @job_id

    COMMIT TRANSACTION
END
GO
/****** Object:  StoredProcedure [jobs].[sp_update_jobstep]    Script Date: 6/26/2024 1:14:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [jobs].[sp_update_jobstep]
    @job_name                           NVARCHAR(128),
    @step_id                            INT = NULL,
    @step_name                          NVARCHAR(128) = NULL,
    @new_id                             INT = NULL,
    @new_name                           NVARCHAR(128) = NULL,
    @command_type                       NVARCHAR(50) = NULL,
    @command_source                     NVARCHAR(50) = NULL,
    @command                            NVARCHAR(MAX) = NULL,
    @credential_name                    NVARCHAR(128) = NULL,
    @target_group_name                  NVARCHAR(128) = NULL,
    @initial_retry_interval_seconds     INT = NULL,
    @maximum_retry_interval_seconds     INT = NULL,
    @retry_interval_backoff_multiplier  REAL = NULL,
    @retry_attempts                     INT = NULL,
    @step_timeout_seconds               INT = NULL,
    @output_type                        NVARCHAR(50) = NULL,
    @output_credential_name             NVARCHAR(128) = NULL,
    @output_server_name                 NVARCHAR(256) = NULL,
    @output_subscription_id             UNIQUEIDENTIFIER = NULL,
    @output_resource_group_name         NVARCHAR(128) = NULL,
    @output_database_name               NVARCHAR(128) = NULL,
    @output_schema_name                 NVARCHAR(128) = NULL,
    @output_table_name                  NVARCHAR(128) = NULL,
    @job_version                        INT = NULL OUTPUT,
    @max_parallelism                    INT = NULL
AS
BEGIN
    SET NOCOUNT ON
    SET XACT_ABORT ON
    BEGIN TRANSACTION

    DECLARE @error_message NVARCHAR(1000)

    -- Find job_id
    DECLARE @job_id UNIQUEIDENTIFIER
    EXEC [jobs_internal].sp_lock_job @job_name, @job_id OUTPUT

    -- Insert new version into job_versions. This outputs the new version number.
    EXEC [jobs_internal].sp_add_job_version @job_id, @job_version OUTPUT

    -- Find the step id (by step id or by step name) and verify it exists
    EXEC [jobs_internal].sp_find_jobstep @job_id, @job_version, @step_id OUTPUT, @step_name

    -- Determine range of allowed step ids
    DECLARE @max_allowed_step_id INT
    SELECT @max_allowed_step_id = ISNULL(MAX(step_id), 1)
    FROM [jobs].jobstep_versions
    WHERE job_id = @job_id
    AND job_version = @job_version - 1

    -- Validate @new_id
    IF @new_id <= 0 OR @new_id > @max_allowed_step_id
    BEGIN
        SET @error_message = FORMATMESSAGE('Invalid value for @new_id: ''%i''. @new_id must be greater than or equal to 1 and less than or equal to ''%i''.', @new_id, @max_allowed_step_id);
        THROW 50000, @error_message, 1
    END

    -- Validate @new_name uniqueness
    IF @new_name IS NOT NULL
    BEGIN
        DECLARE @step_id_with_same_name INT
        SELECT @step_id_with_same_name = step_id
        FROM [jobs].jobstep_versions
        WHERE job_id = @job_id
        AND job_version = @job_version - 1
        AND step_name = @new_name

        IF @step_id_with_same_name IS NOT NULL
        BEGIN
            SET @error_message = FORMATMESSAGE('A step with name ''%s'' (step id ''%i'') already exists for the job ''%s''.', @new_name, @step_id_with_same_name, @job_name);
            THROW 50000, @error_message, 1
        END
    END

    -- Validate @max_parallelism
    IF @max_parallelism IS NOT NULL AND (@max_parallelism = 0 or @max_parallelism < -1)
    BEGIN
        SET @error_message = FORMATMESSAGE('Invalid value for @max_parallelism: ''%i''. @max_parallelism must be NULL (indicating no change), -1 (meaning that it will be set to NULL), or greater than or equal to 1.', @max_parallelism);
        THROW 50000, @error_message, 1
    END

    -- If any parameters were null, then set them to the jobstep's current value (so the field does not change)
    --
    -- For output fields (which, unlike all other jobstep fields, are nullable),
    -- '' param value means 'set the field to null', and null param value still means 'leave it unchanged'
    --
    -- For max parallelism (which is also nullable), -1 means 'set the field to null', and null param value
    -- means 'leave it unchanged'.
    SELECT
        @new_id = ISNULL(@new_id, step_id),
        @new_name = ISNULL(@new_name, step_name),
        @command_type = ISNULL(@command_type, command_type),
        @command_source = ISNULL(@command_source, command_source),
        @command = ISNULL(@command, command),
        @credential_name = ISNULL(@credential_name, credential_name),
        @target_group_name = ISNULL(@target_group_name, target_group_name),
        @initial_retry_interval_seconds = ISNULL(@initial_retry_interval_seconds, initial_retry_interval_seconds),
        @maximum_retry_interval_seconds = ISNULL(@maximum_retry_interval_seconds, maximum_retry_interval_seconds),
        @retry_interval_backoff_multiplier = ISNULL(@retry_interval_backoff_multiplier, retry_interval_backoff_multiplier),
        @retry_attempts = ISNULL(@retry_attempts, retry_attempts),
        @step_timeout_seconds = ISNULL(@step_timeout_seconds, step_timeout_seconds),
        @output_type = CASE @output_type
            WHEN '' THEN NULL
            ELSE ISNULL(@output_type, output_type) END,
        @output_credential_name = CASE @output_credential_name
            WHEN '' THEN NULL
            ELSE ISNULL(@output_credential_name, output_credential_name) END,
        @output_subscription_id = CASE @output_subscription_id
            WHEN '00000000-0000-0000-0000-000000000000' THEN NULL
            ELSE ISNULL(@output_subscription_id, output_subscription_id) END,
        @output_resource_group_name = CASE @output_resource_group_name
            WHEN '' THEN NULL
            ELSE ISNULL(@output_resource_group_name, output_resource_group_name) END,
        @output_server_name = CASE @output_server_name
            WHEN '' THEN NULL
            ELSE ISNULL(@output_server_name, output_server_name) END,
        @output_database_name = CASE @output_database_name
            WHEN '' THEN NULL
            ELSE ISNULL(@output_database_name, output_database_name) END,
        @output_schema_name = CASE @output_schema_name
            WHEN '' THEN NULL
            ELSE ISNULL(@output_schema_name, output_schema_name) END,
        @output_table_name = CASE @output_table_name
            WHEN '' THEN NULL
            ELSE ISNULL(@output_table_name, output_table_name) END,
        @max_parallelism = CASE @max_parallelism
            WHEN -1 then NULL
            ELSE ISNULL(@max_parallelism, max_parallelism) END
    FROM [jobs].jobstep_versions JS
    WHERE JS.job_id = @job_id
    AND JS.job_version = @job_version - 1
    AND JS.step_id = @step_id

    -- Insert new data into jobstep_data
    DECLARE @jobstep_data_id UNIQUEIDENTIFIER
    EXEC [jobs_internal].sp_add_jobstep_data
        @command_type,
        @command_source,
        @command,
        @credential_name,
        @target_group_name,
        @initial_retry_interval_seconds,
        @maximum_retry_interval_seconds,
        @retry_interval_backoff_multiplier,
        @retry_attempts,
        @step_timeout_seconds,
        @output_type,
        @output_credential_name,
        @output_subscription_id,
        @output_resource_group_name,
        @output_server_name,
        @output_database_name,
        @output_schema_name,
        @output_table_name,
        @jobstep_data_id OUTPUT,
        @max_parallelism

    -- Insert new step into jobsteps that link the job_versions to the jobsteps
    -- We copy existing steps to ensure (with primary key) that we aren't overwriting a step with the same id
    INSERT INTO [jobs_internal].jobsteps
    -- Select non-updated steps
    SELECT
        job_id,
        @job_version,
        CASE
            -- Non-updated step is both before both the updated step's old & new id: no change
            WHEN step_id < @step_id AND step_id < @new_id THEN step_id

            -- Non-updated step is after the updated step's old id but before or equal
            -- to the updated step's new id: slide down 1
            -- This case will only happen if @step_id < @new_id, i.e.
            -- the updated step is being moved to later - in this case, the non-updated
            -- steps in between need to slide down to fill the gap left by
            -- the old step id and make a gap for the new step id
            WHEN @step_id < step_id AND step_id <= @new_id THEN step_id - 1

            -- Non-updated step is after the updated step's news id but before or equal
            -- to the updated step's old id: slide down 1
            -- This case will only happen if @new_id < @step_id , i.e.
            -- the updated step is being moved to earlier - in this case, the non-updated
            -- steps in between need to slide up to fill the gap left by
            -- the old step id and make a gap for the new step id
            WHEN @new_id <= step_id AND step_id < @step_id THEN step_id + 1

            -- After both old & new id: no change
            WHEN @step_id < step_id AND @new_id < step_id THEN step_id

            -- 'ELSE' should never happen, if it does then the value of this expression
            -- will be null and the insert should receive a null value error
        END,
        jobstep_data_id,
        step_name
    FROM [jobs_internal].jobsteps
    WHERE job_id = @job_id AND job_version_number = @job_version - 1 AND step_id <> @step_id
        UNION ALL
    -- Select updated step
    SELECT
        @job_id,
        @job_version,
        @new_id,
        @jobstep_data_id,
        @new_name

    COMMIT TRANSACTION
END
GO
/****** Object:  StoredProcedure [jobs_internal].[sp_add_job_version]    Script Date: 6/26/2024 1:14:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [jobs_internal].[sp_add_job_version]
    @job_id             UNIQUEIDENTIFIER,
    @job_version_number INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON
    SET XACT_ABORT ON
    BEGIN TRANSACTION

    SELECT @job_version_number = ISNULL(MAX(job_version_number), 0) + 1
        FROM [jobs_internal].job_versions
        WHERE job_id = @job_id

    INSERT INTO [jobs_internal].job_versions (
        job_id,
        job_version_number
    ) VALUES (
        @job_id,
        @job_version_number
    )

    COMMIT TRANSACTION
END
GO
/****** Object:  StoredProcedure [jobs_internal].[sp_add_jobstep_data]    Script Date: 6/26/2024 1:14:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [jobs_internal].[sp_add_jobstep_data]
    @command_type                       NVARCHAR(50),
    @command_source                     NVARCHAR(50),
    @command                            NVARCHAR(MAX),
    @credential_name                    NVARCHAR(128) = NULL,
    @target_group_name                  NVARCHAR(128),
    @initial_retry_interval_seconds     INT,
    @maximum_retry_interval_seconds     INT,
    @retry_interval_backoff_multiplier  REAL,
    @retry_attempts                     INT,
    @step_timeout_seconds               INT,
    @output_type                        NVARCHAR(50),
    @output_credential_name             NVARCHAR(128) = NULL,
    @output_subscription_id             UNIQUEIDENTIFIER,
    @output_resource_group_name         NVARCHAR(128),
    @output_server_name                 NVARCHAR(256),
    @output_database_name               NVARCHAR(128),
    @output_schema_name                 NVARCHAR(128),
    @output_table_name                  NVARCHAR(128),
    @jobstep_data_id                    UNIQUEIDENTIFIER OUTPUT,
    @max_parallelism                    INT
AS
BEGIN
    SET NOCOUNT ON
    SET XACT_ABORT ON
    BEGIN TRANSACTION

    DECLARE @error_message NVARCHAR(1000)

    -- Validate parameters
    -- Need to manually validate @command_source since it isn't actually stored so we have no constraints in physical tables
    IF @command_source <> 'Inline'
    BEGIN
        SET @error_message = FORMATMESSAGE('Invalid value for @command_source: ''%s''', @command_source);
        THROW 50000, @error_message, 1
    END
    IF @output_type IS NOT NULL AND @output_type <> 'SqlDatabase'
    BEGIN
        SET @error_message = FORMATMESSAGE('Invalid value for @output_type: ''%s''. Only NULL or ''SqlDatabase'' are supported.', @output_type);
        THROW 50000, @error_message, 1
    END

    -- Insert into CommandData
    DECLARE @command_data_id UNIQUEIDENTIFIER
    -- Try to find an existing command data that matches. Optimize by searching with checksum.
    -- In case of earlier bug where duplicate was inserted, select top 1 instead of all
    -- BINARY_CHECKSUM is not a great checksum function, for example it seems to produce the
    -- same results when trailing whitespace is added. Also we want to look for an exact
    -- binary match regardless of the db's collation (which might be whitespace/accent/case
    -- insensitive).
    SET @command_data_id = (
        SELECT TOP 1 command_data_id
        FROM [jobs_internal].command_data
        WHERE text_checksum = BINARY_CHECKSUM(@command)
        AND CAST(text AS VARBINARY(MAX)) = CAST(@command AS VARBINARY(MAX))
    )
    IF @command_data_id IS NULL
    BEGIN
        -- Matching command data was not found, so insert a new one.
        SET @command_data_id = NEWID()
        INSERT INTO [jobs_internal].command_data (
            command_data_id,
            script_has_been_split,
            text
        ) VALUES (
            @command_data_id,
            0,
            @command
        )
    END

    -- Determine TargetId
    DECLARE @target_id UNIQUEIDENTIFIER
    SET @target_id = (
        SELECT target_id
        FROM [jobs_internal].visible_target_groups
        WHERE target_group_name = @target_group_name
    )
    IF @target_id IS NULL
    BEGIN
        SET @error_message = FORMATMESSAGE('Target Group ''%s'' not found', @target_group_name);
        THROW 50000, @error_message, 1
    END

    -- Check credential can be referenced
    IF ISNULL([jobs_internal].fn_has_credential_perms(@credential_name), 0) = 0
    BEGIN
        SET @error_message = FORMATMESSAGE('Cannot reference the credential ''%s'', because it does not exist or you do not have permission.', @credential_name);
        THROW 50000, @error_message, 1
    END

    -- Add or get output target and get output credential
    DECLARE @output_target_id UNIQUEIDENTIFIER
    DECLARE @output_credential_id INT
    IF @output_type IS NOT NULL
    BEGIN
        -- TODO: can we combine this logic with the add taget group member logic to reduce duplication?
        SET @output_target_id = (
            SELECT target_id
            FROM [jobs_internal].targets
            WHERE target_type = 'SqlDatabase'
              AND ((subscription_id IS NULL AND @output_subscription_id IS NULL) OR subscription_id = @output_subscription_id)
              AND ((resource_group_name IS NULL AND @output_resource_group_name IS NULL) OR resource_group_name = @output_resource_group_name)
              AND elastic_pool_name IS NULL
              AND server_name = @output_server_name
              AND database_name = @output_database_name
        )
        IF @output_target_id IS NULL
        BEGIN
            SET @output_target_id = NEWID()
            INSERT INTO [jobs_internal].targets (
                target_id,
                target_type,
                subscription_id,
                resource_group_name,
                server_name,
                database_name
            ) VALUES (
                @output_target_id,
                'SqlDatabase',
                @output_subscription_id,
                @output_resource_group_name,
                @output_server_name,
                @output_database_name
            )
        END

        -- Check credential can be referenced
        IF ISNULL([jobs_internal].fn_has_credential_perms(@output_credential_name), 0) = 0
        BEGIN
            SET @error_message = FORMATMESSAGE('Cannot reference the credential ''%s'', because it does not exist or you do not have permission.', @output_credential_name);
            THROW 50000, @error_message, 1
        END
    END

    -- Insert into JobStepData
    SET @jobstep_data_id = NEWID()
    INSERT INTO [jobs_internal].jobstep_data
    SELECT
        @jobstep_data_id,
        @command_type,
        @output_target_id,
        @output_credential_name,
        CASE
            WHEN @output_type IS NULL          THEN NULL
            WHEN @output_schema_name IS NULL   THEN 'dbo'
            ELSE                               @output_schema_name
        END,
        @output_table_name,
        @command_data_id,
        @credential_name,
        @target_id,
        @initial_retry_interval_seconds * 1000,
        @maximum_retry_interval_seconds * 1000,
        @retry_interval_backoff_multiplier,
        @retry_attempts,
        @step_timeout_seconds * 1000,
        @max_parallelism

    COMMIT TRANSACTION
END
GO
/****** Object:  StoredProcedure [jobs_internal].[sp_add_or_get_target_group_members]    Script Date: 6/26/2024 1:14:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE[jobs_internal].[sp_add_or_get_target_group_members]
    @target_group_members[jobs_internal].target_group_members READONLY
AS
BEGIN
    SET NOCOUNT ON
    SET XACT_ABORT ON
    DECLARE @error_message NVARCHAR(1000)
    DECLARE @invalid_target_type NVARCHAR(900) = (SELECT TOP 1 target_type
                                                  FROM @target_group_members
                                                  WHERE target_type NOT IN('SqlDatabase',
                                                                            'SqlElasticPool',
                                                                            'SqlServer',
                                                                            'SqlShardMap'));
            --Checks that the target types are all valid--
                IF(@invalid_target_type IS NOT NULL)
                BEGIN
                    SET @error_message = FORMATMESSAGE('Target type ''%s'' is invalid.', @invalid_target_type);
            THROW 50000, @error_message, 1
                END

                -- SqlDatabase Required Parameters--
                IF EXISTS(SELECT 1
                          FROM @target_group_members
                          WHERE target_type = 'SqlDatabase' AND
                                (server_name IS NULL OR database_name IS NULL))
                BEGIN
                    SET @error_message = FORMATMESSAGE('Target type ''SqlDatabase'' requires server name and database name properties to be specified.');
            THROW 50000, @error_message, 1
                END

                -- SqlDatabase Forbidden Parameters--
                IF EXISTS(SELECT 1
                          FROM @target_group_members
                          WHERE target_type = 'SqlDatabase' AND
                                (refresh_credential_name IS NOT NULL
                                 OR elastic_pool_name IS NOT NULL
                                 OR shard_map_name IS NOT NULL))
                BEGIN
                    SET @error_message = FORMATMESSAGE('Target type ''SqlDatabase'' does not support the refresh credential, elastic pool name, or shard map name property.');
            THROW 50000, @error_message, 1
                END

                -- SqlServer Required Parameters--
                IF EXISTS(SELECT 1
                          FROM @target_group_members
                          WHERE target_type = 'SqlServer' AND
                                (server_name IS NULL))
                BEGIN
                    SET @error_message = FORMATMESSAGE('Target type ''SqlServer'' requires server name property to be specified.');
            THROW 50000, @error_message, 1
                END

                -- SqlServer Forbidden Parameters--
                IF EXISTS(SELECT 1
                          FROM @target_group_members
                          WHERE target_type = 'SqlServer' AND
                                (database_name IS NOT NULL OR elastic_pool_name IS NOT NULL OR shard_map_name IS NOT NULL))
                BEGIN
                    SET @error_message = FORMATMESSAGE('Target type ''SqlServer'' does not support the database name, elastic pool name, or shard map name property.');
            THROW 50000, @error_message, 1
                END

                -- SqlElasticPool Required Parameters--
                IF EXISTS(SELECT 1
                          FROM @target_group_members
                          WHERE target_type = 'SqlElasticPool' AND
                                (server_name IS NULL OR elastic_pool_name IS NULL))
                BEGIN
                    SET @error_message = FORMATMESSAGE('Target type ''SqlElasticPool'' requires server name and elastic pool name properties to be specified.');
            THROW 50000, @error_message, 1
                END

                -- SqlElasticPool Forbidden Parameters--
                IF EXISTS(SELECT 1
                          FROM @target_group_members
                          WHERE target_type = 'SqlElasticPool' AND
                                (database_name IS NOT NULL OR shard_map_name IS NOT NULL))
                BEGIN
                    SET @error_message = FORMATMESSAGE('Target type ''SqlElasticPool'' does not support the database name or shard map name property.');
            THROW 50000, @error_message, 1
                END


                -- SqlShardMap Required Parameters--
                IF EXISTS(SELECT 1
                          FROM @target_group_members
                          WHERE target_type = 'SqlShardMap' AND
                                (server_name IS NULL OR database_name IS NULL OR shard_map_name IS NULL OR refresh_credential_name IS NULL))
                BEGIN
                    SET @error_message = FORMATMESSAGE('Target type ''SqlShardMap'' requires server name, database name, shard map name, and refresh credential name properties to be specified.');
            THROW 50000, @error_message, 1
                END

                -- SqlShardMap Forbidden Parameters --
                IF EXISTS(SELECT 1
                        FROM @target_group_members
                        WHERE target_type = 'SqlShardMap' AND
                        (elastic_pool_name IS NOT NULL))
                BEGIN
                    SET @error_message = FORMATMESSAGE('Target type ''SqlShardMap'' does not support the elastic pool name property.');
                    THROW 50000, @error_message, 1
                END

                -- Verify that all credentials can be referenced
                DECLARE @forbidden_credentials NVARCHAR(900)

                SELECT @forbidden_credentials = COALESCE(@forbidden_credentials + ', ', '') + refresh_credential_name
                FROM @target_group_members
                WHERE[jobs_internal].fn_has_credential_perms(refresh_credential_name) = 0

                IF @forbidden_credentials IS NOT NULL
                BEGIN
                    SET @error_message = FORMATMESSAGE('Cannot reference the credential(s) ''%s'', because they do not exist or you do not have permission.', @forbidden_credentials);
            THROW 50000, @error_message, 1
                END

                -- Dummy variable to help with merge output
                DECLARE @WasUpdated BIT

                --For each target in @input_targets, INSERT it into targets or SELECT it if a matching row exists.

               -- By design we never UPDATE, because targets are considered to be immutable values.
                --Treating targets as immutable means we avoid bugs where modifying members of one target group
               -- accidentally affects the members of another target group.
                MERGE INTO[jobs_internal].targets existing_targets
                USING(
                    SELECT
                        t.*,
                        CASE t.membership_type
                            WHEN 'Include' THEN CAST(1 AS BIT)
                            WHEN 'Exclude' THEN CAST(0 AS BIT)
                            ELSE NULL-- This will intentionally cause an error later when we try to insert into target_group_memberships
                        END AS include
                    FROM @target_group_members t
                    LEFT OUTER JOIN[jobs_internal].database_credentials c
                       ON c.name = t.refresh_credential_name COLLATE SQL_Latin1_General_CP1_CI_AS
                ) AS input_targets
                --Match input targets' fields with existing targets' fields
               ON existing_targets.target_type = input_targets.target_type
                    AND(existing_targets.subscription_id = input_targets.subscription_id
                        OR(existing_targets.subscription_id IS NULL AND input_targets.subscription_id IS NULL))
                    AND(existing_targets.resource_group_name = input_targets.resource_group_name
                        OR(existing_targets.resource_group_name IS NULL AND input_targets.resource_group_name IS NULL))
                    AND(existing_targets.server_name = input_targets.server_name
                        OR(existing_targets.server_name IS NULL AND input_targets.server_name IS NULL))
                    AND(existing_targets.database_name = input_targets.database_name
                        OR(existing_targets.database_name IS NULL AND input_targets.database_name IS NULL))
                    AND(existing_targets.elastic_pool_name = input_targets.elastic_pool_name
                        OR(existing_targets.elastic_pool_name IS NULL AND input_targets.elastic_pool_name IS NULL))
                    AND(existing_targets.shard_map_name = input_targets.shard_map_name
                        OR(existing_targets.shard_map_name IS NULL AND input_targets.shard_map_name IS NULL))
                    AND(existing_targets.refresh_credential_name = input_targets.refresh_credential_name
                        OR(existing_targets.refresh_credential_name IS NULL AND input_targets.refresh_credential_name IS NULL))
                WHEN NOT MATCHED BY TARGET THEN
                    --Target doesn't exist. Add it.
                    INSERT(
                        target_id,
                        target_type,
                        subscription_id,
                        resource_group_name,
                        server_name,
                        database_name,
                        elastic_pool_name,
                        shard_map_name,
                        refresh_credential_name
                    ) VALUES(
                        NEWID(),
                        target_type,
                        subscription_id,
                        resource_group_name,
                        server_name,
                        database_name,
                        elastic_pool_name,
                        shard_map_name,
                        refresh_credential_name
                    )
                WHEN MATCHED THEN
                    -- Target already exists.Do dummy update so that it's considered 'updated', which will make it show up
                   -- in the output clase
                   UPDATE SET @WasUpdated = 1
               -- Output the target ids and their membership type for ALL child targets
               -- Note that in MERGE OUTPUT, INSERTED includes rows that were both
               -- NOT MATCHED(and then inserted - giving us the targets that didn't exist yet)
               -- and rows that were MATCHED(and updated - giving us the targets that did already exist).

               OUTPUT INSERTED.target_id AS child_target_id, input_targets.include;
            END
GO
/****** Object:  StoredProcedure [jobs_internal].[sp_add_or_replace_target_group]    Script Date: 6/26/2024 1:14:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [jobs_internal].[sp_add_or_replace_target_group]
    @target_group_name      NVARCHAR(128),
    @target_group_members   NVARCHAR(MAX)
AS
BEGIN
    SET NOCOUNT ON
    SET XACT_ABORT ON
    BEGIN TRANSACTION

    -- Unpack input json into table
    DECLARE @input_targets [jobs_internal].target_group_members
    INSERT INTO @input_targets
    SELECT
        JSON_VALUE(value, '$.membership_type') AS membership_type,
        JSON_VALUE(value, '$.target_type') AS target_type,
        JSON_VALUE(value, '$.refresh_credential_name') AS refresh_credential_name,
        CAST(JSON_VALUE(value, '$.subscription_id') AS UNIQUEIDENTIFIER) AS subscription_id,
        JSON_VALUE(value, '$.resource_group_name') AS resource_group_name,
        JSON_VALUE(value, '$.server_name') AS server_name,
        JSON_VALUE(value, '$.database_name') AS database_name,
        JSON_VALUE(value, '$.elastic_pool_name') AS elastic_pool_name,
        JSON_VALUE(value, '$.shard_map_name') AS shard_map_name
    FROM OPENJSON(@target_group_members, '$')

    -- Disallowing nested Target Groups
    IF EXISTS(SELECT * FROM @input_targets WHERE target_type = 'TargetGroup')
    BEGIN
        THROW 50000, 'Target groups may not contain other target groups.', 1
    END

    -- Concurrency plan: acquire lock on group_name + target_type in first query

    DECLARE @target_group_id UNIQUEIDENTIFIER
    SET @target_group_id = (
        SELECT target_id
        FROM [jobs_internal].visible_target_groups
        WITH (UPDLOCK, SERIALIZABLE, ROWLOCK)
        WHERE target_group_name = @target_group_name
    )
    IF @target_group_id IS NULL
    BEGIN
        SET @target_group_id = NEWID()
        INSERT INTO [jobs_internal].targets (
            target_id,
            target_type,
            target_group_name
        ) VALUES (
            @target_group_id,
            'TargetGroup',
            @target_group_name
        )
    END

    -- For each target in @input_targets, INSERT it into targets or SELECT it if a matching row exists.
    DECLARE @input_memberships TABLE (
        child_target_id UNIQUEIDENTIFIER PRIMARY KEY,
        include BIT NOT NULL -- NOT NULL to cause error when membership_type string is invalid
    )
    INSERT INTO @input_memberships
    EXEC [jobs_internal].sp_add_or_get_target_group_members @input_targets

    -- Merge TargetGroupMemberships.

    -- Remove memberships that shouldn't exist
    DELETE FROM [jobs_internal].target_group_memberships
    WHERE parent_target_id = @target_group_id
    AND child_target_id NOT IN (
        SELECT child_target_id
        FROM @input_memberships
    )

    -- Add/update memberships that should exist
    MERGE INTO [jobs_internal].target_group_memberships existing_memberships
    USING @input_memberships input_memberships
    ON existing_memberships.parent_target_id = @target_group_id
        AND existing_memberships.child_target_id = input_memberships.child_target_id
    WHEN NOT MATCHED BY TARGET THEN
        -- value in input_memberships that is not in existing_memberships
        INSERT (
            parent_target_id,
            child_target_id,
            include
        ) VALUES (
            @target_group_id,
            input_memberships.child_target_id,
            input_memberships.include
        )
    WHEN MATCHED THEN
        -- value in both sets
        UPDATE SET include = input_memberships.include
    ;

    COMMIT TRANSACTION
END
GO
/****** Object:  StoredProcedure [jobs_internal].[sp_add_or_update_job]    Script Date: 6/26/2024 1:14:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [jobs_internal].[sp_add_or_update_job]
    @job_name                           NVARCHAR(128),
    @enabled                            BIT,
    @schedule_interval_type             NVARCHAR(50),
    @schedule_interval_count            INT,
    @schedule_start_time                DATETIME2,
    @schedule_end_time                  DATETIME2,
    @updated                            BIT = NULL OUTPUT
AS
BEGIN
    SET NOCOUNT ON
    SET XACT_ABORT ON
    BEGIN TRANSACTION
    -- Concurrency plan: acquire lock on Job.Name in first query

    -- Insert into Job, or select existing Job
    -- Not using sp_lock_job because that throws if Job doesn't exist
    DECLARE @job_id UNIQUEIDENTIFIER
    SELECT @job_id = job_id
        FROM [jobs_internal].visible_jobs
        WITH (ROWLOCK, UPDLOCK, SERIALIZABLE)
        WHERE name = @job_name

    IF @job_id IS NULL
    BEGIN
        SET @updated = 0
        EXEC [jobs].sp_add_job
            @job_name = @job_name,
            @enabled = @enabled,
            @schedule_start_time = @schedule_start_time,
            @schedule_end_time = @schedule_end_time,
            @schedule_interval_type = @schedule_interval_type,
            @schedule_interval_count = @schedule_interval_count
    END
    ELSE
    BEGIN
        SET @updated = 1
        EXEC [jobs].sp_update_job
            @job_name = @job_name,
            @enabled = @enabled,
            @schedule_start_time = @schedule_start_time,
            @schedule_end_time = @schedule_end_time,
            @schedule_interval_type = @schedule_interval_type,
            @schedule_interval_count = @schedule_interval_count
    END
    COMMIT TRANSACTION
END
GO
/****** Object:  StoredProcedure [jobs_internal].[sp_find_job]    Script Date: 6/26/2024 1:14:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [jobs_internal].[sp_find_job]
    @job_name                           NVARCHAR(128),
    @job_id                             UNIQUEIDENTIFIER OUTPUT
AS
BEGIN
    SET NOCOUNT ON

    SELECT @job_id = job_id 
    FROM [jobs_internal].visible_jobs
    WHERE name = @job_name
END
GO
/****** Object:  StoredProcedure [jobs_internal].[sp_find_jobstep]    Script Date: 6/26/2024 1:14:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [jobs_internal].[sp_find_jobstep]
    @job_id                             UNIQUEIDENTIFIER,
    @job_version                        INT,
    @step_id                            INT = NULL OUTPUT,
    @step_name                          NVARCHAR(128) = NULL
AS
BEGIN
    DECLARE @error_message NVARCHAR(1000)

    -- job_id must be specified
    IF @job_id IS NULL
    BEGIN
        SET @error_message = FORMATMESSAGE('@job_id was not found.');
        THROW 50000, @error_message, 1
    END

    -- job_version must be specified
    IF @job_version IS NULL
    BEGIN
        SET @error_message = FORMATMESSAGE('@job_version was not found.');
        THROW 50000, @error_message, 1
    END

    -- step_id and step_name cannot both be specified
    IF @step_name IS NOT NULL AND @step_id IS NOT NULL
    BEGIN
        SET @error_message = FORMATMESSAGE('@step_id and @step_name cannot both be specified.');
        THROW 50000, @error_message, 1
    END

    -- If step name is specified, find the step id
    IF @step_name IS NOT NULL
    BEGIN
        SELECT @step_id = step_id
        FROM [jobs_internal].jobsteps
        WHERE job_id = @job_id
        AND job_version_number = @job_version - 1
        AND step_name = @step_name

        -- Verify that we found the step id
        IF @step_id IS NULL
        BEGIN
            SET @error_message = FORMATMESSAGE('Step name ''%s'' was not found', @step_name);
            THROW 50000, @error_message, 1
        END
    END
    -- Step name was not specified, so step id must be specified
    ELSE IF @step_id IS NULL
    BEGIN
        SET @error_message = FORMATMESSAGE('@step_id or @step_name (but not both) must be specified.', @step_name);
        THROW 50000, @error_message, 1
    END
    -- if step id is specified, verify that step already exists
    ELSE IF NOT EXISTS (
        SELECT 1
        FROM [jobs_internal].jobsteps
        WHERE job_id = @job_id
        AND job_version_number = @job_version - 1
        AND step_id = @step_id
    )
    BEGIN
        SET @error_message = FORMATMESSAGE('Step ''%i'' was not found', @step_id);
        THROW 50000, @error_message, 1
    END
END
GO
/****** Object:  StoredProcedure [jobs_internal].[sp_lock_job]    Script Date: 6/26/2024 1:14:42 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [jobs_internal].[sp_lock_job]
    @job_name                           NVARCHAR(128),
    @job_id                             UNIQUEIDENTIFIER OUTPUT
AS
BEGIN
    SET NOCOUNT ON

    DECLARE @error_message NVARCHAR(1000)
    
    IF @@TRANCOUNT = 0
    BEGIN
        SET @error_message = FORMATMESSAGE('Internal error: cannot lock job entry when there is no transaction.');
        THROW 50000, @error_message, 1
    END

    SELECT @job_id = job_id 
    FROM [jobs_internal].visible_jobs
    WITH (UPDLOCK, SERIALIZABLE, ROWLOCK)
    WHERE name = @job_name

    IF @job_id IS NULL
    BEGIN
        SET @error_message = FORMATMESSAGE('Job ''%s'' was not found', @job_name);
        THROW 50000, @error_message, 1
    END
END
GO
