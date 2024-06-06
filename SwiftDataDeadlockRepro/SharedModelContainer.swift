//
//  SharedModelContainer.swift
//  SwiftDataDeadlockRepro
//
//  Created by PHILIP SHEN on 6/6/24.
//

import Foundation
import SwiftData

enum SharedModelContainer {
    static let instance: ModelContainer = {
        let modelConfiguration = ModelConfiguration(isStoredInMemoryOnly: true)
        do {
            return try ModelContainer(
                for: Item.self,
                configurations: modelConfiguration
            )
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
}
