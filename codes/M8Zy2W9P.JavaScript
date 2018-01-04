enyo.kind({
	name: "Saved4Later",
	kind: enyo.VFlexBox,
	components: [{
		name: "pane",
		kind: "Pane",
		flex: 1,
		components: [{
			name: "mainview",
			kind: "enyo.VFlexBox" // Real main view here
		},{
			name: "preferences",
			kind: "S4L.Preferences",
			onPrefsReady: "preferencesReady"
		}]
	},{
		kind: "AppMenu",
		components: [
			{ caption: "Preferences", onclick: "showPreferences" },
			{ caption: "About", onclick: "showAbout" }
		]
	},{
		name: "loginDialog",
		kind: "S4L.LoginDialog",
		onSuccess: "authSuccess"
	}],
	
	showPreferences: function() {
		enyo.log("Show preferences clicked");
		this.$.pane.selectViewByName("preferences");
	},
	
	showAbout: function() {
		enyo.log("Show about popup");
		this.showLoginDialog();
	},

	showLoginDialog: function() {
		this.$.loginDialog.openAtCenter();
	},
	
	preferencesReady: function() {
		enyo.log("Preferences ready in main file");
		var prefs = this.$.preferences.getPreferences();
		enyo.log("Preference values: " + enyo.json.stringify(prefs));
		if (prefs.username == "") {
			enyo.log("No username set in preferences, opening prompt");
			this.showLoginDialog();
		}
	},
	
	fetchUpdates: function() {
		enyo.log("Fetching updates");
	},
	
	authSuccess: function(inUsername, inPassword) {
		enyo.log("Main file received authSuccess for user " + inUsername);
	},
	
	openAppMenuHandler: function() {
		this.$.appMenu.open();
	},
	closeAppMenuHandler: function() {
		this.$.appMenu.close();
	}
});