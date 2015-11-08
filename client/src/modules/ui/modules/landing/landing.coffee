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
      building = new Building({name: 'Päiväkoti Hansa'})
      building.create()
      workspace.add(building, 'buildings')

      space = new Space({name: 'Room 1'})
      space.create()
      building.add(space, 'spaces')

      sensor = new Sensor({name: 'Sensor CO2 Live', live: true})
      space.add(sensor, 'sensors')
      sensor.create()

      space = new Space({name: 'Room 2'})
      space.create()
      building.add(space, 'spaces')

      sensor = new Sensor({name: 'Sensor CO2'})
      space.add(sensor, 'sensors')
      sensor.create()

      measurement = new Measurement({value: '200'})
      measurement.create()
      sensor.add(measurement, 'measurements')


      space = new Space({name: 'Room 3'})
      space.create()
      building.add(space, 'spaces')

      sensor = new Sensor({name: 'Sensor CO2'})
      space.add(sensor, 'sensors')
      sensor.create()

      measurement = new Measurement({value: '450'})
      measurement.create()
      sensor.add(measurement, 'measurements')

      space = new Space({name: 'Room 4'})
      space.create()
      building.add(space, 'spaces')

      sensor = new Sensor({name: 'Sensor CO2'})
      space.add(sensor, 'sensors')
      sensor.create()

      measurement = new Measurement({value: '350'})
      measurement.create()
      sensor.add(measurement, 'measurements')


      space = new Space({name: 'Room 5'})
      space.create()
      building.add(space, 'spaces')

      sensor = new Sensor({name: 'Sensor CO2'})
      space.add(sensor, 'sensors')
      sensor.create()

      measurement = new Measurement({value: '400'})
      measurement.create()
      sensor.add(measurement, 'measurements')


      space = new Space({name: 'Room 6'})
      space.create()
      building.add(space, 'spaces')

      sensor = new Sensor({name: 'Sensor CO2'})
      space.add(sensor, 'sensors')
      sensor.create()

      measurement = new Measurement({value: '900'})
      measurement.create()
      sensor.add(measurement, 'measurements')


      space = new Space({name: 'Room 7'})
      space.create()
      building.add(space, 'spaces')

      sensor = new Sensor({name: 'Sensor CO2'})
      space.add(sensor, 'sensors')
      sensor.create()

      measurement = new Measurement({value: '500'})
      measurement.create()
      sensor.add(measurement, 'measurements')

      space = new Space({name: 'Room 8'})
      space.create()
      building.add(space, 'spaces')

      sensor = new Sensor({name: 'Sensor CO2'})
      space.add(sensor, 'sensors')
      sensor.create()

      measurement = new Measurement({value: '600'})
      measurement.create()
      sensor.add(measurement, 'measurements')


      building = new Building({name: 'Tapiolan Koulu'})
      building.create()
      workspace.add(building, 'buildings')

      space = new Space({name: 'Room 1'})
      space.create()
      building.add(space, 'spaces')

      sensor = new Sensor({name: 'Sensor CO2'})
      space.add(sensor, 'sensors')
      sensor.create()

      measurement = new Measurement({value: '200'})
      measurement.create()
      sensor.add(measurement, 'measurements')

      space = new Space({name: 'Room 2'})
      space.create()
      building.add(space, 'spaces')

      sensor = new Sensor({name: 'Sensor CO2'})
      space.add(sensor, 'sensors')
      sensor.create()

      measurement = new Measurement({value: '400'})
      measurement.create()
      sensor.add(measurement, 'measurements')


      space = new Space({name: 'Room 3'})
      space.create()
      building.add(space, 'spaces')

      sensor = new Sensor({name: 'Sensor CO2'})
      space.add(sensor, 'sensors')
      sensor.create()

      measurement = new Measurement({value: '450'})
      measurement.create()
      sensor.add(measurement, 'measurements')

      space = new Space({name: 'Room 4'})
      space.create()
      building.add(space, 'spaces')

      sensor = new Sensor({name: 'Sensor CO2'})
      space.add(sensor, 'sensors')
      sensor.create()

      measurement = new Measurement({value: '1000'})
      measurement.create()
      sensor.add(measurement, 'measurements')

      user.set('lastPath', 'dashboard')
      $state.go('dashboard')
    )