//
//  PieChartSliceView.swift
//  PieChartSliceView
//
//  Created by TriBQ on 8/23/21.
//

import SwiftUI

struct PieChartSliceView: View {
    var center: CGPoint
    var radius: CGFloat
    var startDegree: Double
    var endDegree: Double
    var isTouched: Bool
    var accentColor: Color
    var separatorColor: Color
    
    var path: Path {
         var path = Path()
         path.addArc(center: center,
                     radius: radius,
                     startAngle: Angle(degrees: startDegree),
                     endAngle: Angle(degrees: endDegree),
                     clockwise: false)
         path.addLine(to: center)
         path.closeSubpath()
         return path
     }

    var body: some View {
        path
            .fill(accentColor)
            .overlay(path.stroke(separatorColor, lineWidth: 2))
            .scaleEffect(isTouched ? 1.05 : 1)
    }
}
