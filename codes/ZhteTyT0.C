{
	instances = {
		arandomformappeared = BodyReader(
			maperrors = true,
			field_firstname = "^\w{2,60}$",
			field_lastname = "^\w{2,60}$",
			field_age = "^[0-9]{2,3}$"
		) {
			form->Template(f"TheEntireForm.html");
			firstname_failure->Template(f"NameError.html");
			lastname_failure->Template(f"NameError.html");
			age_failure->Template(f"AgeError.html");
			successful_branch->SQL(f"StoreDox.sql", params = ["firstname", "lastname", "age"]);
		};
	};
}