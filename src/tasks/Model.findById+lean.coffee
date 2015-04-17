benchmark = require '../benchmark'
Model = require '../model'

benchmark ({_id}, done) ->
  Model.findById(_id).lean().exec done
