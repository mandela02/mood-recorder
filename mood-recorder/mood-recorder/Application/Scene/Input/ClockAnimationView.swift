//
//  ClockAnimationView.swift
//  ClockAnimationView
//
//  Created by LanNTH on 17/08/2021.
//

import SwiftUI

struct ClockAnimationView: View {
    @State var startProgress: CGFloat = 0
    @State var startAngle: Double = 0
    
    @State var endProgress: CGFloat = 0
    @State var endAngle: Double = 0
    
    private var defaultWidth: CGFloat = 40
    
    let hourStrings: [String]
    
    let sectment: CGFloat
    let offset: CGFloat
    
    init() {
        hourStrings = stride(from: 2, to: 24, by: 2).map {"\($0)"}
        sectment = 360 / CGFloat(hourStrings.count())
    }
    
    
    var body: some View {
        ZStack {
            Theme.current.tableViewColor.background
            GeometryReader { proxy in
                let offset = 0 - (proxy.size.width / 2 - defaultWidth)

                ZStack {
                    makeProgressView()
                    ForEach(hourStrings.indices, id: \.self) { index in
                        Text(hourStrings[index])
                            .font(.system(size: 10))
                            .foregroundColor(Theme.current.commonColor.textColor)
                            .rotationEffect(.degrees(0 - Double(index) * sectment))
                            .offset(y: offset)
                            .rotationEffect(.degrees(Double(index) * sectment))
                    }
                }
            }
            .padding(.all, 50)
        }
    }
}

// MARK: - PROGRESS VIEW
extension ClockAnimationView {
    private func onDragStartCircle(value: DragGesture.Value) {
        let vector = CGVector(dx: value.location.x, dy: value.location.y)
        let radian = atan2(vector.dy - defaultWidth / 2, vector.dx - defaultWidth / 2)
        var angle = radian * 180 / .pi
        
        if angle < 0 {
            angle = 360 + angle
        }
        withAnimation(Animation.linear(duration: 0.15)) {
            let progress = angle / 360
            self.startProgress = progress
            self.startAngle = Double(angle)
        }
    }
    
    private func onDragEndCircle(value: DragGesture.Value) {
        let vector = CGVector(dx: value.location.x, dy: value.location.y)
        let radian = atan2(vector.dy - defaultWidth / 2, vector.dx - defaultWidth / 2)
        var angle = radian * 180 / .pi
        
        if angle < 0 {
            angle = 360 + angle
        }
        withAnimation(Animation.linear(duration: 0.15)) {
            let progress = angle / 360
            self.endProgress = progress
            self.endAngle = Double(angle)
        }
    }
    
    func makeProgressView() -> some View {
        GeometryReader { proxy in
            let size = proxy.size.width
            ZStack {
                Circle()
                    .stroke(Color.black.opacity(0.5),
                            style: StrokeStyle(lineWidth: defaultWidth,
                                               lineCap: .round,
                                               lineJoin: .round))
                    .frame(width: size, height: size, alignment: .center)
                
                Circle()
                    .trim(from: min(startProgress, endProgress),
                          to: max(startProgress, endProgress))
                    .stroke(Theme.current.buttonColor.backgroundColor,
                            style: StrokeStyle(lineWidth: defaultWidth,
                                               lineCap: .round,
                                               lineJoin: .round))
                    .frame(width: size, height: size, alignment: .center)
                    .rotationEffect(.init(degrees: -90))
                
                Circle()
                    .fill(Color.white)
                    .scaleEffect(0.8)
                    .frame(width: defaultWidth, height: defaultWidth, alignment: .center)
                    .offset(x: size / 2)
                    .rotationEffect(.init(degrees: startAngle))
                    .gesture(DragGesture().onChanged(onDragStartCircle(value:)))
                    .rotationEffect(.init(degrees: -90))
                
                Circle()
                    .fill(Color.black)
                    .scaleEffect(0.8)
                    .frame(width: defaultWidth, height: defaultWidth, alignment: .center)
                    .offset(x: size / 2)
                    .rotationEffect(.init(degrees: endAngle))
                    .gesture(DragGesture().onChanged(onDragEndCircle(value:)))
                    .rotationEffect(.init(degrees: -90))
            }
        }
    }
}
