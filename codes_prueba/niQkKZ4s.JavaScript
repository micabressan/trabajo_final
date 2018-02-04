        $scope.windowSize = function() {
            if ($window.innerWidth > 1390) {
                $scope.leftIndex = 4 - ($scope.puppets.length - 3);
            }
            else if ($window.innerWidth > 990) {
                $scope.leftIndex = 4 - ($scope.puppets.length - 2);
            }
            else {
                $scope.leftIndex = 4 - ($scope.puppets.length - 1);
            }
            $scope.updateArrows();
        };

        angular.element($window).bind('resize', function(){
            $scope.windowSize();
        });