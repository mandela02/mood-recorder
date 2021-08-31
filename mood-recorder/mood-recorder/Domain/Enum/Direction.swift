//
//  Direction.swift
//  Direction
//
//  Created by TriBQ on 8/29/21.
//

import SwiftUI

enum Direction {
    case up
    case down
    case left
    case right
    case non
    
    static func getDirection(value: DragGesture.Value) -> Direction {
        if value.translation.width < 0 &&
            value.translation.height > -30 &&
            value.translation.height < 30 {
            return .left
        } else if value.translation.width > 0 &&
                    value.translation.height > -30 &&
                    value.translation.height < 30 {
            return .right
        } else if value.translation.height < 0 &&
                    value.translation.width < 100 &&
                    value.translation.width > -100 {
            return .up
        } else if value.translation.height > 0 &&
                    value.translation.width < 100 &&
                    value.translation.width > -100 {
            return.down
        } else {
            return .non
        }
    }
}
