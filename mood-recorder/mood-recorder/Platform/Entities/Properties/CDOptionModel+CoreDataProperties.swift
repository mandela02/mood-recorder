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
    @NSManaged public var name: String?
    @NSManaged public var image: String?

    @NSManaged public var content: CDContentModel?
    
    var wrappedName: String {
        return name ?? ""
    }

    var wrappedImage: String {
        return image ?? ""
    }
}

extension CDOptionModel : Identifiable {

}
