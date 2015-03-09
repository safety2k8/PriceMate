BaseModel = require '../models/base'
dataRepository = require '../data/dataRepository'

class Shop extends BaseModel
    constructor: (options) ->
        super options
        { @name } = options if options
      
    @find: (callback) ->
        dataRepository.shops.select {}, (err, result) ->
            callback? err, (new Shop shop for shop in result if result?)

    @create: (shop, callback) ->
        dataRepository.shops.insert shop, (err, result) ->
            callback? err, (new Shop(result) if result?)

    @get: (id, callback) ->
        dataRepository.shops.select { id }, (err, result) ->
            callback? err, (new Shop(result) if result?)
        
    @update: (id, shop, callback) ->
        shop?.id = shop?.id || id
        dataRepository.shops.update shop, (err, result) ->
            callback? err, (new Shop(result) if result?)
        
    @remove: (id, callback) ->
        dataRepository.shops.delete id, (err, result) ->
            callback? err, (new Shop(result) if result?)
            
        
        
module.exports = Shop