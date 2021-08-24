//
//  OptionStatisticalView.swift
//  OptionStatisticalView
//
//  Created by TriBQ on 8/23/21.
//

import SwiftUI

struct OptionStatisticalTableView: View {
    @AppStorage(Keys.themeId.rawValue)
    var themeId: Int = 0
    
    let datasource: [[OptionCountModel]]
    
    @State
    private var currentIndex: Int = 0
    
    init(datasource: [OptionCountModel]) {
        self.datasource = datasource.chunked(into: 5)
        currentIndex = 0
    }
    
    func buildOptionCell(options: [OptionCountModel]) -> some View {
        VStack {
            ForEach(options, id: \.option) { option in
                VStack {
                    HStack {
                        option.option.image.value.image
                            .resizable()
                            .aspectRatio(1, contentMode: .fit)
                            .frame(width: 50)
                        Text(option.option.title)
                            .font(.system(size: 12))
                        Spacer()
                        if option.count > 0 {
                            Image(systemName: "arrowtriangle.up.fill")
                                .foregroundColor(.blue)
                                .aspectRatio(1, contentMode: .fit)
                        } else if option.count == 0 {
                            Text("-")
                                .foregroundColor(Theme.get(id: themeId).commonColor.textColor)
                                .font(.system(size: 14))
                        } else {
                            Image(systemName: "arrowtriangle.down.fill")
                                .foregroundColor(.red)
                                .aspectRatio(1, contentMode: .fit)
                        }
                        
                        if option.count == 0 {
                            Text("-")
                                .foregroundColor(Theme.get(id: themeId).commonColor.textColor)
                                .font(.system(size: 14))
                        } else {
                            
                            Text("\(option.count < 0 ? 1 - option.count : option.count)")
                                .font(.system(size: 12))
                                .foregroundColor(option.count < 0 ? .red : .blue)
                        }
                    }
                    .padding(.horizontal, 5)
                    Divider()
                }
                .frame(height: 60)
            }
        }
    }
    
    @ViewBuilder
    func makePagingController() -> some View {
        if datasource.isEmpty {
            Text("No diaries recorded")
                .font(.system(size: 20))
            
        } else {
            TabView(selection: $currentIndex) {
                ForEach(datasource.indices, id: \.self) { index in
                    VStack {
                        buildOptionCell(options: datasource[index])
                        Spacer()
                    }
                    .padding(.all, 5)
                    .tag(index)
                }
            }
            .frame(height: 60 * 5 + 100)
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
        }
    }

    var body: some View {
        VStack {
            Text("Icon Ranking")
                .bold()
                .font(.system(size: 20))
            SizedBox(height: 5)
            Text("Frequently recoreded icons\nand the comparision with last month.")
                .font(.system(size: 15))
                .multilineTextAlignment(.center)
            ZStack {
                Theme.get(id: themeId).tableViewColor.cellBackground
                makePagingController()
                    .padding()
            }
            .foregroundColor(Theme.get(id: themeId).commonColor.textColor)
            .cornerRadius(20)
            .padding()
        }
    }
}
