CustomerModel = require('./customer.module')().CustomerModel

createCustomer = (customer) ->
  CustomerModel.create customer

module.exports =
  createCustomer: createCustomer