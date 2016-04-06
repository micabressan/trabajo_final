USE [Sprint-01-CORE]
GO
/****** Object:  StoredProcedure [dbo].[spx_GetAE_Answers]    Script Date: 15/08/2015 13:18:20 ******/
SET ANSI_NULLS O
GO
SET QUOTED_IDENTIFIER OFF
GO
ALTER PROCEDURE [dbo].[spx_GetAE_Answers]
(
	@LanguageID int,
	@ID int = NULL,
	@AE_QuestionID int = NULL,
	@WasCorrect bit = NULL,
	@IsActive bit = NULL,
	@IsRandom bit = NULL
)
AS
	SET NOCOUNT ON;
	
	DECLARE @l_LanguageID int;
	DECLARE @l_ID int;
	DECLARE @l_AE_QuestionID int;
	DECLARE @l_WasCorrect bit;
	DECLARE @l_IsActive bit;
	DECLARE @l_IsRandom bit;
	
	SET @l_LanguageID = @LanguageID;
	SET @l_ID = @ID;
	SET @l_AE_QuestionID = @AE_QuestionID;
	SET @l_WasCorrect = @WasCorrect;
	SET @l_IsActive = @IsActive;
	SET @l_IsRandom = @IsRandom;

	IF (@l_IsRandom Is NULL)
		
		SELECT tbl1.ID, tblL.LanguageID, tbl1.AE_QuestionID, tbl1.WasCorrect, tbl1.IsActive, tbl1.AnswerPointsPercentage,
			RuntimeAnswerName = 
				CASE
					WHEN tbl1.WasCorrect = 1 THEN tblL.AnswerText + '*'
					ELSE tblL.AnswerText
				END, 
			tblL.AnswerText, lal.LanguageName, la.ISOShortName As LanguageISOShortName, ae_ql.QuestionText 
		FROM AE_Answers tbl1 WITH (NOLOCK)
			INNER JOIN AE_Answers_Locale tblL WITH (NOLOCK) ON tbl1.ID = tblL.AE_AnswerID
			INNER JOIN AE_Questions ae_q WITH (NOLOCK) ON tbl1.AE_QuestionID = ae_q.ID
			INNER JOIN AE_Questions_Locale ae_ql WITH (NOLOCK) ON ae_q.ID = ae_ql.AE_QuestionID AND ae_ql.LanguageID = @l_LanguageID
			INNER JOIN Languages la WITH (NOLOCK) ON tblL.LanguageID = la.ID
			INNER JOIN Languages_Locale lal WITH (NOLOCK) ON la.ID = lal.LanguageID AND lal.LocaleID = @l_LanguageID
		WHERE tblL.LanguageID = @l_LanguageID 
			AND ((@l_ID Is Null) OR (tbl1.ID = @l_ID)) 
			AND ((@l_AE_QuestionID Is Null) OR (tbl1.AE_QuestionID = @l_AE_QuestionID)) 
			AND ((@l_WasCorrect Is Null) OR (tbl1.WasCorrect = @l_WasCorrect)) 
			AND ((@l_IsActive Is Null) OR (tbl1.IsActive = @l_IsActive))
		ORDER BY tbl1.ID
			
	ELSE

		SELECT tbl1.ID, tblL.LanguageID, tbl1.AE_QuestionID, tbl1.WasCorrect, tbl1.IsActive, tbl1.AnswerPointsPercentage,
			RuntimeAnswerName = 
				CASE
					WHEN tbl1.WasCorrect = 1 THEN tblL.AnswerText + '*'
					ELSE tblL.AnswerText
				END, 
			tblL.AnswerText, lal.LanguageName, la.ISOShortName As LanguageISOShortName, ae_ql.QuestionText 
		FROM AE_Answers tbl1 WITH (NOLOCK)
			INNER JOIN AE_Answers_Locale tblL WITH (NOLOCK) ON tbl1.ID = tblL.AE_AnswerID
			INNER JOIN AE_Questions ae_q WITH (NOLOCK) ON tbl1.AE_QuestionID = ae_q.ID
			INNER JOIN AE_Questions_Locale ae_ql WITH (NOLOCK) ON ae_q.ID = ae_ql.AE_QuestionID AND ae_ql.LanguageID = @l_LanguageID
			INNER JOIN Languages la WITH (NOLOCK) ON tblL.LanguageID = la.ID
			INNER JOIN Languages_Locale lal WITH (NOLOCK) ON la.ID = lal.LanguageID AND lal.LocaleID = @l_LanguageID
		WHERE tblL.LanguageID = @l_LanguageID 
			AND ((@l_ID Is Null) OR (tbl1.ID = @l_ID)) 
			AND ((@l_AE_QuestionID Is Null) OR (tbl1.AE_QuestionID = @l_AE_QuestionID)) 
			AND ((@l_WasCorrect Is Null) OR (tbl1.WasCorrect = @l_WasCorrect)) 
			AND ((@l_IsActive Is Null) OR (tbl1.IsActive = @l_IsActive))
		ORDER BY NEWID()