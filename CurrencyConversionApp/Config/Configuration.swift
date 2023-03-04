//
//  Configuration.swift
//  CurrencyConversionApp
//
//  Created by Rohit Kumar on 05/02/23.
//

import Foundation

enum ConfigurationError: Error {
  case missingKey
}

struct Configurations {
  static func getValue(for key: String) -> String {
    guard let value = Bundle.main.object(forInfoDictionaryKey: key) as? String else {
      return ConfigurationError.missingKey.localizedDescription
    }
    return value
  }
}
