//
//  CoreDataManagerTests.swift
//  CurrencyConversionAppTests
//
//  Created by Rohit Kumar on 06/02/23.
//

import XCTest
import CoreData
@testable import CurrencyConversionApp

final class CoreDataManagerTests: XCTestCase {
  
  var sut: CoreDataManager!
  
  override func setUpWithError() throws {
    let persistentContainer = NSPersistentContainer(name: AppConstants.AppName)
    persistentContainer.loadPersistentStores { (storeDescription, error) in
      XCTAssertNil(error)
    }
    sut = CoreDataManager(persistentContainer: persistentContainer)
  }
  
  override func tearDownWithError() throws {
    sut = nil
  }
  
  func testInsertData() {
    let newCurrency = sut.insertData(objectType: CurrencyList.self)
    XCTAssertNotNil(newCurrency)
  }
  
  func testSaveAndFetchContext() {
    
    //Refresh CurrencyList
    sut.deleteAllRecords(objectType: CurrencyList.self)
    
    //Create New Entry To Test
    let newCurrency = sut.insertData(objectType: CurrencyList.self)
    newCurrency.code = "USD"
    newCurrency.name = "United States Dollar"
    sut.saveContext()
    
    let result = sut.fetch(objectType: CurrencyList.self)
    XCTAssertGreaterThan(result.count, 0)
  }
  
  func testDeleteRecords() {
    sut.deleteAllRecords(objectType: CurrencyList.self)
    let result = sut.fetch(objectType: CurrencyList.self)
    XCTAssertEqual(result.count, 0)
  }
  
}
