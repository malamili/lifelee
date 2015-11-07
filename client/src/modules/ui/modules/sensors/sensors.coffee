'use strict'

angular.module 'weaver.ui.sensors', [
  'weaver.data'
  'rzModule'   # Slider
]

.config ($stateProvider) ->
  $stateProvider
  .state 'sensors',
    url: "/sensors",
    templateUrl: 'src/modules/ui/modules/sensors/sensors.ng.html'
    controller: 'SensorsCtrl'

.controller 'SensorsCtrl', ($stateParams, $scope, $state, AUTH, Measurement) ->

  # Initialize sensors
  $scope.sensor1 = 150;
  $scope.sensor2 = 150;
  $scope.sensor3 = 150;
  $scope.sensor4 = 150;
  $scope.sensor5 = 150;

  $scope.measurements = {}

  # Load
  AUTH.user.promise('workspaces').then((workspaces) ->
    $scope.workspace = workspaces[0]
    $scope.selectedBuilding = $scope.workspace.objects.buildings[0]
    $scope.selectedSpace    = $scope.selectedBuilding.objects.spaces[0]
  )

  $scope.createMeasurement = (sensor) ->
    measurement = new Measurement({value: sensor.lastMeasurement})
    measurement.create()
    sensor.add(measurement, 'measurements')