CustomerModel = require('./customer.module')().CustomerModel

createCustomer = (customer) ->
  CustomerModel.create customer

fetchCustomers = () ->
  CustomerModel.find({})
    .exec()

module.exports =
  createCustomer: createCustomer
  fetchCustomers: fetchCustomers