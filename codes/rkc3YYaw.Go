if user_id != "" {
		if checkUserInAdminList(user_id) {
			fmt.Println("Try return image, user is admin: ", file_id)
			getImage(file_id, w)
		} else if checkUserIsAdmin(user_id) {
			fmt.Println("Try return image, user in admin list: ", file_id)
			getImage(file_id, w)
		}else if checkFileOwner(file_id, user_id) {
			fmt.Println("Try return image, user is file owner: ", file_id)
			getImage(file_id, w)
		} else {
			fmt.Println("No way")
			http.Error(w, http.StatusText(404), 404)
		}
	} else {
		fmt.Println("No user ID - No deal")
		http.Error(w,