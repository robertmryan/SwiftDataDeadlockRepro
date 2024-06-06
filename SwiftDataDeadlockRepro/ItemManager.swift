//
//  ItemManager.swift
//  SwiftDataDeadlockRepro
//
//  Created by PHILIP SHEN on 6/6/24.
//

import Foundation

actor ItemManager {
    static let shared = ItemManager()

    func fetchItems() async throws {
        let numItems = 20_000
        let items = (0 ..< numItems).map { Item(String($0)) }
        try await MyModelActor.shared.upsert(items, deleteOthers: true)
    }
}
