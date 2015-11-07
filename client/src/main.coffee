'use strict'

# Checkpoint Charlie

# Bootstraps the application, see https://docs.angularjs.org/guide/bootstrap
#
# We use a manual bootstrap to:
# - Setup a authenticated socket connection to the server
# - Either load the application state, or construct an empty state, to redirect to the correct page
angular.element(document).ready(->

  deferredBootstrapper.bootstrap(
    element: document.body
    module: 'weaver'
    injectorModules: [
      'weaver.auth'
    ]
    moduleResolves: [
      module: 'weaver.auth'
      resolve:
        AUTH: ['Auth', (Auth) ->
          Auth.init()
        ]
    ]
  )
)