//
//  PortfolioTableViewCellViewModel.swift
//  UpStocks
//
//  Created by K Praveen Kumar on 23/05/24.
//

class PortfolioTableViewCellViewModel {
    
    var stock: Stock?
    
    init(stock: Stock? = nil) {
        self.stock = stock
    }
    
    var totalAvgPrice: Double {
        return Double(stock?.netQuantity ?? 0) * (stock?.avgPrice ?? 0)
    }
    
    var totalTradingPrice: Double {
        return Double(stock?.netQuantity ?? 0) * (stock?.lastTradedPrice ?? 0)
    }
    
    func getProfitLossValue() -> String? {
        return (totalTradingPrice - totalAvgPrice).toCurrencyString()
    }
    
    func isProfited() -> Bool {
        return totalTradingPrice > totalAvgPrice
    }
}
