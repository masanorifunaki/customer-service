chai            = require 'chai'
chaiHttp        = require 'chai-http'
chai.use chaiHttp

expect          = chai.expect
request         = chai.request

app             = require '../../app'

Fixtures        = require '../fixtures/fixtures'
CustomerFixture = Fixtures.CustomerFixture

baseUri         = '/customers'

describe 'CustomerController', () =>

  describe "POST #{baseUri}", () =>
    it 'should add new customer', (done) =>
      request app
        .post baseUri
        .send CustomerFixture.newCustomer
        .end (err, res) =>

          expect(res.status).to.equal(201)
          expect(res.body).to.not.equal({})
          expect(res.body._id).to.not.equal(undefined)
          expect(res.body.firstName).to.equal(CustomerFixture.createdCustomer.firstName)

      done()