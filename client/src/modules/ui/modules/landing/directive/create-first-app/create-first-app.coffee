angular.module 'weaver.ui.landing'

# Opens the modal
.directive('createFirstApp', ($modal) ->
  restrict: 'A'
  link: (scope, element) ->
    element.bind('click', ->
      $modal.open(
        templateUrl: 'src/modules/landing/directive/create-first-app/create-first-app.ng.html'
        animation: false
        size: "sm"
        backdrop: true
        windowClass: 'create-first-app-modal'

        # Controller for the modal to create a project
        controller: (PROJECT, $scope, FocusService, Project, AppService, LocationService, GuideService, User) ->

          exampleAppName = "My Todo's"

          # Model for input
          $scope.guide = true
          $scope.name = exampleAppName

          # Update name when guide checkbox is clicked
          $scope.guideAction = ->
            if $scope.guide
              $scope.name = exampleAppName
            else if $scope.name is exampleAppName
              $scope.name = ""
              FocusService('guideAction')


          # When clicked on the create button
          $scope.createApp = (appName, guide) ->

            # Enable or disable the guide in the next section
            # Bootstrap tour!
            #if(guide)
            #  GuideService.enableGuide()

            # We have to Signup first. Its a preliminary signup, which turns complete when the user supplies
            # his email and name in a later stadium, but for now, just register the signup at the server
            # Note that when signing up, a secured authenticated socket connection is initiated, that we need for future
            # server requests
            #User.setLastPath('projects')

            User.signup().then(User.authenticate).then(User.sendState)

            description = "This is your first project. A project groups datasets and apps together.
                           A dataset is the heart of the app, and drives its dynamic behaviour."

            project = Project.createFirst('First project', description)



            # Now we are going to initialize the project and app.
            # Notice that we are not waiting for the signup to complete (i.e. have a socket connection ready), since
            # the services just wait themselves when saving.
            # Also notice that we're not waiting for any promise when creating stuff as well, we generate each object id
            # locally so we do not need to wait for the server.
            # However, we assume right now that saving is going to work, so think of a fallback strategy later :)

            # !! FInally, create a project!


            # Create project and app
            #app     = AppService.create(appName)

            # Add app to project
            #project.addApp(app)
            #ProjectService.update(project)

            # Close the modal
            $scope.$close()

            # Get ready for the launch!
            LocationService.toLastPath()
      )
    )
)