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

    @NSManaged public var optionID: Double
    @NSManaged public var isSelected: Bool
    @NSManaged public var content: CDContentModel?

}

extension CDOptionModel : Identifiable {

}
