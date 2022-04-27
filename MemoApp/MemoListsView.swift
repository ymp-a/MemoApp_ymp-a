//
//  MemoListsView.swift
//  MemoApp
//
//  Created by satoshi yamashita on 2022/02/25.
//

import SwiftUI
import CoreData

struct MemoListsView: View {
    // 被管理オブジェクトコンテキスト（ManagedObjectContext）の取得
    @Environment(\.managedObjectContext) var viewContext
    // データベースよりデータを取得
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Memo.date, ascending: true)],
        animation: .default)
    private var memos: FetchedResults<Memo>
    // 参照先 https://blog.personal-factory.com/2020/05/04/customize-navigationbar-in-ios13/
    // メモ一覧部分を白背景にするよくわかっていない初期化部分
    init() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.white
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    // フォーマット出力形式の定義部分
    private var memoFormatter: DateFormatter {
        let formatter = DateFormatter()
        // 日本語化できないままだが課題の表記は.longだった
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter
    }

    var body: some View {
        // ナビゲーションバー表示、body直下に記述する
        NavigationView {
            ZStack {
                VStack {
                    // 取得したデータをリスト表示
                    List {
                        ForEach(memos) { memo in
                            // 一部のテキスト装飾は+で繋げればよい
                            Text("\(memo.context!)")
                                .fontWeight(.bold)
                                .font(.title)
                            + Text("\n\(memo.date!, formatter: memoFormatter)")
                                .fontWeight(.bold)
                        } // ForEachここまで
                        // 削除処理イベント
                        .onDelete(perform: deleteMemos)
                    } // Listここまで
                    .navigationTitle("メモ一覧")
                    .navigationBarTitleDisplayMode(.automatic)
                } // VStackここまで
                // memoリストがなければなしテキストを表示する
                if memos.isEmpty {
                    Text("なし").font(.title)
                }
                // 右下のボタンを最前面に設置
                FloatingButton()
            } // ZStackここまで
        } // NavigationViewここまで
    } // bodyここまで

    // 削除
    private func deleteMemos(offsets: IndexSet) {
        // レコードの削除
        offsets.map { memos[$0] }.forEach(viewContext.delete)
        // データベース保存
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }// do catchここまで
    } // addMemoここまで
} // struct MemoListsViewここまで

struct MemoListsView_Previews: PreviewProvider {
    static var previews: some View {
        MemoListsView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
