'use strict'

# Returns the day of the week, defined by the EEEE format
# See https://docs.angularjs.org/api/ng/filter/date
# Use it by placing a <today/> tag in your html

angular.module 'weaver.ui.landing'

.directive('weaverToday', ($filter) ->
  template: $filter('date')(new Date(), 'EEEE')
)
