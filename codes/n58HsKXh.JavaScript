'use strict';

angular.module('mean.admins').config(['$stateProvider','$urlRouterProvider',
	function($stateProvider,$urlRouterProvider) {

		$stateProvider
		.state('adminapp', {
			abstract: true,
			url: '/admins',
			templateUrl: 'admins/views/index.html',
			controller: 'AdminsController',
			resolve: {
				loggedin: function(MeanUser) {
					return MeanUser.checkLoggedin();
				},
				mambuUser: function ($q, MambuUserGet,$location,MeanUser) {

					return {};
					/*var deferred  = $q.defer();

					MambuUserGet.get({username:MeanUser.user.username},function(res){

						console.log(res)
						deferred.resolve(res);

					},function(err){

						//MeanUser.logout();
							//$location.url('/auth/login');

					});

					return deferred.promise;*/
					
				},

			}
		})

		.state('admincore', {
			url: '/admins/signup',
			templateUrl: 'admins/views/signup.html',
			
		})

		.state('adminapp.home', {
			url: '/',
			controller : 'AdminsDashBoardCtrl',
			templateUrl: 'admins/views/tmpl/uw/dashboard.html',			
		})

		.state('adminapp.clients', {
			url: '/clients',
			controller : 'AdminsClientsCtrl',
			templateUrl: 'admins/views/tmpl/clients.html',			
		})

		.state('adminapp.clientsadd', {
			url: 'clients/add',
			controller : 'AdminsClientsCtrl',
			templateUrl: 'admins/views/tmpl/clientsadd.html',	
			resolve: {
				plugins: ['$ocLazyLoad', function($ocLazyLoad) {
					return $ocLazyLoad.load([
						'customsystem/assets/vendor/filestyle/bootstrap-filestyle.min.js'
						]);
				}],
			}		
		})

		.state('adminapp.id', {
			url: '/clients/:clientId',
			controller : 'AdminsClientsCtrl',
			templateUrl: 'admins/views/tmpl/clientsedit.html',
			resolve: {
				plugins: ['$ocLazyLoad', function($ocLazyLoad) {
					return $ocLazyLoad.load([
						'customsystem/assets/vendor/filestyle/bootstrap-filestyle.min.js'
						]);
				}],
			}
		})
.state('adminapp.unifiedpayment', {
			url: '/unifiedpayment',
			abstract : true,			
		})


.state('adminapp.unifiedpayment.report', {
			url: '/report',
			controller : 'UnifiedpaymentReportCtrl',
			templateUrl: 'admins/views/tmpl/unifiedpayment_report.html',			
		})
		;
	}]);