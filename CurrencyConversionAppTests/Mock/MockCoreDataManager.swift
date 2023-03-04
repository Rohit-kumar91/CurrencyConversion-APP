//
//  MockCoreDataManager.swift
//  CurrencyConversionAppTests
//
//  Created by Rohit Kumar on 07/02/23.
//

import Foundation
import CoreData
@testable import CurrencyConversionApp

class MockCoreDataManager: CoreDataManager {
  
  var insertDataCalled = false
  var saveContextCalled = false
  var fetchCalled = false
  var deleteAllRecordsCalled = false
  
  override func insertData<T: NSManagedObject>(objectType: T.Type) -> T {
    insertDataCalled = true
    return super.insertData(objectType: objectType)
  }
  
  override func saveContext() {
    saveContextCalled = true
    super.saveContext()
  }
  
  override func fetch<T: NSManagedObject>(objectType: T.Type,
                                          predicate: NSPredicate? = nil,
                                          sortDescriptors: [NSSortDescriptor]? = nil) -> [T] {
    fetchCalled = true
    return super.fetch(objectType: objectType, predicate: predicate, sortDescriptors: sortDescriptors)
  }
  
  override func deleteAllRecords<T: NSManagedObject>(objectType: T.Type) {
    deleteAllRecordsCalled = true
    super.deleteAllRecords(objectType: objectType)
  }
}
