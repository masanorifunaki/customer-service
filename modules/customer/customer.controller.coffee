express            = require 'express'
router             = express.Router()

CustomerMiddleware = require('./customer.module')().CustomerMiddleware

router.post '/',
  CustomerMiddleware.addCustomer,
  (req, res) ->
    res.status(201).json(req.response)

module.exports = router