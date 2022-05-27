//
//  MemoAddView.swift
//  MemoApp
//
//  Created by satoshi yamashita on 2022/04/19.
//

import SwiftUI
import CoreData

struct MemoAddView: View {
    // AddViewModelを利用するための宣言
    private let addViewModel = AddViewModel()
    // 編集画面を閉じるための宣言
    @Environment(\.presentationMode) private var presentation
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
    // 日付の変数
    @State private var selectionDate = Date()
    // TextEditorの色を初期化
    init() {
        // TextEditorの背景色を設定するため
        UITextView.appearance().backgroundColor = .clear
    }

    var body: some View {
        ZStack {
            // ダークモード対応背景色
            Color.backColor
                // 画面全体にセット
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text("メモの追加")
                    .font(.title)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading)
                TextEditor(text: $inputText)
                    .font(.title3)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.backColor)
                    .padding()
                    // 第一引数には@FocusStateの値を渡し、第二引数には今回はどのfocusedFieldを指しているのかを渡しています。
                    .focused($focusedField, equals: .add)
                    .onTapGesture {
                        focusedField = .add
                    }
                //                Spacer()
                // 区切り線　(VStack外では縦線になる)
                Divider()
                Text("いつのメモ？")
                    .font(.title)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading)

                // カレンダー選択時にshortとmedium表記が混在するのはなぜ？->実機検証ではmediumのみになってた
                DatePicker("タイトル", selection: $selectionDate, displayedComponents: .date)
                    // ラベルを消す
                    .labelsHidden()

                Button(action: {
                    // 追加ボタンの処理
                    addViewModel.addMemo(viewContext: viewContext, addText: inputText, addDate: selectionDate)
                    // 追加画面を閉じる
                    self.presentation.wrappedValue.dismiss()
                }) {
                    Text("＋ 追加")
                        .font(.title2)
                        .frame(maxWidth: .infinity)
                        .frame(height: 70, alignment: .center)
                        .foregroundColor(.white)
                        .background(Color.gradientView)
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
} // MemoAddViewここまで

struct MemoAddView_Previews: PreviewProvider {
    static var previews: some View {
        //        MemoAddView(isShowSheet: Binding.constant(true))
        MemoAddView()
    }
}
