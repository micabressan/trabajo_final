/// <reference path="../../jquery-2.1.4.min.js" />

define(["common/utilities"], function (util) {

	// CONSTRUCTOR FOR THE DATATABLE COMPONENT
	function EZKeysDataTable(url, template_path, target, filters) {
		// DEFAULTS
		this.template_path		 = template_path;
		this.template			 = null;
		this.model				 = {};
								 
		// ARGS					 
		this.url				 = url;
		this.filters			 = filters;
		this.filters.page		 = 0;
		this.filters.page_length = 20;
		this.target				 = target;
	}

	// RENDERS OUT THE TEMPLATE WITH THE MODEL TO THE TARGET
	EZKeysDataTable.prototype.render = function () {
		if (this.template != null) {
			var output = this.template(this.model);
			$(this.target).html(output);
		}
	};

	// RUNS THE REQUEST TO GET THE DATA BASED ON THE PASSED IN URL  
	EZKeysDataTable.prototype.refresh = function (callback) {
		$.ajax({
			url: this.url,
			data: this.filters,
			dataType: 'json',
			success: $.proxy(function (data) {
				this.model = {
					data: data,
					index_offset: (this.filters.page * this.filters.page_length) + 1
				};
				callback();
			}, this)
		});
	};

	// RUNS SOME CHECKS AND SETS THE PAGE
	EZKeysDataTable.prototype.set_page = function (page) {
		if (page < 0)
			page = 0;

		this.filters.page = page;
		this.refresh($.proxy(function () {
			this.render()
		}, this));
	};

	// HELPER TO INCREMENT THE PAGE
	EZKeysDataTable.prototype.next_page = function () {
		this.set_page(this.page + 1);
	};

	// HELPER TO DECREMENT THE PAGE
	EZKeysDataTable.prototype.previous_page = function () {
		this.set_page(this.page - 1);
	};

	// LOADS THE TEMPLATE AT THE GIVEN PATH
	EZKeysDataTable.prototype.set_template = function (template_path, callback) {
		this.template_path = template_path;

		$.ajax({
			url: util.template(this.template_path),
			dataType: 'text',
			success: $.proxy(function (data) {
				this.template = Handlebars.compile(data);
				callback();
			}, this)
		});
	};

	return EZKeysDataTable;
});/// <reference path="../../jquery-2.1.4.min.js" />

define(["common/utilities"], function (util) {

	// CONSTRUCTOR FOR THE DATATABLE COMPONENT
	function EZKeysDataTable(url, template_path, target, filters) {
		// DEFAULTS
		this.template_path		 = template_path;
		this.template			 = null;
		this.model				 = {};
								 
		// ARGS					 
		this.url				 = url;
		this.filters			 = filters;
		this.filters.page		 = 0;
		this.filters.page_length = 20;
		this.target				 = target;
	}

	// RENDERS OUT THE TEMPLATE WITH THE MODEL TO THE TARGET
	EZKeysDataTable.prototype.render = function () {
		if (this.template != null) {
			var output = this.template(this.model);
			$(this.target).html(output);
		}
	};

	// RUNS THE REQUEST TO GET THE DATA BASED ON THE PASSED IN URL  
	EZKeysDataTable.prototype.refresh = function (callback) {
		$.ajax({
			url: this.url,
			data: this.filters,
			dataType: 'json',
			success: $.proxy(function (data) {
				this.model = {
					data: data,
					index_offset: (this.filters.page * this.filters.page_length) + 1
				};
				callback();
			}, this)
		});
	};

	// RUNS SOME CHECKS AND SETS THE PAGE
	EZKeysDataTable.prototype.set_page = function (page) {
		if (page < 0)
			page = 0;

		this.filters.page = page;
		this.refresh($.proxy(function () {
			this.render()
		}, this));
	};

	// HELPER TO INCREMENT THE PAGE
	EZKeysDataTable.prototype.next_page = function () {
		this.set_page(this.page + 1);
	};

	// HELPER TO DECREMENT THE PAGE
	EZKeysDataTable.prototype.previous_page = function () {
		this.set_page(this.page - 1);
	};

	// LOADS THE TEMPLATE AT THE GIVEN PATH
	EZKeysDataTable.prototype.set_template = function (template_path, callback) {
		this.template_path = template_path;

		$.ajax({
			url: util.template(this.template_path),
			dataType: 'text',
			success: $.proxy(function (data) {
				this.template = Handlebars.compile(data);
				callback();
			}, this)
		});
	};

	return EZKeysDataTable;
});