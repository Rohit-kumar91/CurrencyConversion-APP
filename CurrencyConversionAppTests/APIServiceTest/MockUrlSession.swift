//
//  MockUrlSession.swift
//  CurrencyConversionAppTests
//
//  Created by Rohit on 19/02/23.
//

import Foundation
@testable import CurrencyConversionApp

class MockURLSesssion: URLSessionProtocol {
 
  var dataTask = MockURLSessionDataTask()
  var data: Data?
  var error: Error?
  private(set) var url: URL?
  
  func successHTTPResponse(request: URLRequest) -> URLResponse {
    return HTTPURLResponse(url: request.url!,
                           statusCode: 200,
                           httpVersion: "HTTP/1.0",
                           headerFields: nil)!
  }
  
  func dataTask(with request: URLRequest, completionHandler: @escaping DataCompletion) -> URLSessionDataTaskProtocol {
    url = request.url
    completionHandler(data, successHTTPResponse(request: request), error)
    return dataTask
  }
}
