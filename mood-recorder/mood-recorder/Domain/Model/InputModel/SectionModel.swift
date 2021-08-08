//
//  SectionModel.swift
//  mood-recorder
//
//  Created by LanNTH on 04/08/2021.
//

import Foundation

class SectionModel: Identifiable {
    init(section: Section, title: String, cell: Any?, isEditable: Bool = true, isVisible: Bool = true) {
        self.section = section
        self.title = title
        self.cell = cell
        self.isEditable = isEditable
        self.isVisible = isVisible
    }
    
    let id = UUID()
    
    let section: Section
    let title: String
    
    var cell: Any?
    
    var isVisible: Bool = true
    var isEditable: Bool = true
}
