CustomerModel = require('./customer.module')().CustomerModel

createCustomer = (customer) ->
  CustomerModel.create customer

fetchCustomers = () ->
  CustomerModel.find({})
    .exec()

fetchCustomerById = (customerId) ->
  CustomerModel.findById customerId
    .exec()

module.exports =
  createCustomer: createCustomer
  fetchCustomers: fetchCustomers
  fetchCustomerById: fetchCustomerById