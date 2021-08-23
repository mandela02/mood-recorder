//
//  LineChartView.swift
//  LineChartView
//
//  Created by TriBQ on 8/22/21.
//

import SwiftUI

struct LineChartView: View {
    private let numberOfSecment: Int
    private let datasource: [ChartData]
    
    private let maxY: Double
    private let minY: Double
    
    private let maxXAxisValue: Date
    private let minXAxisValue: Date
    private let middleXAxisValue: Date
    
    private var precent: CGFloat
    
    @AppStorage(Keys.themeId.rawValue)
    var themeId: Int = 0
    
    init(month: Int, year: Int, datasource: [ChartData],
         precent: CGFloat) {
        self.precent = precent
        
        let date = Date(year: year, month: month)
        
        self.numberOfSecment = date.getDateMonth().count
        self.datasource = datasource
                
        self.maxY = CoreEmotion.allCases.map { $0.doubleValue }.max() ?? 0
        self.minY = CoreEmotion.allCases.map { $0.doubleValue }.min() ?? 0
        
        maxXAxisValue = date.endOfMonth
        minXAxisValue = date.startOfMonth
        middleXAxisValue = date.middleOfMonth
    }
    
    var body: some View {
        VStack {
            HStack(spacing: 5) {
                chartYAxis
                    .frame(width: 20)
                ZStack {
                    lineChart
                        .background(chartBackground)
                    if precent == 1 {
                        chartPoint
                            .animation(.easeInOut, value: precent == 1)
                    }
                    if datasource.isEmpty {
                        Text("No diaries recorded")
                            .font(.system(size: 20))
                    }
                }
                .frame(height: 200, alignment: .center)
            }
            .frame(height: 220, alignment: .center)
            HStack {
                SizedBox(width: 20)
                chartXAxis
            }
        }
        .foregroundColor(Theme.get(id: themeId).commonColor.textColor)
    }
}

private extension LineChartView {
    private var chartXAxis: some View {
        HStack {
            Text(minXAxisValue.dayMonthString)
                .font(.system(size: 10))
            Spacer()
            Text(middleXAxisValue.dayMonthString)
                .font(.system(size: 10))
            Spacer()
            Text(maxXAxisValue.dayMonthString)
                .font(.system(size: 10))
        }
    }

    private var chartYAxis: some View {
        VStack(alignment: .leading) {
            ForEach(CoreEmotion.allCases.indices, id: \.self) { index in
                let emotion = CoreEmotion.allCases[index]
                
                if index == CoreEmotion.allCases.count - 1 {
                    emotion.image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20, alignment: .center)
                } else {
                    emotion.image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20, alignment: .center)
                    Spacer()
                }
            }
        }
    }
    
    private var chartBackground: some View {
        VStack {
            ForEach(CoreEmotion.allCases.indices, id: \.self) { index in
                if index == CoreEmotion.allCases.count - 1 {
                    Divider()
                } else {
                    Divider()
                    Spacer()
                }
            }
        }
    }
    
    private var chartPoint: some View {
        GeometryReader { reader in
            let segmentSize = reader.size.width / CGFloat(numberOfSecment)
            
            ZStack {
                ForEach(datasource.indices, id: \.self) { index in
                    let xPos = segmentSize *
                    CGFloat(datasource[index].index + 1)
                    
                    let yAxis = maxY - minY
                    
                    let resource = datasource[index].emotion.doubleValue
                    
                    let yPos = CGFloat((resource - minY) / yAxis) * reader.size.height
                    
                    ZStack {
                        Circle()
                            .fill(Theme.get(id: themeId).buttonColor.backgroundColor)
                            .frame(width: segmentSize / 1.5)
                        Circle()
                            .fill(Color.white)
                            .frame(width: segmentSize / 3)
                    }
                    .frame(width: 10)
                    .position(x: xPos, y: yPos)
                }
            }
        }
    }
    
    private var lineChart: some View {
        GeometryReader { reader in
            Path { path in
                for (index, data) in datasource.enumerated() {
                    let xPos = reader.size.width /
                    CGFloat(numberOfSecment) *
                    CGFloat(data.index + 1)
                    
                    let yAxis = maxY - minY
                    
                    let resource = data.emotion.doubleValue
                    
                    let yPos = CGFloat((resource - minY) / yAxis) *
                    reader.size.height
                                        
                    if index == 0 {
                        path.move(to: CGPoint(x: xPos, y: yPos))
                    }
                    
                    path.addLine(to: CGPoint(x: xPos, y: yPos))
                }
            }
            .trim(from: 0, to: precent)
            .stroke(Theme.get(id: themeId).buttonColor.backgroundColor,
                    style: StrokeStyle(lineWidth: 2,
                                       lineCap: .round,
                                       lineJoin: .round))
        }
    }
}
