/****** Object:  Table [Orders].[OrderItems]    Script Date: 12/9/2020 5:21:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Orders].[OrderItems](
	[OrderItemId] [bigint] IDENTITY(1,1) NOT NULL,
	[OrderId] [bigint] NOT NULL,
	[BrandCode] [nvarchar](30) NULL,
	[FamilyCode] [nvarchar](30) NULL,
	[StyleCode] [nvarchar](30) NULL,
	[TechnologyLevelCode] [nvarchar](30) NULL,
	[ProductModelCode] [nvarchar](50) NULL,
	[ItemCode] [nvarchar](100) NOT NULL,
	[Modifier] [varchar](5) NULL,
	[Quantity] [int] NOT NULL,
	[Amount] [float] NOT NULL,
	[Status] [varchar](100) NOT NULL,
	[UnitPrice] [float] NOT NULL,
	[PairPrice] [float] NOT NULL,
	[ItemData] [nvarchar](4000) NOT NULL,
	[ItemType] [varchar](10) NOT NULL,
	[PONumber] [bigint] NULL,
	[InvoiceNumber] [varchar](20) NULL,
	[CreateUser] [nvarchar](50) NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[ModifyUser] [nvarchar](50) NULL,
	[ModifyDate] [datetime] NULL,
	[IsActive] [bit] NOT NULL,
	[PreviousAmount] [varchar](200) NULL,
PRIMARY KEY CLUSTERED 
(
	[OrderItemId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Orders].[OrderPOs]    Script Date: 12/9/2020 5:21:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Orders].[OrderPOs](
	[PONumber] [bigint] IDENTITY(180022116,1) NOT NULL,
	[OrderId] [bigint] NOT NULL,
	[CreateUser] [nvarchar](50) NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[ModifyUser] [nvarchar](50) NULL,
	[ModifyDate] [datetime] NULL,
	[IsActive] [bit] NOT NULL,
	[FileId] [bigint] NULL,
	[MailHistoryAttachmentId] [bigint] NULL,
	[OrderRefNumber] [varchar](100) NULL,
	[OrderPORefNbr] [varchar](100) NULL,
	[PODate] [date] NULL,
 CONSTRAINT [PK_OrderPOs_PONumber] PRIMARY KEY CLUSTERED 
(
	[PONumber] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [Orders].[Orders]    Script Date: 12/9/2020 5:21:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Orders].[Orders](
	[OrderID] [bigint] IDENTITY(1,1) NOT NULL,
	[MemberChartDataId] [bigint] NOT NULL,
	[OrderType] [varchar](10) NOT NULL,
	[MemberData] [nvarchar](4000) NOT NULL,
	[OrderAmountData] [nvarchar](4000) NOT NULL,
	[ShippingData] [nvarchar](4000) NOT NULL,
	[ProviderData] [nvarchar](4000) NOT NULL,
	[Status] [varchar](50) NOT NULL,
	[Source] [varchar](20) NULL,
	[Amount] [float] NOT NULL,
	[NHMemberId] [nvarchar](20) NOT NULL,
	[RefOrderId] [bigint] NULL,
	[DateOrderReceived] [datetime] NOT NULL,
	[DateOrderInitiated] [datetime] NOT NULL,
	[SpecialInstructions] [varchar](1500) NULL,
	[EarmoldInstructions] [varchar](1500) NULL,
	[CreateUser] [nvarchar](50) NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[ModifyUser] [nvarchar](50) NULL,
	[ModifyDate] [datetime] NULL,
	[IsActive] [bit] NOT NULL,
	[OrderStatusCode] [nvarchar](3) NOT NULL,
	[OrderBy] [nvarchar](50) NULL,
	[IPAddress] [nvarchar](50) NULL,
	[BenefitsData] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [Orders].[OrderTransactionDetails]    Script Date: 12/9/2020 5:21:11 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [Orders].[OrderTransactionDetails](
	[OrderTransactionID] [bigint] IDENTITY(1,1) NOT NULL,
	[OrderID] [bigint] NOT NULL,
	[OrderStatusCode] [nvarchar](3) NOT NULL,
	[OrderTransactionData] [nvarchar](max) NOT NULL,
	[IsComplete] [bit] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[CreateUser] [nvarchar](150) NULL,
	[ModifyDate] [datetime] NULL,
	[ModifyUser] [nvarchar](150) NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_Orders]].[OrderTransactionDetails] PRIMARY KEY CLUSTERED 
(
	[OrderTransactionID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [Orders].[OrderItems] ADD  DEFAULT ((1)) FOR [Quantity]
GO
ALTER TABLE [Orders].[OrderItems] ADD  DEFAULT ((0)) FOR [Amount]
GO
ALTER TABLE [Orders].[OrderItems] ADD  DEFAULT ((0)) FOR [UnitPrice]
GO
ALTER TABLE [Orders].[OrderItems] ADD  DEFAULT ((0)) FOR [PairPrice]
GO
ALTER TABLE [Orders].[OrderItems] ADD  DEFAULT ('{}') FOR [ItemData]
GO
ALTER TABLE [Orders].[OrderItems] ADD  DEFAULT ((0)) FOR [IsActive]
GO
ALTER TABLE [Orders].[OrderPOs] ADD  CONSTRAINT [DF__OrderPOs__IsActi__40857097]  DEFAULT ((0)) FOR [IsActive]
GO
ALTER TABLE [Orders].[OrderPOs] ADD  DEFAULT (getdate()) FOR [PODate]
GO
ALTER TABLE [Orders].[Orders] ADD  CONSTRAINT [DF_orders_MD]  DEFAULT ('{}') FOR [MemberData]
GO
ALTER TABLE [Orders].[Orders] ADD  CONSTRAINT [DF_Orders_OAD]  DEFAULT ('{}') FOR [OrderAmountData]
GO
ALTER TABLE [Orders].[Orders] ADD  CONSTRAINT [DF_Orders_SD]  DEFAULT ('{}') FOR [ShippingData]
GO
ALTER TABLE [Orders].[Orders] ADD  CONSTRAINT [DF_Orders_PD]  DEFAULT ('{}') FOR [ProviderData]
GO
ALTER TABLE [Orders].[Orders] ADD  DEFAULT ((0)) FOR [Amount]
GO
ALTER TABLE [Orders].[Orders] ADD  DEFAULT ((0)) FOR [IsActive]
GO
ALTER TABLE [Orders].[OrderTransactionDetails] ADD  CONSTRAINT [dfCreateDate]  DEFAULT (getdate()) FOR [CreateDate]
GO
ALTER TABLE [Orders].[OrderTransactionDetails] ADD  CONSTRAINT [dfModifyDate]  DEFAULT (getdate()) FOR [ModifyDate]
GO
ALTER TABLE [Orders].[OrderItems]  WITH CHECK ADD  CONSTRAINT [FK_OrderItem_BrandCode] FOREIGN KEY([BrandCode])
REFERENCES [catalog].[Brands] ([BrandCode])
GO
ALTER TABLE [Orders].[OrderItems] CHECK CONSTRAINT [FK_OrderItem_BrandCode]
GO
ALTER TABLE [Orders].[OrderItems]  WITH CHECK ADD  CONSTRAINT [FK_OrderItem_CreateUser] FOREIGN KEY([CreateUser])
REFERENCES [auth].[UserProfiles] ([UserName])
GO
ALTER TABLE [Orders].[OrderItems] CHECK CONSTRAINT [FK_OrderItem_CreateUser]
GO
ALTER TABLE [Orders].[OrderItems]  WITH CHECK ADD  CONSTRAINT [FK_OrderItem_ItemCode] FOREIGN KEY([ItemCode])
REFERENCES [catalog].[ItemMasterList] ([ItemCode])
GO
ALTER TABLE [Orders].[OrderItems] CHECK CONSTRAINT [FK_OrderItem_ItemCode]
GO
ALTER TABLE [Orders].[OrderItems]  WITH CHECK ADD  CONSTRAINT [FK_OrderItem_ItemType] FOREIGN KEY([ItemType])
REFERENCES [catalog].[ItemTypes] ([ItemType])
GO
ALTER TABLE [Orders].[OrderItems] CHECK CONSTRAINT [FK_OrderItem_ItemType]
GO
ALTER TABLE [Orders].[OrderItems]  WITH CHECK ADD  CONSTRAINT [FK_OrderItem_ModifyUser] FOREIGN KEY([ModifyUser])
REFERENCES [auth].[UserProfiles] ([UserName])
GO
ALTER TABLE [Orders].[OrderItems] CHECK CONSTRAINT [FK_OrderItem_ModifyUser]
GO
ALTER TABLE [Orders].[OrderItems]  WITH CHECK ADD  CONSTRAINT [FK_OrderItem_OrderID] FOREIGN KEY([OrderId])
REFERENCES [Orders].[Orders] ([OrderID])
GO
ALTER TABLE [Orders].[OrderItems] CHECK CONSTRAINT [FK_OrderItem_OrderID]
GO
ALTER TABLE [Orders].[OrderItems]  WITH CHECK ADD  CONSTRAINT [FK_OrderItems_PONumber] FOREIGN KEY([PONumber])
REFERENCES [Orders].[OrderPOs] ([PONumber])
GO
ALTER TABLE [Orders].[OrderItems] CHECK CONSTRAINT [FK_OrderItems_PONumber]
GO
ALTER TABLE [Orders].[OrderPOs]  WITH NOCHECK ADD  CONSTRAINT [FK_CreateUser] FOREIGN KEY([CreateUser])
REFERENCES [auth].[UserProfiles] ([UserName])
GO
ALTER TABLE [Orders].[OrderPOs] CHECK CONSTRAINT [FK_CreateUser]
GO
ALTER TABLE [Orders].[OrderPOs]  WITH NOCHECK ADD  CONSTRAINT [FK_ModifyUser] FOREIGN KEY([ModifyUser])
REFERENCES [auth].[UserProfiles] ([UserName])
GO
ALTER TABLE [Orders].[OrderPOs] CHECK CONSTRAINT [FK_ModifyUser]
GO
ALTER TABLE [Orders].[OrderPOs]  WITH NOCHECK ADD  CONSTRAINT [FK_OrderID] FOREIGN KEY([OrderId])
REFERENCES [Orders].[Orders] ([OrderID])
GO
ALTER TABLE [Orders].[OrderPOs] CHECK CONSTRAINT [FK_OrderID]
GO
ALTER TABLE [Orders].[OrderPOs]  WITH CHECK ADD  CONSTRAINT [FK_OrderPOs_MailHistoryId] FOREIGN KEY([MailHistoryAttachmentId])
REFERENCES [contact].[MailHistoryAttachments] ([MailHistoryAttachmentId])
GO
ALTER TABLE [Orders].[OrderPOs] CHECK CONSTRAINT [FK_OrderPOs_MailHistoryId]
GO
ALTER TABLE [Orders].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_CreateUser] FOREIGN KEY([CreateUser])
REFERENCES [auth].[UserProfiles] ([UserName])
GO
ALTER TABLE [Orders].[Orders] CHECK CONSTRAINT [FK_Orders_CreateUser]
GO
ALTER TABLE [Orders].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_ModifyUser] FOREIGN KEY([ModifyUser])
REFERENCES [auth].[UserProfiles] ([UserName])
GO
ALTER TABLE [Orders].[Orders] CHECK CONSTRAINT [FK_Orders_ModifyUser]
GO
ALTER TABLE [Orders].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_NHMemberId] FOREIGN KEY([NHMemberId])
REFERENCES [provider].[MemberProfiles] ([NHMemberId])
GO
ALTER TABLE [Orders].[Orders] CHECK CONSTRAINT [FK_Orders_NHMemberId]
GO
ALTER TABLE [Orders].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orderstbl_MemberChartDataId] FOREIGN KEY([MemberChartDataId])
REFERENCES [provider].[MemberChartData] ([MemberChartDataId])
GO
ALTER TABLE [Orders].[Orders] CHECK CONSTRAINT [FK_Orderstbl_MemberChartDataId]
GO
ALTER TABLE [Orders].[OrderTransactionDetails]  WITH NOCHECK ADD  CONSTRAINT [FK_OrderTransactionDetails_OrderID] FOREIGN KEY([OrderID])
REFERENCES [Orders].[Orders] ([OrderID])
GO
ALTER TABLE [Orders].[OrderTransactionDetails] CHECK CONSTRAINT [FK_OrderTransactionDetails_OrderID]
GO
ALTER TABLE [Orders].[OrderItems]  WITH CHECK ADD CHECK  (([Modifier]='LT' OR [Modifier]='RT'))
GO
ALTER TABLE [Orders].[Orders]  WITH CHECK ADD CHECK  (([Status]='RETURNED' OR [Status]='CANCELLED' OR [Status]='ACTIVE' OR [Status]='LSandD'))
GO
ALTER TABLE [Orders].[Orders]  WITH CHECK ADD  CONSTRAINT [Orders_OrderSource_Check] CHECK  (([Source]='JOB' OR [Source]='VS' OR [Source]='CRM' OR [Source]='OTC_STORE' OR [Source]='MemberPortal' OR [Source]='DHC'))
GO
ALTER TABLE [Orders].[Orders] CHECK CONSTRAINT [Orders_OrderSource_Check]
GO
ALTER TABLE [Orders].[Orders]  WITH CHECK ADD  CONSTRAINT [Orders_OrderType_Check] CHECK  (([OrderType]='FOLLOWUP' OR [OrderType]='FITTING' OR [OrderType]='RET' OR [OrderType]='TEST' OR [OrderType]='EXCHANGE' OR [OrderType]='LSandD' OR [OrderType]='NEW' OR [OrderType]='OTC'))
GO
ALTER TABLE [Orders].[Orders] CHECK CONSTRAINT [Orders_OrderType_Check]
GO
ALTER TABLE [Orders].[Orders]  WITH CHECK ADD  CONSTRAINT [OrderStatusCodeCheck] CHECK  (([OrderStatusCode]='CAN' OR [OrderStatusCode]='RET' OR [OrderStatusCode]='ACK' OR [OrderStatusCode]='SHI' OR [OrderStatusCode]='DOC' OR [OrderStatusCode]='PO' OR [OrderStatusCode]='APP' OR [OrderStatusCode]='PAY' OR [OrderStatusCode]='INI' OR [OrderStatusCode]='CLM' OR [OrderStatusCode]='EXC' OR [OrderStatusCode]='APQ' OR [OrderStatusCode]='REC' OR [OrderStatusCode]='FFC'))
GO
ALTER TABLE [Orders].[Orders] CHECK CONSTRAINT [OrderStatusCodeCheck]
GO
