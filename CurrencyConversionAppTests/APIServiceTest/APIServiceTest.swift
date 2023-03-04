//
//  APIServiceTest.swift
//  CurrencyConversionAppTests
//
//  Created by Rohit Kumar on 05/02/23.
//

import XCTest
@testable import CurrencyConversionApp

final class APIServiceTest: XCTestCase {
  
  // MARK: - Properties
  var apiService: APIService?
  var mockURLSession = MockURLSesssion()
  
  override func setUpWithError() throws {
    apiService = APIService(session: mockURLSession)
  }
  
  override func tearDownWithError() throws {
    apiService = nil
  }
  
  func test_get_request_with_url() {
    apiService?.getDataFromURL(.currencyList(), completion: { result in
      //handle api response
    })
    
    XCTAssert(mockURLSession.url == EndPoint.currencyList().url)
  }
  
  func test_get_request_success_response_Data() {
    let expected = "{}".data(using: .utf8)
    mockURLSession.data = expected
    
    var actualData: Data?
    apiService?.getDataFromURL(.currencyList(), completion: { result in
      switch result {
      case .success(let data):
        actualData = data
        break
        
      case .failure:
        //Failure Case.
        break
      }
    })
    
    XCTAssertNotNil(actualData)
  }
  
  func test_get_request_failure_error() {
    let expected = APIError.invalidURL
    mockURLSession.error = expected
    
    var actualError: Error?
    apiService?.getDataFromURL(.currencyList(), completion: { result in
      switch result {
      case .success:
        break
        
      case .failure(let error):
        actualError = error
        break
      }
    })
    
    XCTAssertNotNil(actualError)
  }
  
  func test_get_request_resume_called(){
    let dataTask = MockURLSessionDataTask()
    mockURLSession.dataTask = dataTask
    
    apiService?.getDataFromURL(.currencyList(), completion: { result in
      //handle reponse
    })
    
    XCTAssertTrue(dataTask.resumeWasCalled)
  }
    

  
  func testInternetAvailabilitySuccess() {
    let internetAvailable = Utilities.isInternetAvailable()
    XCTAssertTrue(internetAvailable, "Internet is Available")
  }
  
}
