//
//  UIAlertController.swift
//  CurrencyConversionApp
//
//  Created by Rohit Kumar on 04/02/23.
//

import UIKit

private var window: UIWindow!

extension UIAlertController {
  
  class func showAlert(title: String,
                       message: String,
                       cancelButton: String?,
                       otherButtons: [String]? = nil,
                       tapHandler: ((String) -> Void)? = nil) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    
    if let title = cancelButton {
      alert.addAction(UIAlertAction(title: title, style: .cancel, handler: { action in
        if let handler = tapHandler {
          handler(title)
        }
      }))
    }
    
    for buttonTitle in otherButtons ?? [] {
      alert.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: { action in
        if let handler = tapHandler {
          handler(buttonTitle)
        }
      }))
    }
    alert.present(animated: true, completion: nil)
  }
  
  func present(animated: Bool,
               completion: (() -> Void)?) {
    UIWindow.key?.rootViewController?.present(self, animated: true, completion: nil)
  }
  
  open override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    window = nil
  }
}
