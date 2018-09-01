CustomerService = require('./customer.module')().CustomerService

addCustomer = (req, res, next) ->

  success = (data) ->
    req.response = data
    next()

  failure = (error) ->
    next error

  CustomerService.createCustomer req.body
    .then(success)
    .catch(failure)

getCustomers = (req, res, next) ->

  success = (data) ->
    req.response = data
    next()

  failure = (error) ->
    next error

  CustomerService.fetchCustomers()
    .then(success)
    .catch(failure)

getCustomerById = (req, res, next) =>
  success = (data) =>
    req.response = data
    next()

  CustomerService.fetchCustomerById(req.params.customerId)
    .then (success)



module.exports =
  addCustomer: addCustomer
  getCustomers: getCustomers
  getCustomerById: getCustomerById