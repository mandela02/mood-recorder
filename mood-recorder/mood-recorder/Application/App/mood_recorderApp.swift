//
//  mood_recorderApp.swift
//  mood-recorder
//
//  Created by LanNTH on 01/08/2021.
//

import SwiftUI

@main
struct mood_recorderApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            InputView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
