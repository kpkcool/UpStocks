//
//  StockViewModel.swift
//  UpStocks
//
//  Created by K Praveen Kumar on 23/05/24.
//

enum Event {
    case loading
    case loaded
    case error(Error?)
}

class StockViewModel {
    
    var stockArray: [Stock] = []
    var eventHandler: ((_ event: Event) -> Void)?
    
    func loadData() {
        eventHandler?(.loading)
        APIManager.shared.loadDatafromJSON { result in
            switch result {
            case .success(let stockData):
                self.stockArray = stockData ?? []
                self.eventHandler?(.loaded)
            case .failure(let error):
                self.eventHandler?(.error(error))
            }
        }
    }
}
