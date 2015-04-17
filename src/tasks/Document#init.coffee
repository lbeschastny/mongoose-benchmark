benchmark = require '../benchmark'
Model = require '../model'

benchmark ({_doc}, done) ->
  model = new Model undefined, {}, true
  model.init _doc, undefined, done
