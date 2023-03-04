//
//  CurrencyDataViewModel.swift
//  CurrencyConversionApp
//
//  Created by Rohit Kumar on 05/02/23.
//

import Foundation

struct CurrencyDataViewModel {
  let code, name: String
  var amount, symbol: String?
  
  init(code: String, name: String) {
    self.code = code
    self.name = name
    self.symbol = Utilities.getCurrencySymbol(code)
  }
}
