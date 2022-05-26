//
//  MemoListsView.swift
//  MemoApp
//
//  Created by satoshi yamashita on 2022/02/25.
//

import SwiftUI
import CoreData

struct MemoListsView: View {
    // ViewModel
    private let deleteViewModel = DeleteViewModel()
    // 被管理オブジェクトコンテキスト（ManagedObjectContext）の取得
    @Environment(\.managedObjectContext) private var viewContext
    // データベースよりデータを取得
    @FetchRequest(
        // CoreDataの並び順、key値、アニメーションを設定してる
        sortDescriptors: [NSSortDescriptor(keyPath: \Memo.date, ascending: true)],
        animation: .default)
    private var memos: FetchedResults<Memo>
    // タップした行の情報を渡す
    private var editMemo: Memo?
    // フォーマット出力形式の定義部分
    private var memoFormatter: DateFormatter {
        let formatter = DateFormatter()
        // .Dateの表示をセット
        formatter.dateStyle = .long
        formatter.timeStyle = .long
        return formatter
    }

    var body: some View {
        // ナビゲーションバー表示、body直下に記述する。起点になるViewに記述する。
        NavigationView {
            ZStack {
                VStack {
                    // Memoがあるとき
                    if memos.isEmpty {
                        // メモがないときに表示するView
                        HStack {
                            Text("なし").font(.title)
                        } // HStackここまで
                    } else {
                        // メモがあるときに表示するView
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
                            // 他のファイルにメソッドがある場合はクロージャー展開必須
                            // 複数選択を行える機能もあるのでInt型ではなくindexSetで要素を取得する
                            .onDelete { indexSet in
                                deleteViewModel.deleteMemos(offsets: indexSet, memos: memos, viewContext: viewContext)
                            } // onDeleteここまで
                        } // Listここまで
                        .navigationTitle("メモ一覧")
                        .navigationBarTitleDisplayMode(.automatic)
                    } // if文ここまで
                } // VStackここまで

                // ボタンのViewここから
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        // 追加ボタン
                        Button(action: {
                            // タップで画面表示させる
                        }, label: {
                            // 追加Viewへ遷移する
                            NavigationLink(destination: MemoAddView()) {
                                Image(systemName: "plus")
                                    .foregroundColor(.white)
                                    .font(.system(size: 24))
                                    .padding(20)
                                    .background(Color.gradientRoundView)
                                    .clipShape(Circle())
                            } // NavigationLinkここまで
                        })
                        .padding(20)
                    } // HStackここまで
                } // VStackここまで
            } // ZStackここまで
        } // NavigationViewここまで
    } // bodyここまで
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
