val platforms = List(new TwitterModel, new FacebookModel, new LinkedInModel)

platforms foreach { test => 
	test.scenario { compass, platform =>
		compass.session { compass.administration.policy.enable_moderation platform.type }
		platform.session { platform.post }	
		compass.session {
			test.assert compass.archive.submitted
	      		compass.moderation.approve
	      		test.assert compass.archive.posted
		}
		platform.session { 
			test.assert platform.contains message
		}
	}
}