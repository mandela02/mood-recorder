//
//  ClockAnimationView.swift
//  ClockAnimationView
//
//  Created by LanNTH on 17/08/2021.
//

import SwiftUI

struct ClockAnimationView: View {
    typealias Function = () -> ()
    typealias CallbackFunction = (Int, Int) -> ()

    @State private var bedTimeProgress: CGFloat = 0.75
    @State private var bedTimeAngle: Double = 0.75 * 360
    
    @State private var wakeTimeProgress: CGFloat = 0.25
    @State private var wakeTimeAngle: Double = 0.25 * 360
    
    @State private var bedTime: String = "18:00"
    @State private var wakeTime: String = "06:00"
    
    @State private var isRinging = false
    @State private var showZleft = false
    @State private var showZmiddle = false
    @State private var showZright = false
    
    @State private var bedTimeInMinute = 1080
    @State private var wakeUpTimeInMinute = 360

    private var defaultWidth: CGFloat = 50
    private let sectment: Double
    private let images = [AppImage.newMoon, AppImage.cloudyDay, AppImage.sunny, AppImage.cloudyNight]
    private let hourStrings: [String] = stride(from: 2, to: 26, by: 2).map {"\($0)"}

    let onCancel: Function
    let onCallback: CallbackFunction
    
    init(onCancel: @escaping Function,
         onCallback: @escaping CallbackFunction) {
        sectment = 360 / Double(hourStrings.count)

        self.onCancel = onCancel
        self.onCallback = onCallback
    }
    
    // MARK: - BODY
    var body: some View {
        ZStack {
            Theme.current.sleepColor.backgroundColor
                .ignoresSafeArea()
            VStack {
                buildHourOfSleep()
                    .padding(.top, 50)
                GeometryReader { proxy in
                    let offset = 0 - (proxy.size.width - (defaultWidth - 10) * 2) / 2
                    let imageWidth = (proxy.size.width / 2 - (defaultWidth - 10) * 2) / 2

                    ZStack {
                        buildProgressView(width: proxy.size.width)
                        buildClock(offset: offset)
                        buildImages(offset: offset, width: imageWidth)
                    }
                }
                .padding(.all, 50)
                .aspectRatio(1, contentMode: .fit)
                buildTimeView()
                    .padding()
                Spacer()
                VStack {
                    createButton(title: "OK", callback: {
                        onCallback(bedTimeInMinute, wakeUpTimeInMinute)
                    })

                    createButton(title: "Cancel", callback: onCancel)
                }
                .padding()
            }
        }
        .cornerRadius(20)
    }
}

// MARK: - CLOCK VIEW
extension ClockAnimationView {
    var bigRect: some View {
        Color.gray.frame(width: 3, height: 10)
    }
    
    var smallRect: some View {
        Color.gray.frame(width: 2, height: 5)
    }
    

