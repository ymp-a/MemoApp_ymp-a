//
//  MemoAppApp.swift
//  MemoApp
//
//  Created by satoshi yamashita on 2022/02/24.
//

import SwiftUI

@main
struct MemoAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            MemoListsView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
