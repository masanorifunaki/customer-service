mongoose = require 'mongoose'

mongodbConfig = require('../../config/mongodb/mongodb-config').mongodb

prepareConnectionString = (config) ->
  connectionString = 'mongodb://'

  if config.user
    connectionString += "#{config.user}:#{config.password}@"

  connectionString += "#{config.server}/#{config.database}"

  connectionString

init = () ->
  options =
    promiseLibrary: require 'bluebird'
    useNewUrlParser: true

  connectionString = prepareConnectionString(mongodbConfig)

  mongoose.connect connectionString, options
    .then (result) ->
      console.log "MongoDB connection successful. DB: #{connectionString}"
    .catch (error) ->
      console.log error.message
      console.log "Error occurred while connecting to DB: #{connectionString}"

module.exports =
  init: init
