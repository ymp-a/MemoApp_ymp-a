//
//  EditViewModel.swift
//  MemoApp
//
//  Created by satoshi yamashita on 2022/05/23.
//

import SwiftUI
import CoreData

class EditViewModel {
    func updateMemo(viewContext: NSManagedObjectContext, editMemo: Memo?, context: String, editDate: Date) {
        // 指定行に値をセット、!の位置は合っているのか不明？
        editMemo!.context = context
        editMemo!.date = editDate
        // データベース保存
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        } // do catchここまで
    } // editMemoここまで
} // EditViewModelここまで
