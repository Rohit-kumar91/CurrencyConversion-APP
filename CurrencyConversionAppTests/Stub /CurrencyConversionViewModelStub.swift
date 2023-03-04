//
//  CurrencyConversionViewModelStub.swift
//  CurrencyConversionAppTests
//
//  Created by Rohit Kumar on 05/02/23.
//

import Foundation
@testable import CurrencyConversionApp

class CurrencyConversionViewModelStub: CurrencyConversionViewModel {
  
  override var currencyCount: Int {
    return cellViewModels.count
  }
  
  override var cellViewModels: [CurrencyDataViewModel] {
    get {
      return [CurrencyDataViewModel(code: "USD", name: "United States Dollar"),
              CurrencyDataViewModel(code: "EUR", name: "Euro"),
              CurrencyDataViewModel(code: "JPY", name: "Japanese Yen")]
    }
    set {
      // Do nothing
    }
  }
}
