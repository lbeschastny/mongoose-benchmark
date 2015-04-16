benchmark = require 'benchmark'
When = require 'when'
_ = require 'underscore'

benchmark.options.initCount = 1

await_data = ->
  {reject, resolve, promise} = When.defer()
  timer = setTimeout ->
    reject 'timeout'
  , 30000
  process.on 'message', (msg) ->
    clearTimeout timer
    resolve msg
  process.send status: 'ready'
  promise

main = (run) ->
  await_data().then ({task, data}) ->
    run task, data
  .then (stats) ->
    process.send {status: 'done', stats}
  .otherwise (err) ->
    console.error err.stack || err
  .ensure ->
    process.exit()

module.exports = (handler) ->
  main (task, data) ->
    {resolve, reject, promise} = When.defer()
    bench = new benchmark task, (deferred) ->
      handler data, (err) ->
        if err
          reject err
        else
          deferred.resolve()
    , defer: yes
    bench.on 'complete', (event) ->
      mem = process.memoryUsage()
      resolve _.extend {@name, @stats}, mem
    bench.run async: yes
    promise
