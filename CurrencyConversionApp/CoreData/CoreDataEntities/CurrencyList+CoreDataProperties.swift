//
//  CurrencyList+CoreDataProperties.swift
//  CurrencyConversionApp
//
//  Created by Rohit Kumar on 06/02/23.
//
//

import Foundation
import CoreData

extension CurrencyList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CurrencyList> {
        return NSFetchRequest<CurrencyList>(entityName: "CurrencyList")
    }

    @NSManaged public var code: String
    @NSManaged public var name: String

}

extension CurrencyList : Identifiable {

}
