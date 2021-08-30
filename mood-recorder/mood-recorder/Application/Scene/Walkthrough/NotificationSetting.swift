//
//  NotificationSetting.swift
//  NotificationSetting
//
//  Created by TriBQ on 8/30/21.
//

import SwiftUI

struct NotificationSetting: View {
    @AppStorage(Keys.themeId.rawValue)
    var themeId: Int = 0
    
    @AppStorage(Keys.notificationTime.rawValue)
    var notificationTime: Int = 0

    @State
    private var progress: CGFloat
    
    private var defaultWidth: CGFloat = 25
    
    private let sectment: Double
        
    private let hourStrings: [String] = stride(from: 2, to: 26, by: 2).map {"\($0)"}
    
    init() {
        sectment = 360 / Double(hourStrings.count)
        progress = CGFloat(Settings.notificationTime.value) / (24 * 60)
    }
    
    private func onDrag(value: DragGesture.Value) {
        let vector = CGVector(dx: value.location.x, dy: value.location.y)
        let radian = atan2(vector.dy - defaultWidth / 2, vector.dx - defaultWidth / 2)
        var angle = radian * 180 / .pi
        
        if angle < 0 {
            angle = 360 + angle
        }
        
        progress = angle / 360
    }
    
    var bigRect: some View {
        Color.gray.frame(width: 3, height: 10)
    }
    
    var smallRect: some View {
        Color.gray.frame(width: 2, height: 5)
    }
    
    func buildClock(offset: CGFloat) -> some View {
        let angle = Double(progress * 360)

        return ZStack {
            ForEach(hourStrings.indices, id: \.self) { index in
                Text(hourStrings[index])
                    .font(.system(size: 10))
                    .foregroundColor(Theme.get(id: themeId).sleepColor.textColor)
                    .rotationEffect(.degrees(0 - Double(index + 1) * sectment))
                    .offset(y: offset + 20)
                    .rotationEffect(.degrees(Double(index + 1) * sectment))
            }
            ForEach((0...47), id: \.self) { index in
                Group {
                    if index % 2 == 0 {
                        bigRect
                    } else {
                        smallRect
                    }
                }
                .offset(y: offset)
                .rotationEffect(.degrees(Double(index) * 7.5))
            }
            
            Theme.get(id: themeId).sleepColor.textColor
                .frame(width: 2, height: abs(offset) - 30, alignment: .center)
                .rotationEffect(.degrees(angle), anchor: .bottom)
                .offset(y: -(abs(offset) - 30) / 2)
        }
    }

    private func buildProgressView(width: CGFloat) -> some View {
        let angle = Double(progress * 360)
        
        return ZStack {
            Circle()
                .stroke(Theme.get(id: themeId).sleepColor.bigCircleColor,
                        style: StrokeStyle(lineWidth: defaultWidth,
                                           lineCap: .round,
                                           lineJoin: .round))
                .frame(width: width, height: width, alignment: .center)
            
            Circle()
                .fill(Theme.get(id: themeId).sleepColor.smallCircleColor)
                .scaleEffect(0.8)
                .frame(width: defaultWidth, height: defaultWidth, alignment: .center)
                .offset(x: width / 2)
                .rotationEffect(.init(degrees: angle))
                .gesture(DragGesture().onChanged(onDrag(value:)))
                .rotationEffect(.init(degrees: -90))
            
            Circle()
                .fill(Theme.get(id: themeId).sleepColor.smallCircleColor)
                .frame(width: 10, height: 10, alignment: .center)
        }
    }
    
    var body: some View {
        ZStack {
            Theme.get(id: themeId)
                .commonColor.viewBackground
                .ignoresSafeArea()
            GeometryReader { proxy in
                let offset = 0 - (proxy.size.width - defaultWidth * 2) / 2

                ZStack {
                    buildProgressView(width: proxy.size.width)
                    buildClock(offset: offset)
                }
            }
            .padding(.all, 50)
        }
    }
}
