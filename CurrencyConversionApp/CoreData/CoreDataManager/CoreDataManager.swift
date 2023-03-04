//
//  CoreDataManager.swift
//  CurrencyConversionApp
//
//  Created by Rohit Kumar on 06/02/23.
//

import CoreData

class CoreDataManager {
  
  // MARK: - Properties
  
  let persistentContainer: NSPersistentContainer
  
  var viewContext: NSManagedObjectContext {
    return persistentContainer.viewContext
  }
  
  // MARK: - init
  
  init(persistentContainer: NSPersistentContainer) {
    self.persistentContainer = persistentContainer
  }
  

  // MARK: - Methods
  
  func insertData<T: NSManagedObject>(objectType: T.Type) -> T {
    let newObject = NSEntityDescription.insertNewObject(forEntityName: String(describing: objectType),
                                                        into: viewContext)
    return newObject as! T
  }
  
  func saveContext() {
    let context = persistentContainer.viewContext
    if context.hasChanges {
      do {
        try context.save()
      } catch {
        let nserror = error as NSError
        fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
      }
    }
  }
  
  func fetch<T: NSManagedObject>(objectType: T.Type,
                                 predicate: NSPredicate? = nil,
                                 sortDescriptors: [NSSortDescriptor]? = nil) -> [T] {
    let fetchRequest = NSFetchRequest<T>(entityName: String(describing: objectType))
    fetchRequest.predicate = predicate
    fetchRequest.sortDescriptors = sortDescriptors
    
    do {
      let results = try viewContext.fetch(fetchRequest)
      return results
    } catch {
      print("Error fetching data: \(error)")
      return []
    }
  }
  
  func deleteAllRecords<T: NSManagedObject>(objectType: T.Type) {
    let context = persistentContainer.viewContext
    let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: objectType))
    let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
    do {
      try context.execute(deleteRequest)
      try context.save()
    }
    catch {
      print ("There was an error")
    }
  }
      
}
