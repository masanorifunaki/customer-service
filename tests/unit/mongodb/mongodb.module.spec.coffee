chai = require 'chai'
expect = chai.expect

MongoDBModule = require('../../../modules/mongodb/mongodb.module')

describe 'MongoDBUtil', () ->

  describe 'mongodb.module file', () ->

    it 'should read the mongodb.module file', () ->
      expect(MongoDBModule).to.be.a 'object'

    it 'should confirm MongoDBUtil exist', () ->
      expect(MongoDBModule.MongoDBUtil).to.be.a 'object'