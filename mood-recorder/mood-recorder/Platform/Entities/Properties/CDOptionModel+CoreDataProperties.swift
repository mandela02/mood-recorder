//
//  CDOptionModel+CoreDataProperties.swift
//  mood-recorder
//
//  Created by LanNTH on 08/08/2021.
//
//

import Foundation
import CoreData

protocol Clone {
      associatedtype T
      func clone() -> T
}

struct SafeOptionModel {
    var isSelected: Bool
    var isVisible: Bool
    var name: String?
    var image: String?
    
    var wrappedName: String {
        return name ?? ""
    }

    var wrappedImage: String {
        return image ?? ""
    }
}

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
