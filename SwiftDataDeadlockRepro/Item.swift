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
    var id: String
    var str: String

    init(_ id: String) {
        self.id = id

        let memoryFootprintKB = 5
        str = String(repeating: "0", count: 1024 * memoryFootprintKB)
    }
}
