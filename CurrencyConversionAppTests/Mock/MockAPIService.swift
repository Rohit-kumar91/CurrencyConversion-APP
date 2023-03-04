//
//  APIServiceMock.swift
//  CurrencyConversionAppTests
//
//  Created by Rohit Kumar on 05/02/23.
//

import Foundation
@testable import CurrencyConversionApp

class MockAPIService: APIServiceProtocol {
  var getDataFromURLCalled = false
  var completion: ((Result<Data, APIError>) -> Void)?
  
  func getDataFromURL(_ endPoint: EndPoint, completion: @escaping (Result<Data, APIError>) -> ()) {
    getDataFromURLCalled = true
    self.completion = completion
  }
}
