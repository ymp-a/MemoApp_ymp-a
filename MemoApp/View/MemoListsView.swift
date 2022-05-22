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
    @Environment(\.managedObjectContext) private var viewContext
    // データベースよりデータを取得
    @FetchRequest(
        // CoreDataの並び順、key値、アニメーションを設定してる
        sortDescriptors: [NSSortDescriptor(keyPath: \Memo.date, ascending: true)],
        animation: .default)
    private var memos: FetchedResults<Memo>
    // タップした行の情報を渡す
    @State var editMemo: Memo?
    // フォーマット出力形式の定義部分
    private var memoFormatter: DateFormatter {
        let formatter = DateFormatter()
        // .Dateの表示をセット
        formatter.dateStyle = .long
        formatter.timeStyle = .long
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
                            // 行毎に編集Viewとmemo情報を生成している
                            NavigationLink(destination: MemoEditView(editMemo: memo)) {
                                HStack {
                                    // 一部のテキスト装飾は+で繋げればよい
                                    Text("\(memo.context!)")
                                        .fontWeight(.bold)
                                        .font(.title)
                                        + Text("\n\(memo.date!, formatter: memoFormatter)")
                                        .fontWeight(.bold)
                                    Spacer()
                                } // HStackここまで
                                //　checkedフラグを変更する
                                .contentShape(Rectangle())
                            } // NavigationLinkここまで
                        } // ForEachここまで
                        // 削除処理イベント
                        .onDelete(perform: deleteMemos)
                    } // Listここまで
                    .navigationTitle("メモ一覧")
                    .navigationBarTitleDisplayMode(.automatic)

                    .toolbar {
                        ToolbarItem(placement: .bottomBar) {
                            FloatingButton()
                        } // ToolbarItemここまで
                    } // .toolbarここまで
                } // VStackここまで
                // memoリストがなければなしテキストを表示する
                if memos.isEmpty {
                    Text("なし").font(.title)
                }
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
    @Environment(\.managedObjectContext) var viewContext
    // データベースよりデータを取得
    @FetchRequest(
        // CoreDataの並び順、key値、アニメーションを設定してる
        sortDescriptors: [NSSortDescriptor(keyPath: \Memo.date, ascending: true)],
        animation: .default)
    static var memos: FetchedResults<Memo>
    static var previews: some View {
        MemoListsView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
