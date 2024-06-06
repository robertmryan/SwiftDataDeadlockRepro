//
//  SwiftDataDeadlockReproApp.swift
//  SwiftDataDeadlockRepro
//
//  Created by PHILIP SHEN on 6/6/24.
//

import SwiftData
import SwiftUI

@main
struct SwiftDataDeadlockReproApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(SharedModelContainer.instance)
    }
}
