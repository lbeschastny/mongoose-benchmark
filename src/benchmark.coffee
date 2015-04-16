benchmark = require 'benchmark'
When = require 'when'
_ = require 'underscore'

benchmark.options.initCount = 1

stat = ({resolve}) -> (event) ->
  resolve _.extend {@name, @stats}, process.memoryUsage()

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

module.exports = (handler, opts) ->
  main (task, data) ->
    {resolver, promise} = When.defer()
    bench = new benchmark task, handler
    bench.on 'complete', stat resolver
    bench.run opts
    promise
