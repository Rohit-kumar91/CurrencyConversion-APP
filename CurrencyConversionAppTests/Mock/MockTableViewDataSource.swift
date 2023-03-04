//
//  MockTableViewDataSource.swift
//  CurrencyConversionAppTests
//
//  Created by Rohit Kumar on 05/02/23.
//

import UIKit

class MockTableViewDataSource: NSObject, UITableViewDataSource {
  
  var numberOfRowsInSectionCalled = false
  var cellForRowAtCalled = false
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    numberOfRowsInSectionCalled = true
    return 10
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    cellForRowAtCalled = true
    return UITableViewCell()
  }
}
