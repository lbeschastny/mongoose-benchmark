mongoose = require 'mongoose'

mongoose.connect 'mongodb://localhost/mongoose-benchmark'

Schema = new mongoose.Schema
  _id: String

module.exports = mongoose.model 'Test', Schema
