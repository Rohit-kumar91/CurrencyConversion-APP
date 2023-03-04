//
//  MockURLSessionDataTask.swift
//  CurrencyConversionAppTests
//
//  Created by Rohit on 19/02/23.
//

import Foundation
@testable import CurrencyConversionApp

class MockURLSessionDataTask: URLSessionDataTaskProtocol {
  private(set) var resumeWasCalled = false
  
  func resume() {
    resumeWasCalled = true
  }
}
