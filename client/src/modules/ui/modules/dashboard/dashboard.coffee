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
  $scope.series = ['Sensor CO2']
  #$scope.sensor = {}


  # Load
  AUTH.user.promise('workspaces').then((workspaces) ->
    $scope.workspace = workspaces[0]
    $scope.selectedBuilding = $scope.workspace.objects.buildings[0]
    $scope.space  = $scope.workspace.objects.buildings[0].objects.spaces[0]
    $scope.sensor = $scope.space.objects.sensors[0]

    $scope.selectedSpace = $scope.space

    $scope.data[0] = $scope.sensor.measurementValues
    $scope.labels  = $scope.sensor.measurementIntervals
  )

  $scope.onClick = (points, evt) ->
    console.log(points, evt)


  $scope.selectSensor = (space) ->
    $scope.sensor = space.objects.sensors[0]
    $scope.space = space
    $scope.data[0] = $scope.sensor.measurementValues
    $scope.labels  = $scope.sensor.measurementIntervals

    #console.log(space)

  $scope.activate = (building) ->
    $scope.selectedBuilding = building

  $scope.isActive = (building) ->
    $scope.selectedBuilding is building

  $scope.signout = ->
    AUTH.signout()
    $state.go('landing')