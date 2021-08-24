//
//  CDSectionModel+CoreDataProperties.swift
//  mood-recorder
//
//  Created by LanNTH on 08/08/2021.
//
//

import Foundation
import CoreData

extension CDSectionModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDSectionModel> {
        return NSFetchRequest<CDSectionModel>(entityName: "CDSectionModel")
    }

    @NSManaged public var sectionID: Double
    @NSManaged public var isVisible: Bool

    @NSManaged public var origin: CDInputModel?
    @NSManaged public var content: CDContentModel?

}

extension CDSectionModel: Clone {
    func clone() -> SafeSectionModel {
        return SafeSectionModel(sectionID: sectionID,
                                isVisible: isVisible,
                                content: content?.clone())
    }
}

extension CDSectionModel: Identifiable {

}
