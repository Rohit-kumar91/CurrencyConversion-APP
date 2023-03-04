//
//  CurrencyConversionViewModel.swift
//  CurrencyConversionApp
//
//  Created by Rohit Kumar on 04/02/23.
//

import Foundation

class CurrencyConversionViewModel: NSObject {
  
  // MARK: - Private Properties
  
  let apiService: APIServiceProtocol
  let coreDataManager: CoreDataManager
  var cellViewModels: [CurrencyDataViewModel] = [CurrencyDataViewModel]() {
    didSet {
      self.updataCurrListData?()
      self.updataCurrConvertData?()
    }
  }
  
  // MARK: - Public Properties
  
  var enteredAmount: Float?
  var selectedCurrencyIndex: Int?
  var showAlert: ((String) -> Void)?
  var updataCurrListData: (() -> ())?
  var updataCurrConvertData: (() -> ())?
  var currencyCount: Int {
    return cellViewModels.count
  }
  
  // MARK: - Init
  
  init(apiService: APIServiceProtocol = APIService(session: URLSession.shared),
       coreDataManager: CoreDataManager) {
    self.apiService = apiService
    self.coreDataManager = coreDataManager
  }
  
  //MARK: - Public Functions
  
  func getCurrenciesList() {
    self.apiService.getDataFromURL(.currencyList()) { [weak self] (result) in
      switch result {
      case .success(let data):
        do {
          let response = try JSONDecoder().decode([String: String].self, from: data)
          self?.processFetchedData(response)
        } catch {
          self?.showAlert?(APIError.decodeError.rawValue)
        }
      case .failure(let err):
        self?.showAlert?(err.rawValue)
      }
    }
  }
  
  func getConversionRates() {
    self.apiService.getDataFromURL(.currencyRate()) { [weak self] (result) in
      switch result {
      case .success(let data):
        do {
          let response = try JSONDecoder().decode(CurrencyRateResponseModel.self, from: data)
          self?.calculateConversions(response.rates)
        } catch {
          self?.showAlert?(APIError.decodeError.rawValue)
        }
      case .failure(let err):
        self?.showAlert?(err.rawValue)
      }
    }
  }
  
  func calculateConversions(_ models: [String:Float]) {
    
    guard let index = self.selectedCurrencyIndex,
          let selectedCurrModel = self.getCellViewModel(at: index) as CurrencyDataViewModel?,
          let amount = models[selectedCurrModel.code],
          let enteredAmount = self.enteredAmount else {
      self.showAlert?(APIError.conversionIssue.rawValue)
      return
    }
    
    let selectedCurToUsd = enteredAmount / amount
    
    for (index, item) in self.cellViewModels.enumerated() {
      let temp = models.filter { $0.key == item.code }
      if temp.isEmpty == false {
        if let rate = temp[self.cellViewModels[index].code] {
          self.cellViewModels[index].amount = "\((selectedCurToUsd * rate))"
        }
      }
    }
  }
  
  func getCellViewModel(at index: NSInteger) -> CurrencyDataViewModel {
    return cellViewModels[index]
  }
  
  func processFetchedData(_ models: [String:String]) {
    cellViewModels = models.map { CurrencyDataViewModel(code: $0.key, name: $0.value)  }.sorted(by: ({ $0.name < $1.name }))
   
    refreshCoreData()
    saveCurrencyListInLocal()
    saveCurrentLocalFetchTime()
    fetchSavedCurrencyList()
  }
  
  func refreshCoreData() {
    deleteAllSaveCurrencies()
    deleteFetchLocalTime()
  }
  
  func deleteAllSaveCurrencies() {
    coreDataManager.deleteAllRecords(objectType: CurrencyList.self)
  }
  
  func deleteFetchLocalTime() {
    coreDataManager.deleteAllRecords(objectType: LastFetchInterval.self)
  }
  
  func saveCurrencyListInLocal() {
    for model in cellViewModels {
      let newCurrency = coreDataManager.insertData(objectType: CurrencyList.self)
      newCurrency.code = model.code
      newCurrency.name = model.name
    }
    coreDataManager.saveContext()
  }
  
  func saveCurrentLocalFetchTime() {
    let lastFetchInterval = coreDataManager.insertData(objectType: LastFetchInterval.self)
    lastFetchInterval.date = Date()
    coreDataManager.saveContext()
  }
  
  func fetchSavedCurrencyList() {
    let currencies = coreDataManager.fetch(objectType: CurrencyList.self)
    cellViewModels = currencies.map { CurrencyDataViewModel(code: $0.code, name: $0.name)  }.sorted(by: ({ $0.name < $1.name }))
  }
  
  /**
   
   guard let lastFetchDate = coreDataManager.fetch(objectType: LastFetchInterval.self).first?.date else {
     return true
   }
   */
  func isValidFetchTime(lastFetchDate: Date) -> Bool {
    let timeDifference = Date().timeIntervalSince(lastFetchDate)
    let totalMinutes = Int(timeDifference / 60)
    return totalMinutes > 30
  }
}
