mongoose = require 'mongoose'

run = require './runner'
Model = require './model'

init = ->
  _id = Math.random().toString(36).slice(2,12)
  Model.create({_id}).then -> {_id}

cleanup = ({_id}) ->
  Model.findByIdAndRemove(_id).exec()

tasks = "#{__dirname}/tasks"

module.exports = main = ->
  run {init, cleanup, tasks}

unless module.parent
  console.log [
    "Node.js #{process.version}"
    "Mongoose@#{mongoose.version}"
  ].join ' '
  main().then (stats) ->
    console.log stat for stat in stats
    return
  .otherwise (err) ->
    console.error err.stack || err
  .ensure ->
    process.exit()
