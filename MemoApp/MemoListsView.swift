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

    var body: some View {
        // ナビゲーションバー表示、body直下に記述する
        NavigationView {
            ZStack {
                VStack {
                    // 取得したデータをリスト表示
                    List {
                        ForEach(memos) { memo in
                            Text("\(memo.context!)\n\(memo.date!, formatter: memoFormatter)")
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

// フォーマット出力形式の定義部分
private let memoFormatter: DateFormatter = {
    let formatter = DateFormatter()
    // 日本語化できない
    formatter.locale = Locale(identifier: "ja_JP")
    formatter.dateStyle = .short
    formatter.timeStyle = .none
    return formatter
}()
// 参考サイト
// https://dev.classmethod.jp/articles/swiftui_floatingbutton_linkage_textfield/
// https://capibara1969.com/1800/
// 右下ボタン外観
struct FloatingButton: View {
    // メモ追加画面の表示切替
    @State private var isShowSheet: Bool = false
    // ボタンのグラデーション定数
    private let gradientView = AngularGradient(
        // 円錐式グラデーション
        gradient: Gradient(colors: [Color(UIColor.blue), Color(UIColor.green)]),
        center: .center,
        angle: .degrees(0))

    var body: some View {
        VStack {
            // 上から押し込む
            Spacer()
            HStack {
                // 左から押し込む
                Spacer()
                Button(action: {
                    // タップで画面表示させる
                    isShowSheet.toggle()
                }, label: {
                    Image(systemName: "plus")
                        .foregroundColor(.white)
                        .font(.system(size: 24))
                })
                .frame(width: 60, height: 60)
                .background(gradientView)
                .cornerRadius(30.0)
                .shadow(color: .gray, radius: 3, x: 3, y: 3)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 16.0, trailing: 16.0))
                // isShowSheetフラグオンで
                .sheet(isPresented: self.$isShowSheet) {
                    // 追加画面をモーダル表示する,状態をメモ追加画面に渡す
                    MemoAddView(isShowSheet: $isShowSheet)
                } // .sheetここまで
            } // HStackここまで
        } // VStackここまで
    } // bodyここまで
} // FlontingButtonここまで

struct MemoListsView_Previews: PreviewProvider {
    static var previews: some View {
        MemoListsView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
