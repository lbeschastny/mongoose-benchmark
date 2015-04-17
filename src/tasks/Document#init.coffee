benchmark = require '../benchmark'
Model = require '../model'

{data} = new Model

benchmark ({_id}, done) ->
  model = new Model undefined, {}, true
  model.init {_id, data}, undefined, done
