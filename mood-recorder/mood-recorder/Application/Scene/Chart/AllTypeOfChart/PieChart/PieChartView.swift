//
//  PieChartView.swift
//  PieChartView
//
//  Created by TriBQ on 8/23/21.
//

import SwiftUI

struct PieChartView: View {
    var datasource: [PercentChartData]
    
    @State
    private var currentValue: PercentChartData?
    
    @State
    private var touchLocation: CGPoint = .init(x: -1, y: -1)
    
    @AppStorage(Keys.themeId.rawValue)
    var themeId: Int = 0
    
    init(datasource: [ChartData]) {
        let dict = Dictionary(grouping: datasource, by: { $0.emotion })
        let datas: [PercentChartData] = dict.map { (key, value) in
            return PercentChartData(emotion: key,
                                    percent: CGFloat(value.count) / CGFloat(datasource.count))
        }
            .sorted(by: {$0.emotion.rawValue < $1.emotion.rawValue})
        
        self.datasource = datas
    }
    
    var body: some View {
        VStack {
            GeometryReader { proxy in
                ZStack {
                    buildPieChart(proxy: proxy)
                        .gesture(DragGesture(minimumDistance: 0)
                                    .onChanged({ position in
                            let pieSize = proxy.frame(in: .local)
                            touchLocation = position.location
                            updateCurrentValue(inPie: pieSize)
                        }).onEnded({ _ in
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                withAnimation(Animation.easeOut) {
                                    resetValues()
                                }
                            }
                        }))
                    Theme.get(id: themeId)
                        .tableViewColor
                        .cellBackground
                        .clipShape(Circle())
                        .overlay(Circle()
                                    .stroke(Color.white,
                                            lineWidth: 2))
                        .frame(width: proxy.size.width / 3, height: proxy.size.width / 3)
                    
                    buildTextView()
                        .frame(width: proxy.size.width / 3, height: proxy.size.width / 3)
                }
            }
            .aspectRatio(contentMode: .fit)
            .frame(width: 300, height: 300, alignment: .center)
            SizedBox(height: 20)
            GeometryReader { proxy in
                buildLabelGrid(maxSize: proxy.size.width)
            }
            Spacer()
        }
    }
}

extension PieChartView {
    func resetValues() {
        currentValue = nil
        touchLocation = .init(x: -1, y: -1)
    }
    
    func updateCurrentValue(inPie pieSize: CGRect) {
        guard let angle = angleAtTouchLocation(inPie: pieSize,
                                               touchLocation: touchLocation)
        else { return }
        guard let currentIndex = pieSlices
                .firstIndex(where: { $0.startDegree < angle && $0.endDegree > angle })
        else { return }
        
        currentValue = datasource[currentIndex]
    }
    
    func angleAtTouchLocation(inPie pieSize: CGRect, touchLocation: CGPoint) -> Double? {
        let dx = touchLocation.x - pieSize.midX
        let dy = touchLocation.y - pieSize.midY
        
        let distanceToCenter = (dx * dx + dy * dy).squareRoot()
        let radius = pieSize.width/2
        guard distanceToCenter <= radius else {
            return nil
        }
        let angleAtTouchLocation = Double(atan2(dy, dx) * (180 / .pi))
        if angleAtTouchLocation < 0 {
            return (180 + angleAtTouchLocation) + 180
        } else {
            return angleAtTouchLocation
        }
    }
    
    func sliceIsTouched(index: Int, inPie pieSize: CGRect) -> Bool {
        guard let angle = angleAtTouchLocation(inPie: pieSize,
                                               touchLocation: touchLocation)
        else { return false }
        return pieSlices.firstIndex(where: { $0.startDegree < angle && $0.endDegree > angle }) == index
    }
}

extension PieChartView {
    var pieSlices: [PieSliceModel] {
        var slices = [PieSliceModel]()
        datasource.enumerated().forEach {(index, data) in
            let value = ChartHelper.normalizedValue(index: index, data: self.datasource)
            if slices.isEmpty {
                slices.append((.init(startDegree: 0, endDegree: value * 360)))
            } else {
                slices.append(.init(startDegree: slices.last!.endDegree,
                                    endDegree: (value * 360 + slices.last!.endDegree)))
            }
        }
        
        return slices
    }
    
    func buildPieChart(proxy: GeometryProxy) -> some View {
        ZStack {
            ForEach(datasource.indices, id: \.self) { index in
                let isTouch = sliceIsTouched(index: index,
                                             inPie: proxy.frame(in: .local))
                
                PieChartSliceView(center: CGPoint(x: proxy.frame(in: .local).midX,
                                                  y: proxy.frame(in: .local).midY),
                                  radius: proxy.frame(in: .local).width/2,
                                  startDegree: pieSlices[index].startDegree,
                                  endDegree: pieSlices[index].endDegree,
                                  isTouched: isTouch,
                                  accentColor: datasource[index].emotion.color,
                                  separatorColor: Color.white)
                    .animation(.easeInOut, value: isTouch)
            }
        }
    }
}

extension PieChartView {
    func buildLabelGrid(maxSize: CGFloat) -> some View {
        LazyVGrid(columns: Array(repeating: GridItem(.fixed(maxSize / 3),
                                                     alignment: .top),
                                 count: 3),
                  content: {
            ForEach(CoreEmotion.allCases, id: \.rawValue) { emotion in
                HStack {
                    emotion.color
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                        .aspectRatio(contentMode: .fit)
                    SizedBox(width: 5)
                    emotion.image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                .padding(.all, 10)
                .frame(height: 50)
            }
        })
    }
    
    func buildTextView() -> some View {
        VStack {
            if let data = currentValue {
                VStack {
                    data.emotion.image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    
                    Text(ChartHelper.precent(precent: data.percent))
                        .font(.system(size: 15))
                        .foregroundColor(Theme.get(id: themeId).commonColor.textColor)
                }
            }
        }
        .padding()
    }
}
