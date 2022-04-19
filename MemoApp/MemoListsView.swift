//
//  MemoListsView.swift
//  MemoApp
//
//  Created by satoshi yamashita on 2022/02/25.
//

import SwiftUI

struct MemoListsView: View {
    // 参照先 https://blog.personal-factory.com/2020/05/04/customize-navigationbar-in-ios13/
    // メモ一覧部分を白背景にする
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
            FloatingButton()
        } // ZStack
    }
} // struct MemoListsViewここまで

// https://dev.classmethod.jp/articles/swiftui_floatingbutton_linkage_textfield/
// https://capibara1969.com/1800/
// ボタンの外観
struct FloatingButton: View {
    let gradientView = AngularGradient(
        // 円錐式グラデーション
        gradient: Gradient(colors: [Color(UIColor.blue), Color(UIColor.green)]),
        center: .center,
        angle: .degrees(0))

    var body: some View {
        VStack {  // --- 1
            Spacer()
            HStack { // --- 2
                Spacer()
                Button(action: {
                    print("Tapped!!") // --- 3
                }, label: {
                    Image(systemName: "plus")
                        .foregroundColor(.white)
                        .font(.system(size: 24)) // --- 4
                })
                .frame(width: 60, height: 60)
                .background(gradientView)
                .cornerRadius(30.0)
                .shadow(color: .gray, radius: 3, x: 3, y: 3)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 16.0, trailing: 16.0)) // --- 5

            } // HStackここまで
        } // VStackここまで
    } // bodyここまで
    //    /// 背景グラデーションを作成する
    //    private func backGroundColor() -> LinearGradient {
    //        // 左上から右下にポイントを設定する。
    //        let start = UnitPoint.init(x: 1, y: 1) // 左上(始点)
    //        let end = UnitPoint.init(x: 0.5, y: 0) // 右下(終点)
    //
    //        // 「Color」は以前の「UIColor」からの変換もできるぞ！ 助かる。
    //        let colors = Gradient(colors: [Color(UIColor.blue), Color(UIColor.green)])
    //
    //        let gradientColor = LinearGradient(gradient: colors, startPoint: start, endPoint: end)
    //
    //        return gradientColor
    //    }
} // FlontingButtonここまで

struct MemoListsView_Previews: PreviewProvider {
    static var previews: some View {
        MemoListsView()
    }
}

// NEXT　右下にボタンを設置したい
