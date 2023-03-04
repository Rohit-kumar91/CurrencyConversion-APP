//
//  EndPoint.swift
//  CurrencyConversionApp
//
//  Created by Rohit Kumar on 04/02/23.
//

import Foundation

struct EndPoint {
  let method: HTTPMethod
  private let path: String
  private(set) var queryItem: [String: Any]?
  private(set) var data: Data?
  
  /// GET request
  private init(method: HTTPMethod, path: String, queryItem: [String: Any]?) {
    self.method = method
    self.path = path
    self.queryItem = queryItem
  }
  
  /// POST request
  private init(method: HTTPMethod, path: String, data: Data) {
    self.method = method
    self.path = path
    self.data = data
  }
  
}

extension EndPoint {
  
  static func currencyList() -> EndPoint {
    return EndPoint(method: .get, path: "/api/currencies.json", queryItem: nil)
  }
  
  static func currencyRate() -> EndPoint {
    return EndPoint(method: .get, path: "/api/latest.json", queryItem: [AppConstants.APIParams.accessKey : Configurations.getValue(for: AppConstants.Keys.APIKey)])
  }
}

extension EndPoint {
  var url: URL? {
    var components = URLComponents()
    components.scheme = Configurations.getValue(for: AppConstants.Keys.scheme)
    components.host = Configurations.getValue(for: AppConstants.Keys.host)
    components.path = path
    if queryItem?.isEmpty == false {
      components.setQueryItems(with: queryItem!)
    }
    return components.url
  }
}

extension URLComponents {
  
  mutating func setQueryItems(with parameters: [String: Any]) {
    self.queryItems = parameters.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
  }
}
