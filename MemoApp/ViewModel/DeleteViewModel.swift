//
//  DeleteViewModel.swift
//  MemoApp
//
//  Created by satoshi yamashita on 2022/05/24.
//

import SwiftUI
import CoreData

class DeleteViewModel {
    // classの中では＠Environment利用できないのでviewContextを引数で連れてきている。
    // viewContextはCoreData機能（セーブとか）を利用するのに必要。
    func deleteMemos(offsets: IndexSet, memos: FetchedResults<Memo>, viewContext: NSManagedObjectContext) {
        // レコードの削除
        offsets.map { memos[$0] }.forEach(viewContext.delete)
        // データベース保存
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }// do catchここまで
    } // addMemoここまで
} // DeleteViewModelここまで
