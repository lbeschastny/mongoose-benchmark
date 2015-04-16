run = require './runner'

init = ->

cleanup = (data) ->

tasks = "#{__dirname}/tasks"

module.exports = main = ->
  run {init, cleanup, tasks}

unless module.parent
  main().then (stats) ->
    console.log stat for stat in stats
    return
  .otherwise (err) ->
    console.error err.stack || err
  .ensure ->
    process.exit()
