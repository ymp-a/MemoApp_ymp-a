//
//  ColorModel.swift
//  MemoApp
//
//  Created by satoshi yamashita on 2022/05/15.
//

import SwiftUI

struct MyColor {
    // Digital Color Meterで直接RGB値を参照するのが楽
    // Assets.xcassetsでダークモードの色を設定
    static let backColor = Color("backColor")
    static let addButtonBackColor = Color("addButtonBackColor")
    // 丸ボタンの円錐グラデーション定数
    static let gradientRoundView = AngularGradient(
        // 円錐式グラデーション
        gradient: Gradient(colors: [Color(UIColor.blue), Color(UIColor.green)]),
        center: .center,
        angle: .degrees(0))
    // 追加変更ボタンのライナーグラデーション定数
    static let gradientView = LinearGradient(
        // ライナーグラデ：左から右にグラデーション
        gradient: Gradient(colors: [Color(UIColor.blue), Color(UIColor.green)]),
        startPoint: .leading,
        endPoint: .trailing)
}
