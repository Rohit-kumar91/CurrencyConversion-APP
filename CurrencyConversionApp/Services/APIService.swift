//
//  APIService.swift
//  CurrencyConversionApp
//
//  Created by Rohit Kumar on 04/02/23.
//

import Foundation

protocol APIServiceProtocol {
  func getDataFromURL(_ endPoint: EndPoint, completion: @escaping (Result<Data, APIError>) -> ())
}

final class APIService: APIServiceProtocol {
  
  private let session: URLSessionProtocol
  
  init(session: URLSessionProtocol) {
    self.session = session
  }
  
  func getDataFromURL(_ endPoint: EndPoint, completion: @escaping (Result<Data, APIError>) -> ()) {
    
    guard let url = endPoint.url else {
      return completion(.failure(APIError.invalidURL))
    }

    if !Utilities.isInternetAvailable() {
      completion(.failure(APIError.noNetwork))
      return
    }

    var request = URLRequest(url: url)
    request.httpMethod = endPoint.method.rawValue
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    if let data = endPoint.data {
      request.httpBody = data
    }
    
    let task = session.dataTask(with: request) { (data, response, error) in
      
      guard let statusCode = (response as? HTTPURLResponse)?.statusCode, 200..<299 ~= statusCode else {
        completion(.failure(APIError.checkErrorCode((response as? HTTPURLResponse)!.statusCode)))
        return
      }
      guard data != nil else {
        completion(.failure(APIError.noData))
        return
      }
      
      completion(.success(data!))
    }
    task.resume()
  }
  
}
