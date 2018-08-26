CustomerService = require('./customer.module')().CustomerService

addCustomer = (req, res, next) ->

  success = (data) ->
    req.response = data
    next()

  failure = (error) ->
    next error

  CustomerService.createCustomer req.body
    .then (success)
    .catch (failure)

module.exports =
  addCustomer: addCustomer