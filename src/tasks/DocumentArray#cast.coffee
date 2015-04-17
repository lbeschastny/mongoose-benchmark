benchmark = require '../benchmark'
Model = require '../model'

model = new Model undefined, {}, true
schema = Model.schema.path 'data'

benchmark ({_doc}, done) ->
  schema.cast _doc.data, model, true
  done()
