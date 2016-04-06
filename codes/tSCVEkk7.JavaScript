'use strict';

class ChoosingTermModalController {

  constructor($scope, $modalInstance) {
    this.$modalInstance = $modalInstance;

    $scope.terms = [
      {
        date: new Date(),
        capacity: 30
      },
      {
        date: new Date(),
        capacity: 50
      }
    ];

    $scope.cancel = this.cancel(this);
  }

  cancel(self) {
    return () => self.$modalInstance.dismiss('cancel')
  }

}

ChoosingTermModalController.$inject = ['$scope', '$modalInstance'];
export default ChoosingTermModalController;