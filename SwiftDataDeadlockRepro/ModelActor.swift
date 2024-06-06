//
//  ModelActor.swift
//  SwiftDataDeadlockRepro
//
//  Created by PHILIP SHEN on 6/6/24.
//

import Foundation
import SwiftData

@ModelActor
actor MyModelActor {
    static let shared = MyModelActor(modelContainer: SharedModelContainer.instance)

    func fetch<T: PersistentModel>(_ descriptor: FetchDescriptor<T>) async throws -> [T] {
        try modelContext.fetch(descriptor)
    }

    func upsert<T: PersistentModel>(_ models: [T], deleteOthers: Bool) async throws {
        var modelsToInsertIDs = Set<T.ID>()
        var modelsToInsert = [T]()
        for model in models {
            modelsToInsertIDs.insert(model.id)
            modelsToInsert.append(model)
        }

        var modelsToDelete = [T]()
        if deleteOthers {
            let existingModels = try await fetch(FetchDescriptor<T>())
            for model in existingModels where !modelsToInsertIDs.contains(model.id) {
                modelsToDelete.append(model)
            }
        }

        try modelContext.transaction {
            for model in modelsToDelete {
                modelContext.delete(model)
            }

            for model in modelsToInsert {
                modelContext.insert(model)
            }
        }

        print("Upserted \(models.count) models")
    }
}
