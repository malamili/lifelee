'use strict'

angular.module 'weaver.ui.landing'

.directive('weaverTimeOfDay', ->
  timeOfDay = ->
    hour = new Date().getHours()

    return 'night'   if hour > 0  and hour <= 4
    return 'morning' if hour > 4  and hour <= 11
    return 'noon'    if hour > 11 and hour <= 16
    return 'evening' if hour > 16 and hour <= 23

  template: timeOfDay()
)