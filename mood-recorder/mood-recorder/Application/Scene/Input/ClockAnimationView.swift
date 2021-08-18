//
//  ClockAnimationView.swift
//  ClockAnimationView
//
//  Created by LanNTH on 17/08/2021.
//

import SwiftUI

struct ClockAnimationView: View {
    @State var bedTimeProgress: CGFloat = 0
    @State var bedTimeAngle: Double = 0
    
    @State var wakeTimeProgress: CGFloat = 0
    @State var wakeTimeAngle: Double = 0
    
    @State var bedTime: String = "00:00"
    @State var wakeTime: String = "00:00"
    
    private var defaultWidth: CGFloat = 40
    
    let hourStrings: [String]
    
    let sectment: Double
    
    init() {
        hourStrings = stride(from: 2, to: 26, by: 2).map {"\($0)"}
        sectment = 360 / Double(hourStrings.count)
    }
    
    var body: some View {
        ZStack {
            Theme.current.tableViewColor.background
                .ignoresSafeArea()
            VStack {
                makeTimeView()
                    .padding()
                GeometryReader { proxy in
                    let offset = 0 - (proxy.size.width / 2 - defaultWidth)
                    
                    ZStack {
                        makeProgressView(width: proxy.size.width)
                        ForEach(hourStrings.indices, id: \.self) { index in
                            Text(hourStrings[index])
                                .font(.system(size: 10))
                                .foregroundColor(Theme.current.commonColor.textColor)
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
                    }
                }
                .padding(.all, 50)
            }
        }
    }
}

extension ClockAnimationView {
    var bigRect: some View {
        Color.gray.frame(width: 3, height: 10)
    }
    
    var smallRect: some View {
        Color.gray.frame(width: 2, height: 5)
    }
    
    func makeTimeView() -> some View {
        HStack {
            VStack {
                Text("Bedtime")
                    .font(.system(size: 15))
                    .lineLimit(1)
                Text(bedTime)
                    .bold()
                    .font(.system(size: 20))
            }
            Spacer()
            VStack {
                Text("Wake up time")
                    .font(.system(size: 15))
                    .lineLimit(1)
                Text(wakeTime)
                    .bold()
                    .font(.system(size: 20))
            }
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
        
        let progress = angle / 360
        self.bedTimeProgress = progress
        self.bedTimeAngle = Double(angle)
        
        let minute = Int(progress * 24 * 60)
        bedTime = minute.generateHourMinuteString()
    }
    
    private func onDragEndCircle(value: DragGesture.Value) {
        let vector = CGVector(dx: value.location.x, dy: value.location.y)
        let radian = atan2(vector.dy - defaultWidth / 2, vector.dx - defaultWidth / 2)
        var angle = radian * 180 / .pi
        
        if angle < 0 {
            angle = 360 + angle
        }
        let progress = angle / 360
        self.wakeTimeProgress = progress
        self.wakeTimeAngle = Double(angle)
        
        let minute = Int(progress * 24 * 60)
        wakeTime = minute.generateHourMinuteString()
    }
    
    @ViewBuilder
    func builtProgressCircle() -> some View {
        if bedTimeProgress > wakeTimeProgress {
            ZStack {
                Circle()
                    .trim(from: bedTimeProgress,
                          to: 1)
                    .stroke(Theme.current.buttonColor.backgroundColor,
                            style: StrokeStyle(lineWidth: defaultWidth,
                                               lineCap: .round,
                                               lineJoin: .round))
                Circle()
                    .trim(from: 0,
                          to: wakeTimeProgress)
                    .stroke(Theme.current.buttonColor.backgroundColor,
                            style: StrokeStyle(lineWidth: defaultWidth,
                                               lineCap: .round,
                                               lineJoin: .round))
            }
        } else {
            Circle()
                .trim(from: bedTimeProgress,
                      to: wakeTimeProgress)
                .stroke(Theme.current.buttonColor.backgroundColor,
                        style: StrokeStyle(lineWidth: defaultWidth,
                                           lineCap: .round,
                                           lineJoin: .round))
        }
    }
    
    private func makeProgressView(width: CGFloat) -> some View {
        ZStack {
            Circle()
                .stroke(Theme.current.buttonColor.disableColor,
                        style: StrokeStyle(lineWidth: defaultWidth,
                                           lineCap: .round,
                                           lineJoin: .round))
                .frame(width: width, height: width, alignment: .center)
            
            builtProgressCircle()
                .frame(width: width, height: width, alignment: .center)
                .rotationEffect(.init(degrees: -90))
            
            Circle()
                .fill(Color.white)
                .scaleEffect(0.8)
                .frame(width: defaultWidth, height: defaultWidth, alignment: .center)
                .offset(x: width / 2)
                .rotationEffect(.init(degrees: bedTimeAngle))
                .gesture(DragGesture().onChanged(onDragStartCircle(value:)))
                .rotationEffect(.init(degrees: -90))
            
            Circle()
                .fill(Color.black)
                .scaleEffect(0.8)
                .frame(width: defaultWidth, height: defaultWidth, alignment: .center)
                .offset(x: width / 2)
                .rotationEffect(.init(degrees: wakeTimeAngle))
                .gesture(DragGesture().onChanged(onDragEndCircle(value:)))
                .rotationEffect(.init(degrees: -90))
        }
    }
}
