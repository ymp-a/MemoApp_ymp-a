//
//  MemoAppApp.swift
//  MemoApp
//
//  Created by satoshi yamashita on 2022/02/24.
//

import SwiftUI

@main
struct MemoAppApp: App {
    // 永続コンテナのコントローラー生成
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            MemoListsView()
                // ManagedObjectContextを環境変数に追加
                // 第一引数はキー、第二引数は値、インスタンス
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
