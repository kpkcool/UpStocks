//
//  ProfitLossModel.swift
//  UpStocks
//
//  Created by K Praveen Kumar on 23/05/24.
//

import Foundation

class ProfitLossFooter {
    var data: [ProfitLossModel]? = []
    var footerName: String? = Constants.kProfitAndLoss
    var totalValue: Double? = 0.0
    var percentageValue: Double? = 0.0
    var isExpandable: Bool = false
    var isProfited: Bool = false
}

class ProfitLossModel {
    var name: String
    var value: String?
    var isProfited: Bool = false
    
    init(name: String, value: String?) {
        self.name = name
        self.value = value
    }
}
