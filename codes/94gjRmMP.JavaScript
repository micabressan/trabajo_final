<!DOCTYPE html>
<html>
<head>
  <title></title>
    <link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/angular.js/1.4.4/angular.min.js"></script>
    <script src="//ajax.googleapis.com/ajax/libs/angularjs/1.4.0/angular-messages.js"></script>
    <style type="text/css">
    .container {
    background-color: #f2f2f2;
    border: 1px solid #ccc;
    padding: 20px;
    top: 20px;
    -webkit-box-shadow: 0 2px 2px 1px rgba(0,0,0,0.2);
    box-shadow: 0 2px 2px 1px rgba(0,0,0,0.2);
}</style>
</head>

<body ng-app="formlyApp" ng-controller="MainController as vm">

  <div class="container col-md-4 col-md-offset-4">
    
    <form ng-submit="vm.onSubmit(commentForm)" name="commentForm">
      <div class="form-group">
        <input type="text"
          name="title"
          ng-model="vm.comment.title"
          ng-minlength="3"
          required>

        <div ng-messages="commentForm.title.$error"  ng-if='commentForm.title.$touched'>
            <p ng-message="minlength">Your name is too short.</p>
            <p ng-message="required">Your name is required.</p>
        </div>
      </div>

      <div class="form-group">
        <input type="text"
          name="content"
          ng-model="vm.comment.content"
          ng-minlength="3"
          required>

          <div ng-messages="commentForm.content.$error"  ng-if='commentForm.title.$touched'>
            <p ng-message="minlength">Your name is too short.</p>
            <p ng-message="required">Your name is required.</p>
          </div>
        </div>
        
        <input type="submit">
    </form>

    <div ng-if="vm.valid">
      <div class="alert alert-success" role="alert">Formularz wyslany!</div>
    </div>

    <code>{{ vm.comment | json }}</code>
  </div>  


</body>
    
    <script src="angular/app.js"></script>
    <script src="angular/factory.js"></script>
    <script src="angular/controller.js"></script>
</html>




(function() {
  'use strict';

  angular
    .module('formlyApp')
    .controller('MainController', MainController);

    function MainController() { 
      var vm = this;

      vm.comment = {};
      vm.valid = false;

      vm.onSubmit = function(form) {
        if(form.$valid) {
          vm.data = vm.comment;
          vm.valid = true;
        } else {
          vm.valid = false;
        }
      };

    } 
}());