    func buildClock(offset: CGFloat) -> some View {
        ZStack {
            ForEach(hourStrings.indices, id: \.self) { index in
                Text(hourStrings[index])
                    .font(.system(size: 10))
                    .foregroundColor(Theme.current.sleepColor.textColor)
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
    
    func buildImages(offset: CGFloat, width: CGFloat) -> some View {
        ForEach(images.indices, id: \.self) { index in
            Image(images[index].value)
                .resizable()
                .aspectRatio(1, contentMode: .fit)
                .frame(width: width)
                .rotationEffect(.degrees(0 - Double(index) * 90))
            .offset(y: offset + 50)
            .rotationEffect(.degrees(Double(index) * 90))
        }
    }
}

// MARK: - TIME VIEW
extension ClockAnimationView {
    func buildTimeView() -> some View {
        HStack {
            VStack(spacing: 15) {
                HStack {
                    buildBedView()
                    Text("Sleep at")
                        .font(.system(size: 15))
                        .lineLimit(1)
                        .foregroundColor(Theme.current.sleepColor.textColor)
                }
                Text(bedTime)
                    .bold()
                    .font(.system(size: 25))
                    .foregroundColor(Theme.current.sleepColor.textColor)
            }
            .frame(minWidth: 0, maxWidth: .infinity)
            Theme.current.sleepColor.buttonColor
                .frame(width: 2, height: 45, alignment: .center)
            VStack(spacing: 15) {
                HStack {
                    buildBell()
                    Text("Wake up at")
                        .font(.system(size: 15))
                        .lineLimit(1)
                        .foregroundColor(Theme.current.sleepColor.textColor)
                }
                Text(wakeTime)
                    .bold()
                    .font(.system(size: 25))
                    .foregroundColor(Theme.current.sleepColor.textColor)
            }
            .frame(minWidth: 0, maxWidth: .infinity)
        }
    }
    
    func buildHourOfSleep() -> some View {
        VStack {
            Text("Hours of sleep")
                .foregroundColor(Theme.current.sleepColor.textColor)
                .font(.system(size: 20))
            Text(calculateHourOfSleep())
                .foregroundColor(Theme.current.sleepColor.textColor)
                .font(.system(size: 30))
        }
    }
    
    func calculateHourOfSleep() -> String {
        var hourOfSleep = 0

        if bedTimeProgress > wakeTimeProgress {
            hourOfSleep = Int((1 - bedTimeProgress + wakeTimeProgress)  * 24 * 60)
        } else {
            hourOfSleep = Int((wakeTimeProgress - bedTimeProgress)  * 24 * 60)
        }
        return hourOfSleep.generateHourMinuteString()
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
        bedTimeInMinute = minute
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
        wakeUpTimeInMinute = minute
        wakeTime = minute.generateHourMinuteString()
    }
    
    @ViewBuilder
    func builtProgressCircle() -> some View {
        if bedTimeProgress > wakeTimeProgress {
            ZStack {
                Circle()
                    .trim(from: bedTimeProgress,
                          to: 1)
                    .stroke(Theme.current.sleepColor.smallCircleColor,
                            style: StrokeStyle(lineWidth: defaultWidth - 10,
                                               lineCap: .round,
                                               lineJoin: .round))
                Circle()
                    .trim(from: 0,
                          to: wakeTimeProgress)
                    .stroke(Theme.current.sleepColor.smallCircleColor,
                            style: StrokeStyle(lineWidth: defaultWidth - 10,
                                               lineCap: .round,
                                               lineJoin: .round))
            }
        } else {
            Circle()
                .trim(from: bedTimeProgress,
                      to: wakeTimeProgress)
                .stroke(Theme.current.sleepColor.smallCircleColor,
                        style: StrokeStyle(lineWidth: defaultWidth - 10,
                                           lineCap: .round,
                                           lineJoin: .round))
        }
    }
    
    private func buildProgressView(width: CGFloat) -> some View {
        ZStack {
            Circle()
                .stroke(Theme.current.sleepColor.bigCircleColor,
                        style: StrokeStyle(lineWidth: defaultWidth,
                                           lineCap: .round,
                                           lineJoin: .round))
                .frame(width: width, height: width, alignment: .center)
            
            builtProgressCircle()
                .frame(width: width, height: width, alignment: .center)
                .rotationEffect(.init(degrees: -90))
            
            Image(systemName: "zzz")
                .resizable()
                .padding(.all, 10)
                .background(Theme.current.sleepColor.buttonBackground)
                .clipShape(Circle())
                .foregroundColor(Theme.current.sleepColor.buttonColor)
                .scaleEffect(0.6)
                .rotationEffect(.degrees(0 - bedTimeAngle + 90))
                .frame(width: defaultWidth, height: defaultWidth, alignment: .center)
                .offset(x: width / 2)
                .rotationEffect(.init(degrees: bedTimeAngle))
                .gesture(DragGesture().onChanged(onDragStartCircle(value:)))
                .rotationEffect(.init(degrees: -90))

            
            Image(systemName: "bell.fill")
                .resizable()
                .padding(.all, 10)
                .background(Theme.current.sleepColor.buttonBackground)
                .clipShape(Circle())
                .foregroundColor(Theme.current.sleepColor.buttonColor)
                .scaleEffect(0.6)
                .rotationEffect(.degrees(0 - wakeTimeAngle + 90))
                .frame(width: defaultWidth, height: defaultWidth, alignment: .center)
                .offset(x: width / 2)
                .rotationEffect(.init(degrees: wakeTimeAngle))
                .gesture(DragGesture().onChanged(onDragEndCircle(value:)))
                .rotationEffect(.init(degrees: -90))
        }
    }
}

extension ClockAnimationView {
    private func buildBell() -> some View {
        Image(systemName: "bell.fill")
            .font(.title)
            .foregroundColor(Theme.current.sleepColor.buttonColor)
            .rotationEffect(.degrees(isRinging ? 0 : 90), anchor: .top)
            .animation(Animation
                        .interpolatingSpring(stiffness: 170,
                                                     damping: 5)
                        .repeatForever(autoreverses: false),
                       value: isRinging)
            .onAppear(perform: {
                isRinging.toggle()
            })
    }
    
    func buildBedView() -> some View {
        ZStack {
            Image(systemName: "bed.double.fill")
                .font(.title)
                .foregroundColor(Theme.current.sleepColor.buttonColor)
            
            Text("Z")
                .foregroundColor(Theme.current.sleepColor.buttonColor)
                .font(.headline)
                .scaleEffect(showZmiddle ? 1 : 0.5)
                .rotationEffect(.degrees(showZmiddle ? -30 : 30), anchor: .bottomTrailing)
                .opacity(showZmiddle ? 1 : 0)
                .animation(Animation.easeInOut(duration: 1.5).delay(2).repeatForever(autoreverses: false), value: showZmiddle)
                .offset(x: -10, y: showZmiddle ? -60 : -3)
                .onAppear(perform: {
                    showZmiddle.toggle()
                })
            
            Text("Z")
                .foregroundColor(Theme.current.sleepColor.buttonColor)
                .scaleEffect(showZleft ? 1 : 0.5)
                .rotationEffect(.degrees(showZleft ? 30 : 60), anchor: .bottomTrailing)
                .opacity(showZleft ? 1 : 0)
                .animation(Animation.easeInOut(duration: 1.5).delay(2).repeatForever(autoreverses: false), value: showZleft)
                .offset(x: showZright ? -40 : -8, y: showZleft ? -50 : 0)
                .onAppear(perform: {
                    showZleft.toggle()
                })
            
            Text("Z")
                .font(.caption)
                .foregroundColor(Theme.current.sleepColor.buttonColor)
                .scaleEffect(0.8)
                .rotationEffect(.degrees(showZright ? -45 : 45), anchor: .bottomTrailing)
                .opacity(showZright ? 1 : 0)
                .animation(Animation.easeInOut(duration: 1.5).delay(2).repeatForever(autoreverses: false), value: showZright)
                .offset(x: showZright ? -40 : -8, y: showZleft ? -50 : 0)
                .onAppear(perform: {
                    showZright.toggle()
                })
        }
    }
}

extension ClockAnimationView {
    private func createButton(title: String,
                      callback: @escaping Function) -> some View {
        Button(action: callback) {
            Text(title)
                .font(.system(size: 12))
                .foregroundColor(Theme.current.buttonColor.textColor)
                .frame(maxWidth: .infinity)
                .padding()
        }
        .background(Theme.current.buttonColor.backgroundColor)
        .cornerRadius(20)
    }
}
