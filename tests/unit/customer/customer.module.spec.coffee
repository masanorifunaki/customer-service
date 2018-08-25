chai           = require 'chai'
expect         = chai.expect

CustomerModule = require '../../../modules/customer/customer.module'

describe 'CustomerModule', () ->

  describe 'customer.module file', () ->
    it 'should confirm CustomerModule function exist', () ->
      expect(CustomerModule).to.be.a('function')

    it 'should confirm CustomerModule function returns an object', () ->
      expect(CustomerModule()).to.be.a('object')