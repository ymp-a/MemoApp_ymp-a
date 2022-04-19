//
//  MemoListsView.swift
//  MemoApp
//
//  Created by satoshi yamashita on 2022/02/25.
//

import SwiftUI

struct MemoListsView: View {
    // 参照先 https://blog.personal-factory.com/2020/05/04/customize-navigationbar-in-ios13/
    // メモ一覧部分を白背景にするよくわかっていない初期化部分
    init() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.white
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    var body: some View {
        ZStack {
            VStack {
                NavigationView {
                    List {
                    }
                    .navigationTitle("メモ一覧")
                    .navigationBarTitleDisplayMode(.automatic)
                } // NavigationViewここまで
            } // VStack
            Text("なし")
                .font(.title)
            // 右下のボタンを最前面に設置
            FloatingButton()
        } // ZStack
    } // bodyここまで
} // struct MemoListsViewここまで

// 参考サイト
// https://dev.classmethod.jp/articles/swiftui_floatingbutton_linkage_textfield/
// https://capibara1969.com/1800/
// 右下ボタン外観
struct FloatingButton: View {
    // メモ追加画面の表示切替
    @State private var isShowSheet: Bool = false
    // ボタンのグラデーション定数
    let gradientView = AngularGradient(
        // 円錐式グラデーション
        gradient: Gradient(colors: [Color(UIColor.blue), Color(UIColor.green)]),
        center: .center,
        angle: .degrees(0))

    var body: some View {
        VStack {
            // 上から押し込む
            Spacer()
            HStack {
                // 左から押し込む
                Spacer()
                Button(action: {
                    // タップで画面表示させる
                    self.isShowSheet = true
                }, label: {
                    Image(systemName: "plus")
                        .foregroundColor(.white)
                        .font(.system(size: 24))
                })
                .frame(width: 60, height: 60)
                .background(gradientView)
                .cornerRadius(30.0)
                .shadow(color: .gray, radius: 3, x: 3, y: 3)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 16.0, trailing: 16.0))
                // isShowSheetフラグオンで
                .sheet(isPresented: self.$isShowSheet) {
                    // 追加画面をモーダル表示する
                    MemoAddView()
                } // .sheetここまで
            } // HStackここまで
        } // VStackここまで
    } // bodyここまで
} // FlontingButtonここまで

struct MemoListsView_Previews: PreviewProvider {
    static var previews: some View {
        MemoListsView()
    }
}
