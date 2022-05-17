//
//  MemoEditView.swift
//  MemoApp
//
//  Created by satoshi yamashita on 2022/04/28.
//

import SwiftUI
import CoreData

struct MemoEditView: View {
    // 被管理オブジェクトコンテキスト（ManagedObjectContext）の取得
    @Environment(\.managedObjectContext) var viewContext
    // 行データを受信する
    var editMemo: Memo?

    @State private var context: String
    @State private var editDate: Date

    init(editMemo: Memo?) {
        // 1行のデータをnilチェック
        if let editMemo = editMemo {
            //　self.editMemoが21行目のeditMemoのこと、初期化後に代入している
            self.editMemo = editMemo
            // メモ内容をアンラップして代入
            self._context = State(initialValue: editMemo.context!)
            // 時間をアンラップして代入
            self._editDate = State(initialValue: editMemo.date!)

        } else {
            // プレビュー用
            self._context = State(initialValue: "testmemo")
            self._editDate = State(initialValue: Date())
        }
    } // initここまで

    var body: some View {
        ZStack {
            // ダークモード対応背景色
            MyColor.backColor
                // 画面全体にセット
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text("メモの編集")
                    .font(.largeTitle)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                // テキストフィールド
                TextField("Input here", text: $context)
                Spacer()
                // 区切り線　(VStack外では縦線になる)
                Divider()
                Text("いつのメモ？")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()

                // カレンダー選択時にshortとmedium表記が混在するのはなぜ？->実機検証ではmediumのみになってた
                DatePicker("タイトル", selection: $editDate, displayedComponents: .date)
                    // ラベルを消す
                    .labelsHidden()

                Button(action: {
                    // 変更ボタンの処理
                    updateMemo()
                    // モーダルを閉じる
                    //                    isShowEditSheet.toggle()
                }) {
                    Text("＋ 変更")
                        .font(.title2)
                        .frame(maxWidth: .infinity)
                        .frame(height: 70, alignment: .center)
                        .foregroundColor(.white)
                        .background(MyColor.gradientView)
                        .cornerRadius(10)
                        .padding()
                } // 追加ボタンここまで
            } // VSTACKここまで
        } // ZSTACKここまで
    } // bodyここまで

    // 変更機能
    private func updateMemo() {
        // 指定行に値をセット、!の位置は合っているのか不明？
        editMemo!.context = context
        editMemo!.date = editDate
        // データベース保存
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        } // do catchここまで
    } // editMemoここまで
} // MemoEditViewここまで

// プレビューでeditMemoの具体的な値の指定方法がわからないのでとりあえずコメントアウトする
struct MemoEditView_Previews: PreviewProvider {
    static var previews: some View {
        MemoEditView(editMemo: nil)
    }
}
