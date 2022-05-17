//
//  MemoAddView.swift
//  MemoApp
//
//  Created by satoshi yamashita on 2022/04/19.
//

import SwiftUI
import CoreData

struct MemoAddView: View {
    // フォーカスが当たるTextFieldを判断するためのenumを作成します。
    // @FocusStateの定義にもある通り、ValueはHashableである必要がある為、準拠しています。
    enum Field: Hashable {
        case add
    }
    // @FocusStateを付与した値をnilにするとキーボードが閉じてくれるのでオプショナルにしています。
    @FocusState private var focusedField: Field?
    // 被管理オブジェクトコンテキスト（ManagedObjectContext）の取得
    @Environment(\.managedObjectContext) var viewContext
    // メモ内容入力用
    @State private var inputText = ""
    // メモ追加画面(sheet)の表示有無を管理する状態変数
    @Binding var isShowSheet: Bool
    // 日付の変数
    @State private var selectionDate = Date()

    var body: some View {
        ZStack {
            // ダークモード対応背景色
            MyColor.backColor
            // 画面全体にセット
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text("メモの追加")
                    .font(.largeTitle)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                TextField(" input here", text: $inputText)
                    .font(.title)                                        .border(.gray)
                // 第一引数には@FocusStateの値を渡し、第二引数には今回はどのfocusedFieldを指しているのかを渡しています。
                    .focused($focusedField, equals: .add)
                    .onTapGesture {
                        focusedField = .add
                    }
                Spacer()
                // 区切り線　(VStack外では縦線になる)
                Divider()
                Text("いつのメモ？")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()

                // カレンダー選択時にshortとmedium表記が混在するのはなぜ？->実機検証ではmediumのみになってた
                DatePicker("タイトル", selection: $selectionDate, displayedComponents: .date)
                // ラベルを消す
                    .labelsHidden()

                Button(action: {
                    // 追加ボタンの処理
                    addMemo()
                    // 追加画面を閉じる
                    isShowSheet.toggle()
                }) {
                    Text("＋ 追加")
                        .font(.title2)
                        .frame(maxWidth: .infinity)
                        .frame(height: 70, alignment: .center)
                        .foregroundColor(.white)
                        .background(MyColor.gradientView)
                        .cornerRadius(10)
                        .padding()
                } // 追加ボタンここまで
            } // VSTACKここまで
            // 範囲内ならタップでできるようになっている
            .contentShape(RoundedRectangle(cornerRadius: 10))
            // タップした時の処理
            .onTapGesture {
                focusedField = nil
            } // onTapGesture
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
