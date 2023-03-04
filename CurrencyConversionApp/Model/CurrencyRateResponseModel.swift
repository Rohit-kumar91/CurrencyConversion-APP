//
//  Currency.swift
//  CurrencyConversionApp
//
//  Created by Rohit Kumar on 04/02/23.
//

import Foundation

struct CurrencyRateResponseModel: Decodable {
  let base: String
  let rates: [String: Float]
}
