mongoose = require 'mongoose'

mongoose.connect 'mongodb://localhost/mongoose-benchmark'

Schema = new mongoose.Schema
  _id: String

r_num = ->
  Math.random()

r_str = ->
  r_num().toString 36

r_date = ->
  new Date r_num()*Date.now()

for i in [1..1000]
  obj =
    str: type: String, default: r_str
    num: type: Number, default: r_num
    date: type: Date, default: r_date
  Schema.add obj, "prefix_#{i}."

module.exports = mongoose.model 'Test', Schema
