$friend_result = pg_query($db, "Select username, timestamp, message
		FROM users INNER JOIN
		(
		(SELECT userid, timestamp, message
		FROM messages INNER JOIN
		(
		SELECT following
		FROM follows
		WHERE userid = 
		(SELECT id from users
		WHERE username = '" . $username . "')
		) AS foo ON messages.userid=foo.following)				
		) AS foo2
		ON users.id = foo2.userid 
		ORDER BY timestamp DESC LIMIT 20");