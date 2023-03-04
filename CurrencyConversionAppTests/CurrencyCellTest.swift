//
//  CurrencyCellTest.swift
//  CurrencyConversionAppTests
//
//  Created by Rohit Kumar on 05/02/23.
//

import XCTest
@testable import CurrencyConversionApp

final class CurrencyCellTest: XCTestCase {
    
  func testConfigure() {
    let tableView = UITableView()
    tableView.register(UINib(nibName: "CurrencyCell", bundle: nil), forCellReuseIdentifier: CurrencyCell.reusableIdendifier)
    let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyCell.reusableIdendifier, for: IndexPath(row: 0, section: 0)) as! CurrencyCell

    var testData = CurrencyDataViewModel(code: "AFN", name: "Afghan Afghani")
    testData.amount = "0.8888586"
    cell.configureCell(testData)
    
    XCTAssertEqual(cell.codeLabel.text, testData.code)
    XCTAssertEqual(cell.nameLabel.text, testData.name)
    
    if let symbol = testData.symbol,
       let amount = testData.amount {
      XCTAssertEqual(cell.amountLabel.text, "\(symbol) \(amount)")
    }
  }
}
