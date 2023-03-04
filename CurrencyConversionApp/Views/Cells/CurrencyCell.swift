//
//  CurrencyCell.swift
//  CurrencyConversionApp
//
//  Created by Rohit Kumar on 05/02/23.
//

import UIKit

final class CurrencyCell: UITableViewCell {
  
  public static let reusableIdendifier: String = "CurrencyCell"
  
  // MARK: - Outlet
  @IBOutlet weak var codeLabel: UILabel!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var amountLabel: UILabel! {
    didSet {
      amountLabel.isHidden = true
    }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    selectionStyle = .none
    accessoryType = .none
  }
  
  // MARK: - Public Function
  func configureCell(_ currencyDataViewModel: CurrencyDataViewModel) {
    codeLabel.text = "\(currencyDataViewModel.code)"
    nameLabel.text = "\(currencyDataViewModel.name)"
    
    if let amount = currencyDataViewModel.amount,
        let symbol = currencyDataViewModel.symbol{
      amountLabel.isHidden = false
      amountLabel.text = "\(symbol) \(amount)"
    }
  }
  
}
