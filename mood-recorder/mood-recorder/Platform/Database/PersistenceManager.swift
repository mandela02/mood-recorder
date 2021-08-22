//
//  PersistenceManager.swift
//  LoveHandler
//
//  Created by LanNTH on 29/04/2021.
//

import Foundation
import CoreData
import SwiftUI

struct DatabaseConstants {
    static var name = "MoodRecorderDataModel"
    static var urlPath = "com.qtcorp.mood-recorder"
}

class PersistenceManager {
    static let shared = PersistenceManager()

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentCloudKitContainer(name: DatabaseConstants.name)

        let localStoreURL = URL.storeURL(for: DatabaseConstants.urlPath, databaseName: DatabaseConstants.name + "Local")
        let localStoreDescription = NSPersistentStoreDescription(url: localStoreURL)
        localStoreDescription.configuration = "Local"

        let cloudStoreURL = URL.storeURL(for: DatabaseConstants.urlPath, databaseName: DatabaseConstants.name + "Cloud")
        let cloudStoreDescription = NSPersistentStoreDescription(url: cloudStoreURL)
        cloudStoreDescription.configuration = "Cloud"

        container.persistentStoreDescriptions = [localStoreDescription,
                                                 cloudStoreDescription]

        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        do {
            // Use the container to initialize the development schema.
            try container.initializeCloudKitSchema(options: [])
        } catch let error {
            print(error)
        }
        return container
    }()

    private init() {
        let center = NotificationCenter.default
        let notification = UIApplication.willResignActiveNotification
        center.addObserver(forName: notification, object: nil, queue: nil) { [weak self] _ in
            guard let self = self else { return }
            if self.persistentContainer.viewContext.hasChanges {
                try? self.persistentContainer.viewContext.save()
            }
        }
    }
}

public extension URL {
    static func storeURL(for appGroup: String, databaseName: String) -> URL {
        guard let fileContainer = FileManager.default
                .containerURL(forSecurityApplicationGroupIdentifier: appGroup)
        else {
            fatalError("Shared file container could not be created.")
        }

        return fileContainer.appendingPathComponent("\(databaseName).store")
    }
}

extension NSManagedObject {
    static func build<O: NSManagedObject>(context: NSManagedObjectContext,
                                          _ builder: (O) -> Void) -> O {
        let object = O(context: context)
        builder(object)
        return object
    }
}
