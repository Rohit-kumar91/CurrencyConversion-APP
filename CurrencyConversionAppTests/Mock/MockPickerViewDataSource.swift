//
//  MockPickerView.swift
//  CurrencyConversionAppTests
//
//  Created by Rohit Kumar on 05/02/23.
//

import UIKit

class MockPickerViewDataSource: NSObject, UIPickerViewDataSource {
  
  var numberOfComponentsCalled = false
  var numberOfRowsInComponentCalled = false
  
  
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    numberOfComponentsCalled = true
    return 1
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    numberOfRowsInComponentCalled = true
    return 10
  }
}


