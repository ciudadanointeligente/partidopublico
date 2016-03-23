papuApp.controller("marcoGeneralCtlr", ["$scope","$http", "$location", "$attrs", function ($scope, $http, $location, $attrs) {
  $scope.marco_general = $location.path().split("/")[2];
    
    
  $scope.add_ley = function(object) {
    console.log(object);
    console.log($scope.marco_general);
  };

}]);