//
//  AlzeApp.swift
//  Alze
//
//  Created by Chrismanto Natanail Manik on 06/06/22.
//

import SwiftUI
@main
struct AlzeApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            AddReminderView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
