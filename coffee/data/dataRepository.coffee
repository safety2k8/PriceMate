fs = require 'fs'

data = {}
index = {}

loadData = ->
    data = JSON.parse fs.readFileSync 'data/data.json', 'utf8'
    indexData()

indexData = ->
    createIndex = (array) ->
        result = { _maxId: 0 }
        array?.forEach (item) ->
            result[item.id] = item
            result._maxId = item.id if item.id > result._maxId
            return
        result

    index = 
        shops: createIndex data.shops
        articles: createIndex data.articles
        receipts: createIndex data.receipts

selectFrom = (tableName, criteria, callback) ->
    if criteria?.id?
        idx = index[tableName]
        return callback? null, idx[criteria.id]
        
    tbl = data[tableName]
    callback? null, tbl

insertInto = (tableName, record, callback) ->
    tbl = data[tableName]
    idx = index[tableName]
    
    record.id = ++idx._maxId
    tbl.push record
    idx[record.id] = record
    
    callback? null, record

updateIn = (tableName, record, callback) ->

deleteFrom = (tableName, id, callback) ->

loadData()

module.exports = {
    shops: 
        select: (criteria, callback) ->
            selectFrom 'shops', criteria, callback
            
        create: (shop, callback) ->
            insertInto 'shops', shop, callback
    
    articles: {}
    
    receipts: {}
}