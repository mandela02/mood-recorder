//
//  CDDiaryModel+CoreDataProperties.swift
//  mood-recorder
//
//  Created by LanNTH on 08/08/2021.
//
//

import Foundation
import CoreData

extension CDDiaryModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDDiaryModel> {
        return NSFetchRequest<CDDiaryModel>(entityName: "CDDiaryModel")
    }

    @NSManaged public var date: Double
    @NSManaged public var sections: NSSet?

    var sectionArray: [CDSectionModel] {
        let set = sections as? Set<CDSectionModel> ?? []
        return set.sorted(by: { $0.sectionID < $1.sectionID })
    }
}

extension CDDiaryModel: Clone {
    func clone() -> SafeDiaryModel {
        SafeDiaryModel(date: date,
                       sections: sectionArray.map { $0.clone() })
    }
}

// MARK: Generated accessors for sections
extension CDDiaryModel {

    @objc(addSectionsObject:)
    @NSManaged public func addToSections(_ value: CDSectionModel)

    @objc(removeSectionsObject:)
    @NSManaged public func removeFromSections(_ value: CDSectionModel)

    @objc(addSections:)
    @NSManaged public func addToSections(_ values: NSSet)

    @objc(removeSections:)
    @NSManaged public func removeFromSections(_ values: NSSet)

}

extension CDDiaryModel: Identifiable {

}
