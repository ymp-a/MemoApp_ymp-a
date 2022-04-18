//
//  MemoListsView.swift
//  MemoApp
//
//  Created by satoshi yamashita on 2022/02/25.
//

import SwiftUI

struct MemoListsView: View {
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

            //            Button(action: {
            //                // 処理
            //            }) {
            //                Text("ボタン")
            //                    .frame(width: 35.0, height: 35.0, alignment: .leading)
            //            }
            //            .padding(.trailing, 20.0)
            //            .padding(.bottom, 30.0)
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
