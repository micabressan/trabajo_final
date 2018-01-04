<html>
  <head>
    <script type="text/javascript" src="angular.min.js"></script>
  </head>
  <body ng-app="myApp"  ng-controller="meuCtrl">
    <h2>Receita bolo</h2>
    <ul>
      <li ng-repeat="ing in ingredientes">
        {{ing}}
      </li>
    </ul>
  <script type="text/javascript">
      var app = angular.module('mydApp',[]);

      app.controller('meuCtrl', function($scope){
        $scope.ingredientes = ["farinha", "ovo", "chocolate"];
      });
  </script>
  </body>
</html>