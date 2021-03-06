create database SQLDB
go 

use SQLDB
go



/****** Object:  Table [dbo].[Book]    Script Date: 07-03-2017 12:19:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Book](
	[BookID] [int] IDENTITY(1,1) NOT NULL,
	[BookTitle] [nvarchar](250) NOT NULL,
	[AuthorID] [int] NOT NULL,


	 CONSTRAINT [PK__Book__3DE0C227F5515E55] PRIMARY KEY CLUSTERED 
	(
		[BookID] ASC
	)


WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Author]    Script Date: 07-03-2017 12:19:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Author](
	[AuthorID] [int] IDENTITY(1,1) NOT NULL,
	[AuthorName] [nvarchar](50) NOT NULL,
	[AuthorDateofBirth] [date] NOT NULL,
	[AuthorAge_v1]  AS (datepart(year,getdate())-datepart(year,[AuthorDateofBirth])),
	[AuthorAge_v2]  AS (datediff(hour,[AuthorDateofBirth],getdate())/(8766)),
 CONSTRAINT [PK_Author] PRIMARY KEY CLUSTERED 
(
	[AuthorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  View [dbo].[View_Books]    Script Date: 07-03-2017 12:19:46 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[View_Books]
AS
SELECT        dbo.Book.BookTitle, dbo.Author.AuthorName, 
				dbo.Author.AuthorAge_v2 as [alder]
FROM            dbo.Author INNER JOIN
                         dbo.Book ON dbo.Author.AuthorID = dbo.Book.AuthorID


GO
ALTER TABLE [dbo].[Book]  WITH CHECK ADD  CONSTRAINT [FK_Book_Author] FOREIGN KEY([AuthorID])
REFERENCES [dbo].[Author] ([AuthorID])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Book] CHECK CONSTRAINT [FK_Book_Author]
GO
