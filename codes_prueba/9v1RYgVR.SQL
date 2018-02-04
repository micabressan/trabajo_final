/*

	Email notifications recipients
	New Page Furniture for Region Management

*/


--BEGIN TRANSACTION
----	COMMIT
----	ROLLBACK
	

	--	EXEC dbo.spx_CreateCMSPageFurniture 313, 1, N'Email DSAs On Classroom Booking Enrolment', 53, 1, 1, 1



SET IDENTITY_INSERT [dbo].[CMSPageFurnitures] ON
	INSERT INTO [dbo].[CMSPageFurnitures] ([ID], [IsEnabled], [ItemID], [CreatedDate], [UpdatedDate]) VALUES (9331, 1, 53, '2015-06-03 13:21:18.837', NULL)
SET IDENTITY_INSERT [dbo].[CMSPageFurnitures] OFF


INSERT INTO [dbo].[CMSPageFurnitures_Locale] ([CMSPageFurnitureID], [LanguageID], [FurnitureText]) 
SELECT 9331, l.ID, N'Email DSAs On Trainer Led Booking Enrolment'
FROM Languages AS l


SET IDENTITY_INSERT [dbo].[CMSPagesToCMSPageFurnitures] ON
	INSERT INTO [dbo].[CMSPagesToCMSPageFurnitures] ([ID], [CMSPageID], [CMSPageFurnitureID], [CreatedByAdministratorID], [CreatedDate], [UpdatedByAdministratorID], [UpdatedDate]) VALUES (78255, 313, 9331, 1, '2015-06-03 13:21:18.837', 0, NULL)
SET IDENTITY_INSERT [dbo].[CMSPagesToCMSPageFurnitures] OFF

	

--	COMMIT
--	ROLLBACK