fs = require 'fs'

data = {}
index = {}

loadData = ->
    data = JSON.parse fs.readFileSync 'data/data.json', 'utf8'
    indexData()

indexData = ->
    createIndex = (array) ->
        result = { _maxId: 0 }
        array?.forEach (item, index) ->
            result[item.id] = { item, index }
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
        return callback? null, clone idx[criteria.id]?.item
        
    tbl = data[tableName]
    callback? null, clone tbl

insertInto = (tableName, record, callback) ->
    tbl = data[tableName]
    idx = index[tableName]
    
    record.id = ++idx._maxId
    rec = clone record

    i = tbl.push rec
    idx[rec.id] = { item: rec, index: i }
    
    callback? null, record

updateIn = (tableName, record, callback) ->
    return unless record?.id?

    idx = index[tableName]
    idxData = idx[record.id]
    return unless idxData?

    tbl = data[tableName]
    
    rec = clone record
    tbl[idxData.index] = rec
    idxData.item = rec
        
    callback? null, record
    

deleteFrom = (tableName, id, callback) ->
    return unless id?

    idx = index[tableName]
    idxData = idx[id]
    return unless idxData?

    record = idxData.item
    tbl = data[tableName]
    
    tbl[idxData.index] = null
    delete idx[id]
        
    callback? null, record
    

clone = (v) ->
    JSON.parse JSON.stringify v

loadData()

module.exports = {
    shops: 
        select: (criteria, callback) ->
            selectFrom 'shops', criteria, callback
            
        insert: (shop, callback) ->
            insertInto 'shops', shop, callback

        update: (shop, callback) ->
            updateIn 'shops', shop, callback

        delete: (shop, callback) ->
            deleteFrom 'shops', shop, callback
    
    articles: {}
    
    receipts: {}
}