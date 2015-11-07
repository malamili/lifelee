// Controllers

angular.module('weaver.ui.dashboard').controller('ShowFacilitiesController', ['$scope', '$state', 'AUTH', function($scope, $state, AUTH){

    // Load
    AUTH.user.promise('workspaces').then(function(workspaces) {
      $scope.workspace = workspaces[0]
    })

}]);