createError        = require('http-errors')
express            = require('express')
path               = require('path')
cookieParser       = require('cookie-parser')
logger             = require('morgan')

app                = express()

MongoDBUtil        = require('./modules/mongodb/mongodb.module').MongoDBUtil
CustomerController = require('./modules/customer/customer.module')().CustomerController

# view engine setup
app.set 'views', path.join(__dirname, 'views')
app.set 'view engine', 'pug'
app.use logger('dev')
app.use express.json()
app.use express.urlencoded(extended: false)
app.use cookieParser()
app.use express.static(path.join(__dirname, 'public'))

MongoDBUtil.init()

app.use '/customers', CustomerController

app.use '/', do ->
  router = express.Router()
  router.use '/', require './routes/index.coffee'

  return router

# catch 404 and forward to error handler
app.use (req, res, next) ->
  next createError(404)

# error handler
app.use (err, req, res, next) ->
# set locals, only providing error in development
  res.locals.message = err.message
  res.locals.error = if req.app.get('env') == 'development' then err else {}
  # render the error page
  res.status err.status or 500

  errorMessage =
    message: res.locals.message
    error: res.locals.error

  res.json errorMessage

module.exports = app
