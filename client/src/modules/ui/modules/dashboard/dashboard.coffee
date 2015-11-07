'use strict'

angular.module 'weaver.ui.dashboard', [
  'weaver.data'
  'weaver.auth'
]

.config ($stateProvider) ->
  $stateProvider
  .state 'dashboard',
    url: "/dashboard",
    templateUrl: 'src/modules/ui/modules/dashboard/home.ng.html'
    controller: 'ShowFacilitiesController'

.controller 'DashboardCtrl', ($stateParams, $scope, $state, AUTH) ->

  # Load
  AUTH.user.promise('workspaces').then((workspaces) ->
    $scope.workspace = workspaces[0]
  )

  $scope.signout = ->
    AUTH.signout()
    $state.go('landing')