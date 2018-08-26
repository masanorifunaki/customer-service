chai            = require 'chai'
expect          = chai.expect
sinon           = require 'sinon'

mongoose        = require 'mongoose'

CustomerModule  = require('../../../modules/customer/customer.module')()
CustomerModel   = CustomerModule.CustomerModel
CustomerService = CustomerModule.CustomerService

Fixtures        = require '../../fixtures/fixtures'
CustomerFixture = Fixtures.CustomerFixture
ErrorFixture    = Fixtures.ErrorFixture

describe 'CustomerService', () =>
  CustomerModelMock = ''

  beforeEach () =>
    CustomerModelMock = sinon.mock CustomerModel

  afterEach () =>
    CustomerModelMock.restore()

    mongoose.models = {}
    mongoose.modelSchemas = {}

    mongoose.connection.close

  describe 'createCustomer', () =>

    it 'should successfully create new customer', () =>
      newCustomer = CustomerFixture.newCustomer
      expectedCreatedCustomer = CustomerFixture.createdCustomer

      CustomerModelMock.expects('create')
        .withArgs newCustomer
        .resolves expectedCreatedCustomer

      CustomerService.createCustomer newCustomer
        .then (data) =>
          CustomerModelMock.verify()
          expect(data).to.deep.equal(expectedCreatedCustomer)

    it 'should throw error while creating customer', () =>
      expectedError = ErrorFixture.unknownError
      newCustomer = CustomerFixture.newCustomer

      CustomerModelMock.expects('create')
        .withArgs newCustomer
        .rejects expectedError

      CustomerService.createCustomer newCustomer
        .catch (error) =>
          CustomerModelMock.verify()
          expect(error).to.deep.equal(expectedError)



