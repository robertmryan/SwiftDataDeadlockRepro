# Overview

This demonstrates a deadlock which occurs with SwiftData when using custom-defined IDs for @Model objects.

# Project contents

* `ModelActor.swift` is where the @ModelActor class is defined, responsible for updating the ModelContainer from a background thread
* `Item.swift` is where the @Model is defined
* `ItemManager.swift` is where the Item models are inserted into the `ModelActor` context
* `ItemsView.swift` is where a list of items is rendered using a `@Query`

# Steps to Reproduce

1. Run the app in Simulator
2. Tap "View items". The items should load shortly
3. Once the items have loaded, tap "Re-fetch items"
4. Exit the items view by tapping "Back" in the toolbar. If the deadlock hasn't already occurred, it always does at this step.

# Some thoughts

Removing or renaming the custom-defined "id" field prevents the issue from happening. It also makes it so new models are always created, rather than being updated by the `modelContext.insert` method call. There must be some issue with modifying PersistentModel objects which is causing this issue.

A very common pattern in app development is to fetch lists of data accompanied by an "id" field from the server, then render that data. Without a better solution, a few things are implicitly required by developers to make this work with SwiftData:

1. Use a different field name for this ID (let's call it internal_id), for each @Model object
2. If the data returned by the server uses the "id" key, this also means a custom `required init(from:)` decoder initializer must be defined by each @Model object to map the server ID to this new field
3. The existing data must always be deleted, then the new data inserted. No data can be updated

There are additional side effects to this:

1. Since we can't currently define indexes in SwiftData, lookups by "internal_id" will be sub-optimal
2. Views which are rendered based on these PersistentModels will appear buggy for users since the data is deleted-then-reinserted

I'm working around #2 by comparing equality.

Hope there's an elegant solution to this out there!
