//
//  PickerView.swift
//  CurrencyConversionApp
//
//  Created by Rohit Kumar on 04/02/23.
//

import Foundation
import UIKit

protocol CustomPickerViewDelegate: AnyObject {
  func didTapDone()
  func didTapCancel()
}

final class CustomPickerView: UIPickerView {
  
  public private(set) var toolbar: UIToolbar?
  public weak var toolbarDelegate: CustomPickerViewDelegate?
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.commonInit()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    self.commonInit()
  }
  
  private func commonInit() {
    let toolBar = UIToolbar()
    toolBar.barStyle = UIBarStyle.default
    toolBar.isTranslucent = true
    toolBar.tintColor = .black
    toolBar.sizeToFit()
    
    let doneButton = UIBarButtonItem(title: LocalizableStrings.done, style: .plain, target: self, action: #selector(self.doneTapped))
    let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    let cancelButton = UIBarButtonItem(title: LocalizableStrings.cancel, style: .plain, target: self, action: #selector(self.cancelTapped))
    
    toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
    toolBar.isUserInteractionEnabled = true
    
    self.toolbar = toolBar
  }
  
  @objc func doneTapped() {
    self.toolbarDelegate?.didTapDone()
  }
  
  @objc func cancelTapped() {
    self.toolbarDelegate?.didTapCancel()
  }
}
