_$_.add('hasClass', function (cls) {
		_.assert(cls, WARNING_SYRUP.ERROR.NOPARAM, '($ .hasClass)');

		//One at time!!
		var elem = this.get(0);

		//ClassList and hasClass?
		return elem.classList
			&& Array.prototype.indexOf.call(
				elem.classList, (cls || _.emptyStr)
			) > -1;

	});