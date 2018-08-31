chai            = require 'chai'
expect          = chai.expect
sinon           = require('sinon')
require 'sinon-mongoose'

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

  describe 'fetchCustomers', () =>
    expectedCustomers = ''
    expectedError = ''

    it 'should successfully fetch all customers', () =>
      expectedCustomers = CustomerFixture.customers

      CustomerModelMock.expects 'find'
        .withArgs {}
        .chain 'exec'
        .resolves expectedCustomers

      CustomerService.fetchCustomers()
        .then (data) =>
          CustomerModelMock.verify()
          expect(data).to.deep.equal(expectedCustomers)

    it 'should throw error while fetching all customers', () =>
      expectedError = ErrorFixture.unknownError

      CustomerModelMock.expects 'find'
        .withArgs {}
        .chain 'exec'
        .resolves expectedError

      CustomerService.fetchCustomers()
        .catch (error) =>
          CustomerModelMock.verify()
          expect(error).to.deep.equal(expectedError)

  describe 'fetchCustomerById', () ->
    expectedFetchedCustomer = ''
    customerId = ''
    expectedError = ''

    it 'should successfully fetch the customer by id', () =>
      expectedFetchedCustomer = CustomerFixture.createdCustomer
      customerId = expectedFetchedCustomer._id

      CustomerModelMock.expects 'findById'
        .withArgs customerId
        .chain 'exec'
        .resolves expectedFetchedCustomer

      CustomerService.fetchCustomerById customerId
        .then (data) =>
          CustomerModelMock.verify()
          expect(data).to.deep.equal(expectedFetchedCustomer)

    it 'should throw error while fetching all customers', () =>
      customerId = CustomerFixture.createdCustomer._id
      expectedError = ErrorFixture.unknownError

      CustomerModelMock.expects 'findById'
        .withArgs customerId
        .chain 'exec'
        .rejects expectedError

      CustomerService.fetchCustomerById(customerId)
        .catch (error) =>
          CustomerModelMock.verify()
          expect(error).to.deep.equal(expectedError)