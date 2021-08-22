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
    
    @State
    private var precent: CGFloat = 0
    
    init(month: Int, year: Int, datasource: [ChartData]) {
        let date = Date(year: year, month: month)
        
        self.numberOfSecment = date.getDateMonth().count
        self.datasource = datasource
        
        let emotions = datasource.map { $0.emotion.doubleValue }
        
        self.maxY = emotions.max() ?? 0
        self.minY = emotions.min() ?? 0
        
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
                    chartPoint
                }
            }
            .frame(height: 200, alignment: .center)
            HStack {
                SizedBox(width: 20)
                chartXAxis
            }
        }
        .onAppear(perform: {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                withAnimation(Animation.linear(duration: 2.0)) {
                    precent = 1
                }
            }
        })
        .onDisappear(perform: {
            precent = 0
        })
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
            ZStack {
                ForEach(datasource.indices, id: \.self) { index in
                    let xPos = reader.size.width /
                    CGFloat(numberOfSecment) *
                    CGFloat(datasource[index].index + 1)
                    
                    let yAxis = maxY - minY
                    
                    let resource = datasource[index].emotion.doubleValue
                    
                    let yPos = CGFloat((resource - minY) / yAxis) *
                    reader.size.height
                    
                    ZStack {
                        Circle()
                            .fill(Color.green)
                            .frame(width: 10)
                        Circle()
                            .fill(Color.white)
                            .frame(width: 5)
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
            .stroke(Color.green,
                    style: StrokeStyle(lineWidth: 2,
                                       lineCap: .round,
                                       lineJoin: .round))
        }
    }
}

//struct LineChartView_Previews: PreviewProvider {
//    static let mock = [ChartData(emotion: .neutral,
//                                 index: 0),
//                       ChartData(emotion: .happy,
//                                 index: 5),
//                       ChartData(emotion: .sad,
//                                 index: 9),
//                       ChartData(emotion: .blissful,
//                                 index: 13),
//                       ChartData(emotion: .sad,
//                                 index: 15),
//                       ChartData(emotion: .terrible,
//                                 index: 20),
//                       ChartData(emotion: .neutral,
//                                 index: 28)]
//
//    static var previews: some View {
//        LineChartView(month: 8, year: 2021, datasource: mock)
//    }
//}
