//
//  mood_recorderApp.swift
//  mood-recorder
//
//  Created by LanNTH on 01/08/2021.
//

import SwiftUI

@main
struct MoodRecorderApp: App {
    @Environment(\.scenePhase) var scenePhase

    var body: some Scene {
        WindowGroup {
            HomeView()
        }
    }
}
