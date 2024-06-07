//
//  Item.swift
//  SwiftDataDeadlockRepro
//
//  Created by PHILIP SHEN on 6/6/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var itemId: String
    var str: String

    init(_ itemId: String) {
        self.itemId = itemId

        let memoryFootprintKB = 5
        str = String(repeating: "0", count: 1024 * memoryFootprintKB)
    }
}
