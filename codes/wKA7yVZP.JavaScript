Uncaught Error: [$injector:modulerr] Failed to instantiate module starter due to:
Error: [$injector:modulerr] Failed to instantiate module starter.SignupCtrl due to:
Error: [$injector:nomod] Module 'starter.SignupCtrl' is not available! You either misspelled the module name or forgot to load it. If registering a module ensure that you specify the dependencies as the second argument.
http://errors.angularjs.org/1.3.13/$injector/nomod?p0=starter.SignupCtrl

*****************************************************************************
the top of signup.html>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

<ion-pane class="page page-login" ng-controller="SignupCtrl">
     <ion-nav-bar class="bar-stable nav-bar bar-transparent">
            <ion-nav-buttons side="left">

***************************************************************************
signup.js>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

angular.module('starter.SignupCtrl',[])
//var mongoose = require('mongoose'),

.controller('SignupCtrl',['$scope','$localstorage','$window', function($scope,$localstorage,$window)
{


$scope.signer = function(){


	$scope.user = {
		firstname: '',
		lastname: '',
		email: '',
		dob: '',
		phone:'',
		gender:'',
		password: ''

	}
};

*********************************************************************
app.js>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

angular.module('starter', ['ionic', 'ionic.service.core', 'ngMaterial','LocalStorage', 'starter.LoginCtrl', 'starter.controllers','starter.SignupCtrl','ngCordova'])

 .state('auth.signup', {//linked
                        url: '/signup',
                        views: {
                            'menuContent': {
                                templateUrl: "templates/signup.html",
                                controller: 'DashCtrl'
                            }
                        }
                    })


























}]);