chai               = require 'chai'
expect             = chai.expect
sinon              = require 'sinon'
httpMocks          = require 'node-mocks-http'
bluebird           = require 'bluebird'
Promise            = bluebird.Promise

CustomerModule     = require('../../../modules/customer/customer.module')()
CustomerMiddleware = CustomerModule.CustomerMiddleware
CustomerService    = CustomerModule.CustomerService

Fixtures           = require '../../fixtures/fixtures'
CustomerFixture    = Fixtures.CustomerFixture
ErrorFixture       = Fixtures.ErrorFixture

req                = ''
res                = ''
next               = ''

describe 'CustomerMiddleware', () =>

  beforeEach () =>
    req = httpMocks.createRequest()
    res = httpMocks.createResponse()
    next = sinon.spy()

  describe 'addCustomer', () =>
    createCustomer = ''
    createCustomerPromise = ''
    expectedCreatedCustomer = ''
    expectedError = ''

    beforeEach () =>
      createCustomer = sinon.stub CustomerService, 'createCustomer'
      req.body = CustomerFixture.newCustomer

    afterEach () =>
      createCustomer.restore()

    it 'should successfully create new customer', () =>
      expectedCreatedCustomer = CustomerFixture.createdCustomer

      createCustomerPromise = Promise.resolve expectedCreatedCustomer
      createCustomer.withArgs(req.body).returns createCustomerPromise

      CustomerMiddleware.addCustomer req, res, next

      sinon.assert.callCount createCustomer, 1

      createCustomerPromise.then () =>
        expect(req.response).to.be.a('object')
        expect(req.response).to.deep.equal(expectedCreatedCustomer)
        sinon.assert.callCount next, 1

    it 'should throw error while creating the new customer', () =>
      expectedError = ErrorFixture.unknownError

      createCustomerPromise = Promise.reject expectedError
      createCustomer.withArgs(req.body).returns createCustomerPromise

      CustomerMiddleware.addCustomer req, res, next

      sinon.assert.callCount createCustomer, 1

      createCustomerPromise.catch (error) =>
        expect(error).to.be.a('object')
        expect(error).to.deep.equal(expectedError)