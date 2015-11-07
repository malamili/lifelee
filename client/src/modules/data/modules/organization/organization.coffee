'use strict'

angular.module 'weaver.data.organization', [
  'weaver.data'
  'weaver.data.workspace'
  'weaver.util'
  'LocalForageModule'       # Store data in the best available storage solution (IndexedDB / WebSQL / localstorage)
  'angular-cache'           # A very useful replacement for Angular's $cacheFactory.
]