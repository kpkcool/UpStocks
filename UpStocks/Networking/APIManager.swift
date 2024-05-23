//
//  APIManager.swift
//  UpStocks
//
//  Created by K Praveen Kumar on 23/05/24.
//

import Foundation

final class APIManager {
    
    static let shared = APIManager()
    private init() {}
    
    func loadDatafromJSON(completion: @escaping ((Result<[Stock]?, Error>) -> Void)) {
        let urlString = Constants.url
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
            }
            
            guard let data = data else { return }
            
            do {
                let stockData = try JSONDecoder().decode(StocksModel.self, from: data)
                completion(.success(stockData.data?.userHolding))
            } catch {
                completion(.failure(error))
                print(error.localizedDescription)
            }
        }.resume()
    }
}
