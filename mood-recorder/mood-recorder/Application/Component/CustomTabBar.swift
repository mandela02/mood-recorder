//
//  CustomTabBar.swift
//  mood-recorder
//
//  Created by LanNTH on 01/08/2021.
//

import SwiftUI

struct TabBarItem {
    let image: Image
    let title: String
    let index: Int
}

struct CustomTabBar: View {
    @Binding var selectedIndex: Int
    
    let backgroundColor: Color
    let selectedItemColor: Color
    let unselectedItemColor: Color
    let onBigButtonTapped: () -> ()
    
    func configuredTabBarItem(item: TabBarItem) -> some View {
        Button(action: {
            withAnimation(.spring()) {
                selectedIndex = item.index
            }
        }, label: {
            configuredTabBarContent(item: item)
        })
    }
    
    func configuredTabBarContent(item: TabBarItem) -> some View {
        if selectedIndex == item.index {
            return AnyView(VStack(alignment: .center,
                                  spacing: 0, content: {
                                    configuredImage(image: item.image)
                                        .foregroundColor(selectedItemColor)
                                    Text(item.title)
                                        .font(.system(size: 10))
                                        .foregroundColor(selectedItemColor)
                                  }))
        } else {
            return AnyView(configuredImage(image: item.image)
                            .foregroundColor(unselectedItemColor))
        }
    }
    
    func configuredImage(image: Image) -> some View {
        return image
            .resizable()
            .renderingMode(.template)
            .aspectRatio(contentMode: .fit)
            .frame(width: 25, height: 25, alignment: .center)
            .padding(10)
            .frame(minWidth: 0, maxWidth: .infinity)
    }
    
    var tabBarContent: some View {
        return HStack(alignment: .center,
                      spacing: 0,
                      content: {
            configuredTabBarItem(item: TabBarItem(image: Image.calendar, title: "Calendar", index: 0))
            configuredTabBarItem(item: TabBarItem(image: Image.timeline, title: "Timeline", index: 1))
            Spacer()
                .frame(width: 50)
            configuredTabBarItem(item: TabBarItem(image: Image.report, title: "Report", index: 2))
            configuredTabBarItem(item: TabBarItem(image: Image.setting, title: "Setting", index: 3))
        })
        .padding(.all, 10)
        .frame(
            minWidth: 0,
            maxWidth: .infinity
        )
        .background(backgroundColor.clipShape(CurveBackgroundShape()).cornerRadius(20))
        .padding(.all, 10)
        
    }
    
    var body: some View {
        ZStack(content: {
            tabBarContent
            Button(action: onBigButtonTapped, label: {
                AppImage.neutral.image
                    .resizable()
                    .renderingMode(.original)
                    .aspectRatio(contentMode: .fit)
                    .padding(10)
                    .frame(width: 70, height: 70, alignment: .center)
                    .background(backgroundColor)
                    .clipShape(Circle())
            })
            .buttonStyle(BigButtonStyle())
            .offset(y: -45)
        })
        
    }
}

private struct BigButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.8 : 1.0)
    }
}


private struct CurveBackgroundShape: Shape {
    func path(in rect: CGRect) -> Path {
        let centerX = rect.midX
        
        return Path { path in
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            
            path.move(to: CGPoint(x: centerX - 60, y: 0))
            
            let to1 = CGPoint(x: centerX, y: 35)
            let control1 = CGPoint(x: centerX - 35, y: 0)
            let control2 = CGPoint(x: centerX - 35 , y: 35)
            
            let to2 = CGPoint(x: centerX + 60, y: 0)
            let control3 = CGPoint(x: centerX + 35, y: 35)
            let control4 = CGPoint(x: centerX + 35 , y: 0)
            
            path.addCurve(to: to1, control1: control1, control2: control2)
            
            path.addCurve(to: to2, control1: control3, control2: control4)
            
        }
    }
}

private extension Image {
    static var calendar: Image {
        return Image(systemName: "calendar")
    }
    
    static var timeline: Image {
        return Image(systemName: "lineweight")
    }
    
    static var report: Image {
        return Image(systemName: "chart.bar.fill")
    }
    
    static var setting: Image {
        return Image(systemName: "gearshape.fill")
    }
}


struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabBar(selectedIndex: .constant(0),
                     backgroundColor: .green,
                     selectedItemColor: .white,
                     unselectedItemColor: .black,
                     onBigButtonTapped: {})
    }
}
