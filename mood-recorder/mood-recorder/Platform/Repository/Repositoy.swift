//
//  Repositoy.swift
//  mood-recorder
//
//  Created by LanNTH on 10/06/2021.
//

import Foundation
import CoreData
import Combine

enum DatabaseResponse {
    case success(data: Any?)
    case error(error: Error)
}

protocol RepositoryType {
    associatedtype T
    var entityName: String { get }
    func countAll() -> DatabaseResponse
    func fetchAllData() -> DatabaseResponse
    func fetchRequestGetFirst(predicate: NSPredicate) -> DatabaseResponse
    func fetchRequest(predicate: NSPredicate) -> DatabaseResponse
    func save() -> DatabaseResponse
    func delete(model: T) -> DatabaseResponse
    func publisher() -> AnyPublisher<Void, Never>
}

class Repository<T: NSManagedObject>: RepositoryType {
    var container: NSPersistentContainer {
        PersistenceManager.shared.persistentContainer
    }
    
    var entityName: String {
        return NSStringFromClass(T.self).components(separatedBy: ".").last ?? "Unknown"
    }
    
    func countAll() -> DatabaseResponse {
        return container.viewContext.performAndWait { () -> DatabaseResponse in
            do {
                let request = NSFetchRequest<T>(entityName: entityName)
                let result = try container.viewContext.count(for: request)
                return .success(data: result)
            } catch let error {
                return .error(error: error)
            }
        }
    }
    
    func fetchAllData() -> DatabaseResponse {
        return container.viewContext.performAndWait { () -> DatabaseResponse in
            
            let fetchRequest = NSFetchRequest<T>(entityName: entityName)
            do {
                let result = try container.viewContext.fetch(fetchRequest)
                return .success(data: result)
            } catch let error {
                return .error(error: error)
            }
        }
    }
    
    func fetchRequestGetFirst(predicate: NSPredicate) -> DatabaseResponse {
        let fetchRequest = NSFetchRequest<T>(entityName: entityName)
        fetchRequest.predicate = predicate
        
        return container.viewContext.performAndWait { () -> DatabaseResponse in
            do {
                let result = try container.viewContext.fetch(fetchRequest)
                if result.isEmpty {
                    return .error(error: NSError(domain: "Can not find this record",
                                                 code: 1,
                                                 userInfo: nil))
                } else {
                    return .success(data: result.first)
                }
            } catch let error {
                return .error(error: error)
            }
        }
    }
    
    func fetchRequest(predicate: NSPredicate) -> DatabaseResponse {
        let fetchRequest = NSFetchRequest<T>(entityName: entityName)
        fetchRequest.predicate = predicate
        return container.viewContext.performAndWait { () -> DatabaseResponse in
            do {
                let result = try container.viewContext.fetch(fetchRequest)
                return .success(data: result)
            } catch let error {
                return .error(error: error)
            }
        }
    }
    
    func save() -> DatabaseResponse {
        return container.viewContext.performAndWait { () -> DatabaseResponse in
            do {
                try container.viewContext.save()
                return .success(data: nil)
            } catch let error {
                return .error(error: error)
            }
        }
    }
    
    func delete(model: T) -> DatabaseResponse {
        return container.viewContext.performAndWait { () -> DatabaseResponse in
            container.viewContext.delete(model)
            return save()
        }
    }
    
    func publisher() -> AnyPublisher<Void, Never> {
        var notification: Notification.Name = Notification.Name(rawValue: "")
        if #available(iOS 14.0, *) {
            notification = NSManagedObjectContext.didSaveObjectsNotification
        } else {
            notification = Notification.Name.NSManagedObjectContextDidMergeChangesObjectIDs
        }
        
        let context = PersistenceManager.shared.persistentContainer.viewContext
        
        return NotificationCenter.default.publisher(for: notification, object: context)
            .map { _ in Void() }
            .eraseToAnyPublisher()
    }
}
