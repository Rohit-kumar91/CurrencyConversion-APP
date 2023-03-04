//
//  Constant.swift
//  CurrencyConversionApp
//
//  Created by Rohit Kumar on 04/02/23.
//

import Foundation

enum HTTPMethod: String {
  case get = "GET"
  case post = "POST"
}

enum APIError: String, Error {
  case invalidURL = "Invalid url"
  case invalidResponse = "Invalid response"
  case decodeError = "Decode error"
  case pageNotFound = "Requested page not found!"
  case noNetwork = "Internet connection not available!"
  case noData = "Oops! There are no matches for entered text."
  case unknownError = "Unknown error"
  case serverError = "Server error"
  case conversionIssue = "Oops! Getting some conversion issue."
  
  static func checkErrorCode(_ errorCode: Int = 0) -> APIError {
    switch errorCode {
    case 400:
      return .invalidURL
    case 500:
      return .serverError
    case 404:
      return .pageNotFound
    default:
      return .unknownError
    }
  }
}


struct AppConstants {
  
  struct Keys {
    static let APIKey = "APIKey"
    static let scheme = "scheme"
    static let host = "host"
  }
  
  struct APIParams {
    static let accessKey = "app_id"
    static let format = "1"
  }
  
  static let AppName = "CurrencyConversionApp"
}

struct LocalizableStrings {
  
  static let currencyTitle = "Currency Conversion"
  static let alert = "Alert"
  static let error = "Error"
  static let ok = "Ok"
  static let cancel = "Cancel"
  static let done = "Done"
  static let enterAmount = "Enter amount"
  static let selectCurrency = "Currency"
  static let validationErrorMessage = "All Fields Are Required."
  
}

