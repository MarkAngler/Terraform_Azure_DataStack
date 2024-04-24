CREATE TABLE [dbo].[SampleData]
(
[ID] [int] NOT NULL IDENTITY(1, 1),
[Name] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Age] [int] NULL
)
GO
ALTER TABLE [dbo].[SampleData] ADD CONSTRAINT [PK__SampleDa__3214EC279A812B91] PRIMARY KEY CLUSTERED ([ID])
GO
