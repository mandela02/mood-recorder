//
//  CDOptionModel+CoreDataProperties.swift
//  mood-recorder
//
//  Created by LanNTH on 08/08/2021.
//
//

import Foundation
import CoreData

extension CDOptionModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDOptionModel> {
        return NSFetchRequest<CDOptionModel>(entityName: "CDOptionModel")
    }

    @NSManaged public var isSelected: Bool
    @NSManaged public var isVisible: Bool
    @NSManaged public var name: String?
    @NSManaged public var image: String?

    @NSManaged public var content: CDContentModel?
}

extension CDOptionModel: Clone {
    func clone() -> SafeOptionModel {
        return SafeOptionModel(isSelected: isSelected, isVisible: isVisible, name: name, image: image)
    }
}

extension CDOptionModel: Identifiable {

}
