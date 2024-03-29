//
//  UIWindow.swift
//  CurrencyConversionApp
//
//  Created by Rohit Kumar on 06/02/23.
//

import UIKit

extension UIWindow {
  static var key: UIWindow? {
    if #available(iOS 13, *) {
      return UIApplication.shared.windows.first { $0.isKeyWindow }
    } else {
      return UIApplication.shared.keyWindow
    }
  }
}
