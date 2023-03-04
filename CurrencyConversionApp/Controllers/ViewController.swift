//
//  ViewController.swift
//  CurrencyConversionApp
//
//  Created by Rohit Kumar on 04/02/23.
//

import UIKit

final class ViewController: UIViewController {
  
  // MARK: Outlets
  
  @IBOutlet weak var amountTextField: UITextField! {
    didSet {
      amountTextField.textAlignment = .right
      amountTextField.font = UIFont.systemFont(ofSize: 20)
      amountTextField.keyboardType = UIKeyboardType.decimalPad
      amountTextField.returnKeyType = UIReturnKeyType.done
      amountTextField.placeholder = LocalizableStrings.enterAmount
      amountTextField.borderStyle = UITextField.BorderStyle.roundedRect
    }
  }
  
  @IBOutlet weak var currencyTextField: UITextField! {
    didSet {
      let imageView = UIImageView()
      let image = UIImage(systemName: "chevron.down")
      imageView.image = image
      currencyTextField.rightView = imageView
      currencyTextField.rightViewMode = .always
      currencyTextField.font = UIFont.systemFont(ofSize: 18)
      currencyTextField.placeholder = LocalizableStrings.selectCurrency
      currencyTextField.borderStyle = UITextField.BorderStyle.roundedRect
      currencyTextField.inputView = self.pickerView
      currencyTextField.inputAccessoryView = self.pickerView.toolbar
    }
  }
  
  @IBOutlet weak var tableView: UITableView! {
    didSet {
      tableView.register(UINib(nibName: "CurrencyCell", bundle: nil), forCellReuseIdentifier: CurrencyCell.reusableIdendifier)
      tableView.dataSource = self
      tableView.delegate = self
      tableView.backgroundColor = .white
      tableView.separatorColor = .gray
      tableView.isEditing = false
      tableView.showsVerticalScrollIndicator = true
      tableView.tableFooterView = UIView()
    }
  }
  
  // MARK: - Properties
  
  lazy var pickerView: CustomPickerView = {
    let picker = CustomPickerView()
    picker.delegate = self
    picker.dataSource = self
    picker.toolbarDelegate = self
    return picker
  }()
  
  lazy var viewModel: CurrencyConversionViewModel = {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let persistentContainer = appDelegate.persistentContainer
    let coreDataManager = CoreDataManager(persistentContainer: persistentContainer)
    return CurrencyConversionViewModel(coreDataManager: coreDataManager)
  }()
  
  
  // MARK: - Lifecycle Methods
  
  override func viewDidLoad() {
    super.viewDidLoad()

    setupController()
    viewModelClosures()
    fetchData()
    
  }
  
  
  func fetchData() {
    if viewModel.isValidFetchTime() {
      requestGetCurrencies()
    }
    else {
      viewModel.fetchSavedCurrencyList()
    }
  }
  
  // MARK: - Provate Methods
  
  private func setupController() {
    self.title = LocalizableStrings.currencyTitle
    let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
    self.view.addGestureRecognizer(tap)
  }
  
  private func viewModelClosures() {
    
    viewModel.showAlert = { (message) in
      DispatchQueue.main.async {
        UIAlertController.showAlert(title: LocalizableStrings.error, message: message, cancelButton: LocalizableStrings.ok)
      }
    }
    
    viewModel.updataCurrListData = { [weak self] () in
      DispatchQueue.main.async {
        self?.pickerView.reloadAllComponents()
      }
    }
    
    viewModel.updataCurrConvertData = { [weak self] () in
      DispatchQueue.main.async {
        self?.tableView.reloadData()
      }
    }
  }
  
  private func requestGetCurrencies() {
    viewModel.getCurrenciesList()
  }
  
}

