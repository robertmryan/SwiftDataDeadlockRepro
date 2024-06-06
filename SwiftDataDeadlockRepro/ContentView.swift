//
//  ContentView.swift
//  SwiftDataDeadlockRepro
//
//  Created by PHILIP SHEN on 6/6/24.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]

    var body: some View {
        NavigationStack {
            NavigationLink("View Items") {
                ItemsView()
            }
            .padding(.bottom, 24)
        }
    }
}
