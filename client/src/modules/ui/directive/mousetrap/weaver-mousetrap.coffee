'use strict'

angular.module 'weaver.ui'

.directive('weaverMousetrap', ->
  restrict: 'A',
  controller: ($scope, $element, $attrs) ->
    mousetrap = undefined

    $scope.$watch($attrs.weaverMousetrap, ((_mousetrap) ->
      mousetrap = _mousetrap

      for key, value of mousetrap
        window.Mousetrap.unbind(key)
        window.Mousetrap.bind(key, applyWrapper(value))

    ), true)

    applyWrapper = (func) ->
      (e) ->
        if e.preventDefault
          e.preventDefault()
        else
          e.returnValue = false   # internet explorer

        $scope.$apply((-> func(e)))


    $element.bind('$destroy', ->
      if not mousetrap
        return

      for key in mousetrap
        window.Mousetrap.unbind(key)
    )
)