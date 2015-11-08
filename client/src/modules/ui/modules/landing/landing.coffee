'use strict'

angular.module 'weaver.ui.landing', [
  'weaver.ui'
  'weaver.auth'
]

.config ($stateProvider) ->
  $stateProvider
  .state 'landing',
    url: '',
    templateUrl: 'src/modules/ui/modules/landing/landing.ng.html'
    controller: 'LandingCtrl'

.controller 'LandingCtrl', ($scope, $state, AUTH, Organization, Workspace, Building, Space, Sensor, Measurement) ->

  $scope.start = ->
    AUTH.signup().then(->

      user = AUTH.user
      organization = new Organization({name: 'Default Organization'})
      organization.create()
      user.add(organization, 'organizations')

      workspace = new Workspace({name: 'Default Workspace'})
      workspace.create()
      user.add(workspace, 'workspaces')

      # Bootstrap buildings
      building = new Building({name: 'Kindergarden Espoo'})
      building.create()
      workspace.add(building, 'buildings')

      space = new Space({name: 'Room 101'})
      space.create()
      building.add(space, 'spaces')

      sensor = new Sensor({name: 'Sensor CO2 Live', live: true})
      space.add(sensor, 'sensors')
      sensor.create()

      sensor2 = new Sensor({name: 'Sensor CO2'})
      sensor2.create()
      space.add(sensor2, 'sensors')

      measurement = new Measurement({value: '150'})
      measurement.create()
      sensor2.add(measurement, 'measurements')

      sensor = new Sensor({name: 'Sensor Occupancy'})
      sensor.create()
      space.add(sensor, 'sensors')

      measurement = new Measurement({value: '297'})
      measurement.create()
      sensor.add(measurement, 'measurements')



      building = new Building({name: 'Kindergarden #2'})
      building.create()
      workspace.add(building, 'buildings')

      building = new Building({name: 'Kindergarden #3'})
      building.create()
      workspace.add(building, 'buildings')

      building = new Building({name: 'Kindergarden #4'})
      building.create()
      workspace.add(building, 'buildings')

      user.set('lastPath', 'dashboard')
      $state.go('dashboard')
    )