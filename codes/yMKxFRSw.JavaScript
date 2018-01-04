'use strict';

var cronApp = angular.module('cronApp', [
    'cronAppCtrlrs'
]).directive('ngClock', function () {
    return {
        restrict: 'A',
        scope: {
            getTime: "="
        },
        template: '<div>{{getTime}}</div>',
        controller: ['$scope', '$interval', function($scope, $interval){
            $interval(function () {
                var time = moment(new Date()).format('hh:mm:ss');

                $scope.getTime = time;
            }, 1000);
        }]
    };
});