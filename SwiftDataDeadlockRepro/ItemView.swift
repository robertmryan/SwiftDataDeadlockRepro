//
//  ItemView.swift
//  SwiftDataDeadlockRepro
//
//  Created by PHILIP SHEN on 6/6/24.
//

import SwiftUI

struct ItemView: View {
    let item: Item

    var body: some View {
        VStack {
            VStack {
                Text(String(item.id))
                    .padding()
                Text(item.str)
                    .font(.caption)
                    .lineLimit(1)
                Rectangle()
                    .fill(Color.red)
                    .frame(height: 1)
            }
        }
    }
}
