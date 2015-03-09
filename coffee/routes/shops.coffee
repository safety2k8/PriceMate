express = require 'express'
Shop = require '../models/shop'

router = express.Router()

router.get '/', (req, res, next) ->
    Shop.find (err, result) ->
        return next err if err
        res.json result

router.post '/', (req, res, next) ->
    Shop.create req.body, (err, result) ->
        return next err if err
        res.json result

router.get '/:id', (req, res, next) ->
    Shop.get req.params.id, (err, result) ->
        return next err if err
        res.json result

router.put '/:id', (req, res) ->
    Shop.update req.params.id, req.body, (err, result) ->
        return next err if err
        res.json result

router.delete '/:id', (req, res) ->
    Shop.remove req.params.id, (err, result) ->
        return next err if err
        res.json result

module.exports = router