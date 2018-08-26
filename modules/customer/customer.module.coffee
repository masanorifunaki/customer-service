init = () ->
  return {
    CustomerController: require './customer.controller'
    CustomerMiddleware: require './customer.middleware'
    CustomerService: require './customer.service'
    CustomerModel: require './customer.model'
  }

module.exports = init