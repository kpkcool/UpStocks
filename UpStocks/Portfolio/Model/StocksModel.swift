//
//  StocksModel.swift
//  UpStocks
//
//  Created by K Praveen Kumar on 23/05/24.
//

class StocksModel: Codable {
    var data: StockData?
}

class StockData: Codable {
    var userHolding: [Stock]?
}

class Stock: Codable {
    var stockName: String?
    var netQuantity: Int?
    var lastTradedPrice: Double?
    var avgPrice: Double?
    var closePrice: Double?
    
    enum CodingKeys: String, CodingKey {
        case stockName = "symbol"
        case netQuantity = "quantity"
        case lastTradedPrice = "ltp"
        case avgPrice
        case closePrice = "close"
    }
}
