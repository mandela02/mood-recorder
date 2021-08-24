//
//  CDContentModel+CoreDataProperties.swift
//  mood-recorder
//
//  Created by LanNTH on 08/08/2021.
//
//

import Foundation
import CoreData

struct SafeContentModel {
    var emotion: Double
    var bedTime: String?
    var wakeUpTime: String?
    var image: Data?
    var text: String?
    var options: [SafeOptionModel]
}

extension CDContentModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDContentModel> {
        return NSFetchRequest<CDContentModel>(entityName: "CDContentModel")
    }
    
    @NSManaged public var emotion: Double
    @NSManaged public var bedTime: String?
    @NSManaged public var wakeUpTime: String?
    @NSManaged public var image: Data?
    @NSManaged public var text: String?
    @NSManaged public var options: NSSet?
    @NSManaged public var section: CDSectionModel?

    var optionArray: [CDOptionModel] {
        let set = options as? Set<CDOptionModel> ?? []
        
        return Array(set)
    }
}

extension CDContentModel: Clone {
    func clone() -> SafeContentModel {
        SafeContentModel(emotion: emotion,
                         bedTime: bedTime,
                         wakeUpTime: wakeUpTime,
                         image: image,
                         text: text,
                         options: optionArray.map { $0.clone() })
    }
}

// MARK: Generated accessors for options
extension CDContentModel {

    @objc(addOptionsObject:)
    @NSManaged public func addToOptions(_ value: CDOptionModel)

    @objc(removeOptionsObject:)
    @NSManaged public func removeFromOptions(_ value: CDOptionModel)

    @objc(addOptions:)
    @NSManaged public func addToOptions(_ values: NSSet)

    @objc(removeOptions:)
    @NSManaged public func removeFromOptions(_ values: NSSet)

}

extension CDContentModel: Identifiable {

}
