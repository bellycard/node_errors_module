path = require 'path'

# parse the error definitions
# errors = require(path.join('definitions', 'errors.json'))

errors = require(path.join(__dirname, '..', '..', '..', 'definitions', 'errors.json'))

## helper for accessing messages (used in our integration tests)
exports.outputFor = (code) ->
  error:
    message: errors[code].message
    code:    code

## AUTOMATICALLY REGISTER A HELPER METHOD FOR EACH TYPE OF ERROR WE HANDLE
for code, definition of errors
  # dynamically build a method for this error
  do ->
    _code = code
    _definition = definition
    exports[_code] = (res, debug_data) ->

      # http status code
      res.statusCode = _definition.http_status
      # console output
      if res.app.settings.env isnt 'test'
        console.log "ERROR #{_definition.http_status}: #{_code} - #{_definition.message}".error
        if debug_data
          console.log JSON.stringify(debug_data).error

      output =
        error:
          message: _definition.message
          code:    _code

      if debug_data and res.app.settings.env is 'development'
        output.debug = debug_data

      # http body response
      res.json output

