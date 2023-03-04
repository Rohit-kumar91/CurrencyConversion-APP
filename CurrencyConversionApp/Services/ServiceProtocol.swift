//
//  ServiceProtocol.swift
//  CurrencyConversionApp
//
//  Created by Rohit on 19/02/23.
//

import Foundation

protocol URLSessionProtocol {
  
  typealias DataCompletion = (Data?, URLResponse?, Error?) -> Void
  
  func dataTask(with request: URLRequest, completionHandler: @escaping DataCompletion) -> URLSessionDataTaskProtocol
}

protocol URLSessionDataTaskProtocol {
  func resume()
}

extension URLSessionDataTask: URLSessionDataTaskProtocol { }


extension URLSession: URLSessionProtocol {
  func dataTask(with request: URLRequest, completionHandler: @escaping DataCompletion) -> URLSessionDataTaskProtocol {
    return dataTask(with: request, completionHandler: completionHandler) as URLSessionDataTaskProtocol
  }
}
