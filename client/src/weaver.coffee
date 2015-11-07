'use strict'

# Weaver root module

angular.module 'weaver',
  [
    # Angular core modules
    'ngAnimate'
    'ngTouch'
    'ngSanitize'

    # 3rd Party Modules
    'ui.router'                        # More advanced routing based on states
    'ui.bootstrap'                     # Angular Dialog
    'ui.bootstrap.contextMenu'         # Context menu for right clicking
    'ui.bootstrap.tooltip'
    'xeditable'

    'weaver.auth'
    'weaver.ui'
  ]


# Configuration
.config(($urlRouterProvider, $locationProvider, $tooltipProvider) ->

  # Default route all to /
  $urlRouterProvider.otherwise('/')

  # Tooltip default settings
  $tooltipProvider.options({
    animation: false
  })
)

.run(($rootScope, $timeout, $state, AUTH, editableOptions) ->

  # Use Bluebird as promise library, because it IS fast
  # More info: http://stackoverflow.com/questions/23984471/how-do-i-use-bluebird-with-angular
  # Note: We wrapped Bluebird global Promise object in a $$Promise service in the weaver module.
  Promise.setScheduler((cb) ->
    $rootScope.$evalAsync(cb)
  )

  # Configure xeditable using bootstrap 3 theme and by default not showing the submit/cancel buttons
  editableOptions.theme = 'bs3'
  editableOptions.buttons = 'no'

  $rootScope.$on('$stateChangeStart', (event, next) ->
    if next.name isnt 'sensors'

      if AUTH.user?
        if next.name isnt AUTH.user.values.lastPath
          event.preventDefault()
          $state.go(AUTH.user.values.lastPath)

      else
        if next.name isnt 'landing'
          $state.go('landing')
  )

  # Always scroll to 0 cross-browser when changing views
  $rootScope.$on('$stateChangeSuccess', ->
    document.body.scrollTop = document.documentElement.scrollTop = 0
  )

  # Head to the right location
  $state.go('landing')
)