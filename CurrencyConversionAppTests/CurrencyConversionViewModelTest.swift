//
//  CurrencyConversionViewModelTest.swift
//  CurrencyConversionAppTests
//
//  Created by Rohit Kumar on 05/02/23.
//

import XCTest
import CoreData
@testable import CurrencyConversionApp

final class CurrencyConversionViewModelTest: XCTestCase {
  
  var sut: CurrencyConversionViewModel!
  var apiService: MockAPIService!
  var coreDataManger: MockCoreDataManager!
  
  override func setUpWithError() throws {
    apiService = MockAPIService()
    
    let persistentContainer = NSPersistentContainer(name: AppConstants.AppName)
    persistentContainer.loadPersistentStores { (storeDescription, error) in
      XCTAssertNil(error)
    }
    
    coreDataManger = MockCoreDataManager(persistentContainer: persistentContainer)
    sut = CurrencyConversionViewModel(apiService: apiService,
                                      coreDataManager: coreDataManger)
  }
  
  override func tearDownWithError() throws {
    sut = nil
    apiService = nil
  }
  
  func testGetCurrenciesList() {
    sut.getCurrenciesList()
    XCTAssertTrue(apiService.getDataFromURLCalled)
  }
  
  func testProcessFetchedData() {
    let data: [String: String] = ["USD": "United States Dollar",
                                  "EUR": "Euro",
                                  "JPY": "Japanese Yen"]
    sut.processFetchedData(data)
    XCTAssertEqual(sut.cellViewModels.count, 3)
    XCTAssertEqual(sut.cellViewModels.first?.code, "EUR")
    XCTAssertEqual(sut.cellViewModels.first?.name, "Euro")
  }
  
  func testCalculateConversions() {
    let data: [String: Float] = ["USD": 1.0,
                                 "EUR": 0.8,
                                 "JPY": 120.0]
    sut.processFetchedData(["USD": "United States Dollar",
                            "EUR": "Euro",
                            "JPY": "Japanese Yen"])
    sut.enteredAmount = 100.0
    sut.selectedCurrencyIndex = 0
    sut.calculateConversions(data)
    XCTAssertEqual(sut.cellViewModels.first?.amount!, "100.0")
    XCTAssertEqual(sut.cellViewModels[1].amount!, "15000.0")
    XCTAssertEqual(sut.cellViewModels[2].amount!, "125.0")
  }
  
  func testGetCellViewModel() {
    sut.processFetchedData(["USD": "United States Dollar",
                            "EUR": "Euro",
                            "JPY": "Japanese Yen"])
    let cellViewModel = sut.getCellViewModel(at: 1)
    XCTAssertEqual(cellViewModel.code, "JPY")
    XCTAssertEqual(cellViewModel.name, "Japanese Yen")
  }
  
  func testSaveCurrentLocalFetchTime() {
    
    sut.saveCurrentLocalFetchTime()
    
    let lastFetchDate = coreDataManger.fetch(objectType: LastFetchInterval.self).first?.date
    XCTAssertNotNil(lastFetchDate, "Check Local Time Is Saved")
  }
  
  
  func testFetchDataFromLocal() {
    let date = Date()
    let isFetchingFromLocal = sut.isValidFetchTime(lastFetchDate: date)
    XCTAssertTrue(isFetchingFromLocal, "Only Fetch Data From Local")
  }
  
  func testFetchDataFromServer() {
    
  }
}
