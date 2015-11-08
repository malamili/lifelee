'use strict'

angular.module 'weaver.ui.dashboard', [
  'weaver.data'
  'weaver.auth'
  'chart.js'
]

.config ($stateProvider) ->
  $stateProvider
  .state 'dashboard',
    url: "/dashboard",
    templateUrl: 'src/modules/ui/modules/dashboard/dashboard.ng.html'
    controller: 'DashboardCtrl'

.controller 'DashboardCtrl', ($stateParams, $scope, $state, AUTH) ->
  $scope.data = [[]]
  $scope.labels = []
  $scope.series = ['Sensor CO2'];
  #$scope.sensor = {}


  # Load
  AUTH.user.promise('workspaces').then((workspaces) ->
    $scope.workspace = workspaces[0]
    $scope.sensor = $scope.workspace.objects.buildings[0].objects.spaces[0].objects.sensors[1]
    console.log($scope.sensor)
    $scope.data[0] = $scope.sensor.measurementValues
    $scope.labels  = $scope.sensor.measurementIntervals
  )

  $scope.onClick = (points, evt) ->
    console.log(points, evt)


  $scope.signout = ->
    AUTH.signout()
    $state.go('landing')