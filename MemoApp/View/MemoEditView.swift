//
//  MemoEditView.swift
//  MemoApp
//
//  Created by satoshi yamashita on 2022/04/28.
//

import SwiftUI
import CoreData

struct MemoEditView: View {
    // EditViewModelを利用するための宣言
    private let editViewModel = EditViewModel()
    // 編集画面を閉じるための宣言
    @Environment(\.presentationMode) private var presentation
    // 被管理オブジェクトコンテキスト（ManagedObjectContext）の取得
    @Environment(\.managedObjectContext) private var viewContext
    // 行データを受信する
    private var editMemo: Memo?

    @State private var context: String
    @State private var editDate: Date

    enum Field: Hashable {
        case change
    }
    // @FocusStateを付与した値をnilにするとキーボードが閉じてくれるのでオプショナルにしています。
    @FocusState private var focusedField: Field?

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
                    .font(.title)
                    .border(.gray)
                    .focused($focusedField, equals: .change)
                    .onTapGesture {
                        focusedField = .change
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
                DatePicker("タイトル", selection: $editDate, displayedComponents: .date)
                    // ラベルを消す
                    .labelsHidden()

                Button(action: {
                    // 変更ボタンの処理
                    editViewModel.updateMemo(viewContext: viewContext, editMemo: editMemo, context: context, editDate: editDate)
                    // 編集画面を閉じる
                    self.presentation.wrappedValue.dismiss()
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
            // 範囲内ならタップでできるようになっている
            .contentShape(RoundedRectangle(cornerRadius: 10))
            // タップした時の処理
            .onTapGesture {
                focusedField = nil
            } // onTapGesture
        } // ZSTACKここまで
    } // bodyここまで
} // MemoEditViewここまで

// プレビューでeditMemoの具体的な値の指定方法がわからないのでとりあえずコメントアウトする
struct MemoEditView_Previews: PreviewProvider {
    static var previews: some View {
        MemoEditView(editMemo: nil)
    }
}
