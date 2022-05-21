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
    @State var isShowSheet: Bool = false

    var body: some View {
        //        NavigationView {
        ZStack {
            MyColor.addButtonBackColor
                .edgesIgnoringSafeArea(.bottom)

            Button(action: {
                // タップで画面表示させる
                //                    isShowSheet.toggle()
            }, label: {
                // 追加Viewへ遷移する
                NavigationLink(destination: MemoAddView()) {
                    Image(systemName: "plus")
                        .foregroundColor(.white)
                        .font(.system(size: 24))
                } // NavigationLinkここまで
            })
            .frame(width: 60, height: 60)
            .background(MyColor.gradientRoundView)
            .cornerRadius(30.0)
            .shadow(color: .gray, radius: 3, x: 3, y: 3)
            //            .padding(EdgeInsets(top: 0, leading: 0, bottom: 16.0, trailing: 16.0))
            .frame(maxWidth: .infinity, //　左右いっぱいに広げる
                   maxHeight: .infinity, // 上下いっぱいに広げる
                   alignment: .bottomTrailing) // 右下に揃える
        } // ZStackここまで
        //        } // NavigationViewここまで
    } // bodyここまで
} // FlontingButtonここまで

struct FloatingButtonView_Previews: PreviewProvider {
    static var previews: some View {
        FloatingButton()
    }
}
