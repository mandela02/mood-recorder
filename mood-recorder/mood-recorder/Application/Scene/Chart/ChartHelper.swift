//
//  ChartHelper.swift
//  ChartHelper
//
//  Created by TriBQ on 8/23/21.
//

import SwiftUI

struct OptionCountModel {
    var option: ImageAndTitleModel
    var count: Int
}

struct PieSliceModel {
     var startDegree: Double
     var endDegree: Double
}

enum ChartType: CaseIterable, StringValueProtocol {
    case bar
    case pie
    
    var value: String {
        switch self {
        case .bar:
            return "Bar Chart"
        case .pie:
            return "Pie Chart"
        }
    }
}

struct ChartHelper {
    static func precent(precent: CGFloat) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent

        return formatter.string(from: NSNumber(value: precent)) ?? "0%"
    }

    static func normalizedValue(index: Int, data: [PercentChartData]) -> CGFloat {
        let total = data.map { $0.percent }.reduce(0, +)
        return data[index].percent / total
    }
}
