var papuApp = angular.module("papuApp",["ui.bootstrap", 'ngRoute']);

papuApp.config(['$routeProvider', '$locationProvider', function AppConfig($routeProvider, $locationProvider) {
  $locationProvider.html5Mode(true);
}]);