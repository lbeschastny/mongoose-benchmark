benchmark = require '../benchmark'
Model = require '../model'

model = new Model undefined, {}, true
schema = Model.schema.path 'data'

benchmark ({_doc: {data}}, done) ->
  schema.cast data, model, true
  done()
