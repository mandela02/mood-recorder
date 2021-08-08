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
    func fetchRequest(predicate: String, value: String) -> DatabaseResponse
    func save() -> DatabaseResponse
    func delete(model: T)
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
        do {
            let request = NSFetchRequest<T>(entityName: entityName)
            let result = try container.viewContext.count(for: request)
            return .success(data: result)
        } catch let error {
            return .error(error: error)
        }
    }
    
    func fetchAllData() -> DatabaseResponse {
        let fetchRequest = NSFetchRequest<T>(entityName: entityName)
        do {
            let result = try container.viewContext.fetch(fetchRequest)
            return .success(data: result)
        } catch let error {
            return .error(error: error)
        }
    }
    
    func fetchRequest(predicate: String, value: String) -> DatabaseResponse {
        let fetchRequest = NSFetchRequest<T>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "\(predicate) CONTAINS[c] %@", value)
        
        do {
            let result = try container.viewContext.fetch(fetchRequest)
            return .success(data: result.first)
        } catch let error {
            return .error(error: error)
        }
    }
    
    func save() -> DatabaseResponse {
        do {
            try container.viewContext.save()
            return .success(data: nil)
        } catch let error {
            return .error(error: error)
        }
    }
    
    func delete(model: T) {
        container.viewContext.delete(model)
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
