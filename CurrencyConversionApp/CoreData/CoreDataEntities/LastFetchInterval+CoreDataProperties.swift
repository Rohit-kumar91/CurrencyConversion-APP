//
//  LastFetchInterval+CoreDataProperties.swift
//  CurrencyConversionApp
//
//  Created by Rohit Kumar on 06/02/23.
//
//

import Foundation
import CoreData


extension LastFetchInterval {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LastFetchInterval> {
        return NSFetchRequest<LastFetchInterval>(entityName: "LastFetchInterval")
    }

    @NSManaged public var date: Date?

}

extension LastFetchInterval : Identifiable {

}
