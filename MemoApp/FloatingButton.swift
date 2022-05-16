//
//  FloatingButton.swift
//  MemoApp
//
//  Created by satoshi yamashita on 2022/04/27.
//

import SwiftUI

// 参考サイト
// https://dev.classmethod.jp/articles/swiftui_floatingbutton_linkage_textfield/
// https://capibara1969.com/1800/
// 右下ボタン外観
struct FloatingButton: View {
    // メモ追加画面の表示切替
    @State private var isShowSheet: Bool = false

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
                .background(MyColor.gradientRoundView)
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

struct FloatingButtonView_Previews: PreviewProvider {
    static var previews: some View {
        FloatingButton()
    }
}
