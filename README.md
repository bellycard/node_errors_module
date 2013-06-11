node_errors_module
==================

A module to standardize application error output.  We share this between node projects.

### Installation

Add to your dependencies in package.json, with a reference to this repository

```JAVASCRIPT
"dependencies": {
  "node_errors_module": "git://github.com/bellycard/node_errors_module.git#v0.0.2"
}
```

### Usage

Create a file called /definitions/errors.json

```JSON
// errors.json
{
  "internal_server_error": {
    "http_status": 500,
    "message": "Something has gone pear shaped, we have been notified and will try and fix it"
  },
  "not_found": {
    "http_status": 404,
    "message": "Resource not found"
  }
}
```

Basic usage

```JAVASCRIPT
errors = require('node_errors_module')
return errors.not_found(res)
```

You can pass an additional object to create a more verbose error which will be seen only in development

```JAVASCRIPT
errors = require('node_errors_module')

memcache.get "cache_key", (error, result) ->
  return errors.memcache_failed(res, error) if error
  ...

```


### Development

Source files are written in coffee, and compiled into JavaScript.  To watch the src directory and compile js into the add directory
```
coffee -c -b -w -o app/ src/
```
