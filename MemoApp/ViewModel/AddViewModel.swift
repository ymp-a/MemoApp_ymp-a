//
//  AddViewModel.swift
//  MemoApp
//
//  Created by satoshi yamashita on 2022/05/14.
//

import SwiftUI
import CoreData

class AddViewModel {
    private var addText: String = ""
    private var addDate: Date = Date()
    // 被管理オブジェクトコンテキスト（ManagedObjectContext）の取得
    @Environment(\.managedObjectContext) private var viewContext
    // 追加機能
    // viewContextを引数でもらう意味は？
    func addMemo(viewContext: NSManagedObjectContext, addText: String, addDate: Date) {
        // 新規レコード作成
        let newMemo = Memo(context: viewContext)
        // 直接代入する
        newMemo.context = addText
        newMemo.date = addDate
        // データベース保存
        do {
            // 最初セーブ時にnilErorrが発生した。viewContextが悪そうだったので引数で連れてきたらセーブできたがよく解っていない
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        } // do catchここまで
    } // addMemoここまで
} /// AddViewModelここまで
