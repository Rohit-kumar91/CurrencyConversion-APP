//
//  ViewControllerTest.swift
//  CurrencyConversionAppTests
//
//  Created by Rohit Kumar on 05/02/23.
//

import XCTest
@testable import CurrencyConversionApp

final class ViewControllerTest: XCTestCase {
  
  var storyboard: UIStoryboard?
  var viewController: ViewController?
  
  override func setUpWithError() throws {
    storyboard = UIStoryboard(name: "Main", bundle: nil)
    viewController = storyboard!.instantiateViewController(withIdentifier: "ViewController") as? ViewController
  }
  
  override func tearDownWithError() throws {
    storyboard = nil
    viewController = nil
  }
  
  
  
  func testViewControllerLoadedFromStoryboard() {
    XCTAssertNotNil(viewController, "The view controller should not be nil")
  }
  
  func testTableViewLoaded() {
    _ = viewController!.view
    XCTAssertNotNil(viewController!.tableView, "The tableView should not be nil")
  }
  
  func testNumberOfRowsInSectionCalled() {
    _ = viewController!.view
    
    let mockDataSource = MockTableViewDataSource()
    viewController!.tableView.dataSource = mockDataSource
    viewController!.tableView.reloadData()
    XCTAssertTrue(mockDataSource.numberOfRowsInSectionCalled, "The numberOfRowsInSection method should be called")
  }
  
  func testCellForRowAtCalled() {
    _ = viewController!.view
    
    let mockDataSource = MockTableViewDataSource()
    viewController!.tableView.dataSource = mockDataSource
    viewController!.tableView.reloadData()
    
    let visibleCells = viewController!.tableView.visibleCells
    XCTAssertGreaterThan(visibleCells.count, 0, "At least one cell should be visible")
    XCTAssertTrue(mockDataSource.cellForRowAtCalled, "The cellForRowAt method should be called")
  }
  
  func testShouldChangeCharactersInWithValidInput() {
    let textField = UITextField()
    let range = NSRange(location: 0, length: 0)
    let string = "12345"
    let expectedResult = true
    
    let result = viewController!.textField(textField, shouldChangeCharactersIn: range, replacementString: string)
    
    XCTAssertEqual(result, expectedResult, "The method should return true for valid input")
  }
  
  func testShouldChangeCharactersInWithInvalidInput() {
    let textField = UITextField()
    let range = NSRange(location: 0, length: 0)
    let string = "abc"
    let expectedResult = false
    
    let result = viewController!.textField(textField, shouldChangeCharactersIn: range, replacementString: string)
    
    XCTAssertEqual(result, expectedResult, "The method should return false for invalid input")
  }

  func testNumberOfComponentInPickerViewCalled() {
    _ = viewController!.view
    
    let mockDataSource = MockPickerViewDataSource()
    viewController!.pickerView.dataSource = mockDataSource
    viewController!.pickerView.reloadAllComponents()

    XCTAssertTrue(mockDataSource.numberOfComponentsCalled)
  }
  
}
