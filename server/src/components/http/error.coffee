error = (errorMessage) ->
  Error errorObject = new Error(JSON.stringify(errorMessage))
  errorObject.name = 'weaver.fired.error'
  errorObject

module.exports =
  unauthorized: ->
    error
      code: 1000
      status: 403
      message: 'Unauthorized to access this service'