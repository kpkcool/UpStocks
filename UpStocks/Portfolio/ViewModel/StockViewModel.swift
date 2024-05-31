//
//  StockViewModel.swift
//  UpStocks
//
//  Created by K Praveen Kumar on 23/05/24.
//

import Combine

enum Event {
    case loading
    case loaded
    case error(Error?)
}
/*
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
*/

//MARK: - Using Combine PassthroughSubject
/*
class StockViewModel {
    
    var stockArray: [Stock] = []
    var stocksPublisher = PassthroughSubject<Any, Error>()
    
    func loadData() {
        APIManager.shared.loadDatafromJSON { result in
            switch result {
            case .success(let stockData):
                self.stockArray = stockData ?? []
                self.stocksPublisher.send(completion: .finished)
            case .failure(let error):
                self.stocksPublisher.send(completion: .failure(error))
            }
        }
    }
}
*/

//MARK: - Using Combine CurrentValueSubject
/*
class StockViewModel {
    
    var stockArray: [Stock] = []
    var stocksPublisher = CurrentValueSubject<[Stock], Error>([])
    
    func loadData() {
        APIManager.shared.loadDatafromJSON { result in
            switch result {
            case .success(let stockData):
                self.stockArray = stockData ?? []
                self.stocksPublisher.send(self.stockArray)
            case .failure(let error):
                // Handle error (not sending completion since we are using CurrentValueSubject)
                print(error.localizedDescription)
            }
        }
    }
}
*/

//MARK: - Using Combine CurrentValueSubject
class StockViewModel {
    
    @Published var stockArray: [Stock] = []
    @Published var isLoading: Bool = false
    
    func loadData() {
        isLoading = true
        APIManager.shared.loadDatafromJSON { result in
            self.isLoading = false
            switch result {
            case .success(let stockData):
                self.stockArray = stockData ?? []
            case .failure(let error):
                // Handle error
                print(error.localizedDescription)
            }
        }
    }
}
