_ = require 'underscore'

pretty = ({name, rss, heapTotal, heapUsed, stats}) ->
  {mean} = stats
  round = (num) -> Math.round(100 * num)/100
  elapsed = round mean*1000
  memory = round rss/1000000
  ttl = round heapTotal/1000000
  used = round heapUsed/1000000
  [ "\t#{name}:"
    "rss: #{memory} MB"
    "heapTotal: #{ttl} MB"
    "heapUsed: #{used} MB"
    "elapsed time: #{elapsed} ms"
  ].join '\n\t\t'

exports.prettify = (stats) ->
  pretty stat for stat in stats

exports.params = (args) ->
  is_key = (str) -> str.indexOf('-') is 0
  opts = _.filter args, is_key
  tasks = _.reject args, is_key
  [opts, tasks]
