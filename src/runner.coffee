{fork, spawn} = require 'child_process'
assert = require 'assert'
path = require 'path'
nodefn = require 'when/node'
When = require 'when'
fs = require 'fs'

{prettify, params} = require './utils'

class Runner
  constructor: (@opts = {}) ->
    assert.equal typeof @opts, 'object'
    @base = path.resolve @opts.tasks ? './tasks'
    tasks = nodefn.call fs.readdir, @base
    @all_tasks = When.map tasks, (task) ->
      path.basename task, path.extname task

  init: ->
    When(@opts.init?()).then (@data) =>

  cleanup: ->
    When @opts.cleanup?(@data)

  fork: (task) ->
    deferred = When.defer()
    child = spawn 'coffee', ["#{@base}/#{task}.coffee"],
      stdio: [0, 1, 2, 'ipc']

    child.on 'message', ({status, stats}) =>
      switch status
        when 'ready'
          child.send {task, @data}
        when 'done'
          deferred.resolve stats
        else
          deferred.reject 'Unknown status'

    child.on 'error', (err) ->
      deferred.reject err

    child.on 'exit', ->
      deferred.reject 'Process died'

    deferred.promise

  run: (tasks) ->
    tasks = @all_tasks unless tasks?.length > 0
    When.reduce tasks, (results, task) =>
      @fork(task).then (res) ->
        results.push res
        results
    , []

  main: ->
    [opts, tasks] = params process.argv[2...]
    @init().then =>
      console.log 'Benchmark started'
      @run tasks
    .then (stats) ->
      return stats if '-r' in opts
      prettify stats
    .tap =>
      @cleanup()

module.exports = (opts) ->
  (new Runner opts).main()
