benchmark = require '../benchmark'
Model = require '../model'

benchmark ({_id}, done) ->
  Model.collection.findOne {_id}, done
