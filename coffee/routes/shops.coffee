express = require 'express'
Shop = require '../models/shop'

router = express.Router()

router.get '/', (req, res, next) ->
    Shop.select (err, result) ->
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
    res.json Shop.update req.body

router.delete '/:id', (req, res) ->
    res.json Shop.delete req.params.id

module.exports = router