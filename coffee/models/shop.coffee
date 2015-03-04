BaseModel = require '../models/base'
dataRepository = require '../data/dataRepository'

class Shop extends BaseModel
    constructor: (options) ->
        super options
        { @name } = options if options
      
    @select: (callback) ->
        dataRepository.shops.select {}, (err, result) ->
            callback? err, (new Shop shop for shop in result if result?)

    @create: (shop, callback) ->
        dataRepository.shops.create shop, (err, result) ->
            callback? err, (new Shop(result) if result?)

    @get: (id, callback) ->
        dataRepository.shops.select { id }, (err, result) ->
            callback? err, (new Shop(result) if result?)
        
    @update: (shop) ->
        new Shop(dataRepository.shops.update shop)
        
    @remove: (id) ->
        new Shop(dataRepository.shops.remove id)
            
        
        
module.exports = Shop