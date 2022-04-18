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

            NavigationView {
                List {
                }
                .navigationTitle("メモ一覧")
                .navigationBarTitleDisplayMode(.automatic)
            } // NavigationViewここまで
            Text("なし")
                .font(.title)
        } // ZStack
    }
} // struct MemoListsViewここまで

struct MemoListsView_Previews: PreviewProvider {
    static var previews: some View {
        MemoListsView()
    }
}

// NEXT　右下にボタンを設置したい
