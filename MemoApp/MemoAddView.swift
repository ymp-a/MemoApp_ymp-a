//
//  MemoAddView.swift
//  MemoApp
//
//  Created by satoshi yamashita on 2022/04/19.
//

import SwiftUI

struct MemoAddView: View {
    // メモ内容入力用
    @State private var inputText = ""
    // メモ追加画面(sheet)の表示有無を管理する状態変数
    @Binding var isShowSheet: Bool
    // ボタンのグラデーション定数
    private let gradientView = LinearGradient(
        // ライナーグラデ：左から右にグラデーション
        gradient: Gradient(colors: [Color(UIColor.blue), Color(UIColor.green)]),
        startPoint: .leading,
        endPoint: .trailing)

    var body: some View {
        ZStack {
            // Naviと同じ灰色にしたいが良いのが見つからない
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
                Button(action: {
                    // カレンダー遷移したい
                }) {
                    Text("Jun 2, 2021")
                }
                .buttonStyle(.bordered)
                .controlSize(.regular)
                // カレンダーここまで

                Button(action: {
                    // 追加ボタンの処理
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
} // MemoAddViewここまで

struct MemoAddView_Previews: PreviewProvider {
    static var previews: some View {
        MemoAddView(isShowSheet: Binding.constant(true))
    }
}
