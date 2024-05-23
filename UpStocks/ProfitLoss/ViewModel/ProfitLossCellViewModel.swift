//
//  ProfitLossCellViewModel.swift
//  UpStocks
//
//  Created by K Praveen Kumar on 23/05/24.
//

class ProfitLossCellViewModel {
    
    var profitLossHeader = ProfitLossFooter()
    var stocksArray: [Stock]
    
    init(stocksArray: [Stock]) {
        self.stocksArray = stocksArray
        setupData()
    }
}

//MARK: - Private Methods
private extension ProfitLossCellViewModel {
    
    func setupData() {
        createProfitLossModelArray()
        calculateProfitAndLossPercentage()
        calculateTotalProfitAndLoss()
        profitLossHeader.data?.last?.isProfited = getTodaysProfitAndLoss() > 0
    }
    
    func createProfitLossModelArray() {
        let model1 = ProfitLossModel(name: Constants.kCurrentValue, value: getCurrentValue().toCurrencyString())
        let model2 = ProfitLossModel(name: Constants.kTotalInvestment, value: getTotalInvestment().toCurrencyString())
        let model3 = ProfitLossModel(name: Constants.kTodaysProfitAndLoss, value: getTodaysProfitAndLoss().toCurrencyString())
        profitLossHeader.data?.append(model1)
        profitLossHeader.data?.append(model2)
        profitLossHeader.data?.append(model3)
    }
    
    func calculateTotalProfitAndLoss() {
        profitLossHeader.totalValue = getCurrentValue() - getTotalInvestment()
        profitLossHeader.isProfited = getCurrentValue() > getTotalInvestment()
    }
    
    func calculateProfitAndLossPercentage() {
        profitLossHeader.percentageValue = (getCurrentValue() / getTotalInvestment()) / 100
    }
}

//MARK: - Get Methods
extension ProfitLossCellViewModel {
    
    func getProfitLossModelArray() -> [ProfitLossModel]? {
        return profitLossHeader.data
    }
    
    func getCurrentValue() -> Double {
        var total: Double = 0
        for stock in stocksArray {
            guard let lastTradedPrice = stock.lastTradedPrice, let netQuantity = stock.netQuantity else { return 0}
            total += lastTradedPrice * Double(netQuantity)
        }
        return total
    }
    
    func getTotalInvestment() -> Double {
        var total: Double = 0
        for stock in stocksArray {
            guard let avgPrice = stock.avgPrice, let netQuantity = stock.netQuantity else { return 0}
            total += avgPrice * Double(netQuantity)
        }
        return total
    }
    
    func getTodaysProfitAndLoss() -> Double {
        var total: Double = 0
        for stock in stocksArray {
            guard let closePrice = stock.closePrice, let lastTradedPrice = stock.lastTradedPrice, let netQuantity = stock.netQuantity else { return 0 }
            total += (closePrice - lastTradedPrice) * Double(netQuantity)
        }
        return total
    }
}
