//
//  ViewConrtoller+Extension.swift
//  CurrencyConversionApp
//
//  Created by Rohit Kumar on 05/02/23.
//

import Foundation
import UIKit

private let MAX_AMOUNT_LENGHT = 7
private let ACCEPTABLE_NUMBERS = "0123456789."

//MARK: - UIPickerView delegates

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
  
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return viewModel.currencyCount
  }
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    let model = viewModel.getCellViewModel(at: row )
    return "\(model.name) (\(model.code))"
  }
  
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    self.currencyTextField.text = viewModel.getCellViewModel( at: row ).code
  }
}

//MARK: - CustomPickerViewDelegate delegates

extension ViewController: CustomPickerViewDelegate {
  
  @objc func didTapDone() {
    self.amountTextField.resignFirstResponder()
    self.currencyTextField.resignFirstResponder()
    
    if amountTextField.text?.utf8.count == 0 || currencyTextField.text?.utf8.count == 0 {
      
      DispatchQueue.main.async {
        self.amountTextField.text = ""
        self.currencyTextField.text = ""
        UIAlertController.showAlert(title: LocalizableStrings.error,
                                    message: LocalizableStrings.validationErrorMessage,
                                    cancelButton: LocalizableStrings.ok)
      }
      return
    }
    
    let row = self.pickerView.selectedRow(inComponent: 0)
    self.viewModel.enteredAmount = (self.amountTextField.text! as NSString).floatValue
    self.viewModel.selectedCurrencyIndex = row
    self.viewModel.getConversionRates()
  }
  
  func didTapCancel() {
    self.currencyTextField.resignFirstResponder()
  }
}

//MARK: - UITextFieldDelegate delegates

extension ViewController: UITextFieldDelegate {
  
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    
    let newLength: Int = textField.text!.count + string.count - range.length
    let numberOnly = NSCharacterSet.init(charactersIn: ACCEPTABLE_NUMBERS).inverted
    let strValid = string.rangeOfCharacter(from: numberOnly) == nil
    
    if let text = textField.text as NSString? {
      let updatedText = text.replacingCharacters(in: range, with: string)
      if Float(updatedText) != nil || Int(updatedText) != nil || updatedText == "" {
        return (strValid && (newLength <= MAX_AMOUNT_LENGHT) )
      }
    }
    return false
  }
  
  func textFieldDidEndEditing(_ textField: UITextField) {
    self.didTapDone()
  }
}

//MARK: - UITableViewDelegate and UITableViewDataSource delegates

extension ViewController: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    viewModel.currencyCount
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyCell.reusableIdendifier, for: indexPath) as! CurrencyCell
    cell.configureCell(viewModel.getCellViewModel(at: indexPath.row))
    return cell
  }
  
}
