//
//  MemoAddView.swift
//  MemoApp
//
//  Created by satoshi yamashita on 2022/04/19.
//

import SwiftUI
import CoreData

struct MemoAddView: View {
    // 被管理オブジェクトコンテキスト（ManagedObjectContext）の取得
    @Environment(\.managedObjectContext) var viewContext
    // データベースよりデータを取得
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Memo.date, ascending: true)],
        animation: .default)
    private var memos: FetchedResults<Memo>
    // メモ内容入力用
    @State private var inputText = ""
    // メモ追加画面(sheet)の表示有無を管理する状態変数
    @Binding var isShowSheet: Bool
    // 日付の変数
    @State private var selectionDate = Date()
    // ボタンのグラデーション定数
    private let gradientView = LinearGradient(
        // ライナーグラデ：左から右にグラデーション
        gradient: Gradient(colors: [Color(UIColor.blue), Color(UIColor.green)]),
        startPoint: .leading,
        endPoint: .trailing)

    var body: some View {
        ZStack {
            // Naviと同じ灰色にしたいが良いのが見つからない スクショからのスポイト利用しよう
            Color(UIColor(red: 239 / 255, green: 239 / 255, blue: 244 / 255, alpha: 1))
                // 画面全体にセット
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text("メモの追加")
                    .font(.largeTitle)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                TextField("", text: $inputText)
                Spacer()
                // 区切り線　(VStack外では縦線になる)
                Divider()
                Text("いつのメモ？")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()

                // カレンダー選択時に英語日本語表記が混在するのはなぜ？
                DatePicker("タイトル", selection: $selectionDate, displayedComponents: .date)
                    // ラベルを消す
                    .labelsHidden()

                Button(action: {
                    // 追加ボタンの処理
                    addMemo()
                    // モーダルを閉じる
                    isShowSheet.toggle()
                }) {
                    Text("＋ 追加")
                        .font(.title2)
                        .frame(maxWidth: .infinity)
                        .frame(height: 70, alignment: .center)
                        .foregroundColor(.white)
                        .background(gradientView)
                        .cornerRadius(10)
                        .padding()
                } // 追加ボタンここまで
            } // VSTACKここまで
        } // ZSTACKここまで
    } // bodyここまで
    // 追加機能
    private func addMemo() {
        // 新規レコード作成
        let newMemo = Memo(context: viewContext)
        // 直接代入する
        newMemo.context = inputText
        newMemo.date = selectionDate
        // データベース保存
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        } // do catchここまで
    } // addMemoここまで
} // MemoAddViewここまで

struct MemoAddView_Previews: PreviewProvider {
    static var previews: some View {
        MemoAddView(isShowSheet: Binding.constant(true))
    }
}
