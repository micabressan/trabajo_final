SELECT
	*
FROM
	UserMessages, UserData, UserFriends
WHERE
	(
		(
				UserFriends.UserID1 = "'.$user['Id'].'"
			AND
				UserData.Id = UserFriends.UserID2
			AND
				UserMessages.WriterId = UserFriends.UserID2
		)
		OR
		(
				UserFriends.UserID2 = "'.$user['Id'].'"
			AND
				UserData.Id = UserFriends.UserID1
			AND
				UserMessages.WriterId = UserFriends.UserID1
		)
	)
	OR
	(
			UserData.Id = "'.$user['Id'].'"
		AND
			UserMessages.WriterId = "'.$user['Id'].'"
	)
GROUP BY UserMessages.Id
ORDER BY
	PostTime
DESC
LIMIT
	0,20