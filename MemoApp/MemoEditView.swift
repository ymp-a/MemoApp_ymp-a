////
////  MemoEditView.swift
////  MemoApp
////
////  Created by satoshi yamashita on 2022/04/28.
////
//
// import SwiftUI
// import CoreData
//
// struct MemoEditView: View {
//    // 被管理オブジェクトコンテキスト（ManagedObjectContext）の取得
//    @Environment(\.managedObjectContext) var viewContext
//
//    @ObservedObject var memo:
//        // メモ内容入力用
//        @State var editText = ""
//    // メモ追加画面(sheet)の表示有無を管理する状態変数
//    @Binding var isShowEditSheet: Bool
//    // 日付の変数
//    @State private var selectionDate = Date()
//    // ボタンのグラデーション定数
//    private let gradientView = LinearGradient(
//        // ライナーグラデ：左から右にグラデーション
//        gradient: Gradient(colors: [Color(UIColor.blue), Color(UIColor.green)]),
//        startPoint: .leading,
//        endPoint: .trailing)
//    var body: some View {
//        ZStack {
//            // Digital Color Meterで直接RGB値を参照するのが楽
//            Color(UIColor(red: 242 / 255, green: 242 / 255, blue: 247 / 255, alpha: 1))
//                // 画面全体にセット
//                .edgesIgnoringSafeArea(.all)
//            VStack {
//                Text("メモの編集")
//                    .font(.largeTitle)
//                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
//                    .frame(maxWidth: .infinity, alignment: .leading)
//                    .padding()
//                //                TextField("", text: $editText)
//                Text(memos.context!)
//                Spacer()
//                // 区切り線　(VStack外では縦線になる)
//                Divider()
//                Text("いつのメモ？")
//                    .font(.largeTitle)
//                    .fontWeight(.bold)
//                    .frame(maxWidth: .infinity, alignment: .leading)
//                    .padding()
//
//                // カレンダー選択時にshortとmedium表記が混在するのはなぜ？->実機検証ではmediumのみになってた
//                DatePicker("タイトル", selection: $selectionDate, displayedComponents: .date)
//                    // ラベルを消す
//                    .labelsHidden()
//                    // テキスト色の変更セット
//                    .colorInvert()
//                    .colorMultiply(.blue)
//
//                Button(action: {
//                    // 追加ボタンの処理
//                    //                    editMemo()
//                    // モーダルを閉じる
//                    isShowEditSheet.toggle()
//                }) {
//                    Text("＋ 変更")
//                        .font(.title2)
//                        .frame(maxWidth: .infinity)
//                        .frame(height: 70, alignment: .center)
//                        .foregroundColor(.white)
//                        .background(gradientView)
//                        .cornerRadius(10)
//                        .padding()
//                } // 追加ボタンここまで
//            } // VSTACKここまで
//        } // ZSTACKここまで
//    } // bodyここまで
//
//    // 変更機能
//
//    //    private func editMemo() {
//    //        // 新規レコード作成
//    //        let editMemo = Memo(context: viewContext)
//    //        // 直接代入する
//    //        editMemo.context = editText
//    //        editMemo.date = selectionDate
//    //        // データベース保存
//    //        do {
//    //            try viewContext.save()
//    //        } catch {
//    //            // Replace this implementation with code to handle the error appropriately.
//    //            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//    //            let nsError = error as NSError
//    //            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//    //        } // do catchここまで
//    //    } // editMemoここまで
// } // MemoEditViewここまで
//
// struct MemoEditView_Previews: PreviewProvider {
//    static var previews: some View {
//        MemoEditView(isShowEditSheet: Binding.constant(true)).environment(\Memo.managedObjectContext, PersistenceController.preview.container.viewContext)
//    }
// }