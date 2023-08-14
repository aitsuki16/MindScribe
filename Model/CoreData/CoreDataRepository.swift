//
//  PersistenceController.swift
//  mindScribe
//
//  Created by user on 2023/06/11.
//

import Foundation
import CoreData
// Repofetch data and save data
class CoreDataRepository {
    static let shared = CoreDataRepository()
    private let container = NSPersistentContainer(name: "DiaryEntryModel")
    private init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            } else {
                if let url = description.url {
                    print("Core Data store URL:", url.absoluteString)
                }
            }
        }
    }
    
    func newEntity () -> DiaryEntry {
        return DiaryEntry(context: container.viewContext)
    }
    
    func fetch () -> [DiaryEntry] {
        let fetchRequest: NSFetchRequest<DiaryEntry> = DiaryEntry.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        do {
            return try container.viewContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return []
        }
    }
    
    func fetchLatestEntry() -> DiaryEntry? {
        let fetchRequest: NSFetchRequest<DiaryEntry> = DiaryEntry.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "diaryEntry", ascending: false)]
        fetchRequest.fetchLimit = 10
        do {
            return try container.viewContext.fetch(fetchRequest).first
        } catch let error as NSError {
            print("Could not fetch latest entry. \(error), \(error.userInfo)")
            return nil
        }
    }
    
    func save(item: DiaryEntry) {
        // Check if it's a new entry, then insert.
        if item.objectID.isTemporaryID {
            container.viewContext.insert(item)
        }
        
        do {
            try container.viewContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func delete<T: NSManagedObject>(item: T) {
        container.viewContext.delete(item)
    }
    
    func saveContext() {
        do {
            try container.viewContext.save()
        } catch let error as NSError {
            print("Could not save context. \(error), \(error.userInfo)")
        }
    }
    //when to delete all entries
    //    func deleteAllEntries() {
    //        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = DiaryEntry.fetchRequest()
    //        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
    //
    //        do {
    //            try container.viewContext.execute(batchDeleteRequest)
    //        } catch {
    //            print("Error deleting all entries: \(error)")
    //        }
    //    }
    
}
