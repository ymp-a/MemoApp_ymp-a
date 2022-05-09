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
    // データベースよりデータを取得
    @FetchRequest(
        // CoreDataの並び順、key値、アニメーションを設定してる
        sortDescriptors: [NSSortDescriptor(keyPath: \Memo.date, ascending: true)],
        animation: .default)
    private var memo: FetchedResults<Memo>
    // 1行のデータを受信する
    @Binding var editMemo: FetchedResults<Memo>.Element
    // メモ追加画面(sheet)の表示有無を管理する状態変数
    @Binding var isShowEditSheet: Bool

    // ボタンのグラデーション定数
    private let gradientView = LinearGradient(
        // ライナーグラデ：左から右にグラデーション
        gradient: Gradient(colors: [Color(UIColor.blue), Color(UIColor.green)]),
        startPoint: .leading,
        endPoint: .trailing)

    var body: some View {
        ZStack {
            // Digital Color Meterで直接RGB値を参照するのが楽
            Color("backColor")
                // 画面全体にセット
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text("メモの編集")
                    .font(.largeTitle)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                // テキストフィールド
                TextField("Input here", text: Binding($editMemo.context)!)
                Spacer()
                // 区切り線　(VStack外では縦線になる)
                Divider()
                Text("いつのメモ？")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()

                // カレンダー選択時にshortとmedium表記が混在するのはなぜ？->実機検証ではmediumのみになってた
                DatePicker("タイトル", selection: Binding($editMemo.date)!, displayedComponents: .date)
                    // ラベルを消す
                    .labelsHidden()
                    // テキスト色の変更セット
                    .colorInvert()
                    .colorMultiply(.blue)

                Button(action: {
                    // 変更ボタンの処理
                    updateMemo()
                    // モーダルを閉じる
                    isShowEditSheet.toggle()
                }) {
                    Text("＋ 変更")
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
        // View初回表示前になんか処理いる？
        .onAppear {

        } // onAppearここまで
    } // bodyここまで

    // 変更機能

    private func updateMemo() {

        // 直接入力だからそのままでいい？
        //        Binding($editMemo.context)! = Binding($editMemo.context)!
        //        Binding($editMemo.date)! = Binding($editMemo.date)!
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
// struct MemoEditView_Previews: PreviewProvider {
//    @State static var editMemo: FetchedResults<Memo>.Element
//
//
//    static var previews: some View {
//        MemoEditView(editMemo: Binding.editMemo,  isShowEditSheet: Binding.constant(true))
//    }
// }
