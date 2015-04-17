mongoose = require 'mongoose'

mongoose.connect 'mongodb://localhost/mongoose-benchmark'

r = ->
  Math.random().toString 36

Schema = new mongoose.Schema
  _id: String
  data:
    type: [s: String]
    default: ->
      {s: r()} for i in [1..1000]

module.exports = mongoose.model 'Test', Schema
