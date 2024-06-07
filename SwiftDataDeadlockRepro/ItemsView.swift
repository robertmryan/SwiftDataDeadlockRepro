//
//  ItemsView.swift
//  SwiftDataDeadlockRepro
//
//  Created by PHILIP SHEN on 6/6/24.
//

import SwiftData
import SwiftUI

struct ItemsView: View {
    @Query(
        {
            var descriptor = FetchDescriptor<Item>(
                sortBy: [.init(\.itemId)]
            )
            descriptor.fetchLimit = 100
            return descriptor
        }(),
        animation: .default
    )
    private var items: [Item]

    var body: some View {
        ScrollView {
            Button(action: {
                Task { try! await ItemManager.shared.fetchItems() }
            }) {
                Text("Re-fetch items")
                    .padding()
                    .background(Color.blue)
                    .foregroundStyle(.white)
                    .clipShape(Capsule())
            }

            LazyVStack {
                ForEach(items) {
                    ItemView(item: $0)
                }
            }
        }
        .onAppear {
            Task { try! await ItemManager.shared.fetchItems() }
        }
    }
}
