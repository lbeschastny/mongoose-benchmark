benchmark = require '../benchmark'
Model = require '../model'

{casterConstructor} = Model.schema.path 'data'

benchmark ({_doc: {data}}, done) ->
  for val in data
    new casterConstructor null, val, true, true
  done()
