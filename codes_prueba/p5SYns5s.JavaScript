/**
 * Wrapper pre analytics.
 *
 * Existuju 2 situacie, ked uzivatel si pozera svojho rexika, vtedy
 * chceme trakovat, a potom ked si pozera cudzieho, vtedy len 
 * zatrakujeme, ze je na navsteve.
 * 
 * TODO ked mozem tak odchytavam eventy, ale aby som zbytocne nove 
 * nepridaval, tak niekde su funkcie priamo volane
 */
app.classes.Analytics = Class(function() {
	'use strict';

	return {
		constructor: function() {

			if (app.global.isAuthenticated) {

				var self = this, initParams;

				if (app.global.ownRexik) {
					initParams = {
						token: app.config.analytics.token, 
						target: '//api.infinario.com',
						customer: app.global.user_id,
						visits: true
					};

				} else {
					initParams = {
						token: app.config.analytics.token
					};	

					this.track('view-other');

					this.updateUser = $.noop;
					this.start = $.noop;
				}

				app.log.debug('ANALYTICS', 'initialize', initParams);
				_7S.initialize(initParams);

				this.track('game-loading-start');

				app.global.on(app.classes.GlobalEvents.GAME_STARTED, function() {
					self.start();	
				});
			}
		},
		
		updateUser: function() {
			var user_id = String(app.model.attributes.user_id);

			app.log.debug('ANALYTICS', 'updateUser', user_id);
			_7S.identify(user_id);
		},

		start: function() {
			this.track(
				'game-ready', {
					load_time: (new Date()).getTime() - app.global.startTime.getTime(),
					view: app.global.editation ? 'home' : 'other'
				}
			);
		},

		track: function() {
			if (app.global.isAuthenticated) {
				app.log.debug.apply(app.log, ['ANALYTICS', 'tracking'].concat(Array.prototype.slice.call(arguments)));

				_7S.track.apply(_7S, arguments);
			}
		},

		tutorialWelcome: function(step) {
			this.track('tutorial-welcome', {step: step});
		},

		tutorialFood: function(step) {
			this.track('tutorial-food', {step: step});
		},

		tutorialEnergy: function(step) {
			this.track('tutorial-energy', {step: step});
		},

		tutorialSkipTime: function(step) {
			this.track('tutorial-skip-time', {step: step});
		},

		warn: function(what, amount) {
			var props = {};
			props['amount_' + what] = amount;
			
			this.track('warning-' + what, props);
		}
	};

});