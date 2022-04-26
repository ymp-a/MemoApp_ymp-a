//
//  ContentView.swift
//  MemoApp
//
//  Created by satoshi yamashita on 2022/02/24.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Memo.date, ascending: true)],
        animation: .default)
    private var memos: FetchedResults<Memo>

    var body: some View {
        NavigationView {
            List {
                ForEach(memos) { item in
                    NavigationLink {
                        Text("memo at \(item.date!, formatter: itemFormatter)")
                    } label: {
                        Text(item.date!, formatter: itemFormatter)
                    }
                }
                .onDelete(perform: deleteMemos)
            } // Listここまで
            // タイトルはNavigationViewクロージャの最後につける
            .navigationBarTitle("メモの一覧")
            //            .toolbar {
            //                ToolbarItem(placement: .navigationBarTrailing) {
            //                    EditButton()
            //                }
            //                ToolbarItem {
            //                    Button(action: addItem) {
            //                        Label("Add Item", systemImage: "plus")
            //                    }
            //                }
            //            } // .toolbarここまで
            Text("Select an item")
        } // NavigationViewここまで

    } // bodyここまで

    private func addMemo() {
        withAnimation {
            let newMemo = Memo(context: viewContext)
            newMemo.date = Date()

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteMemos(offsets: IndexSet) {
        withAnimation {
            offsets.map { memos[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
} // struct ContentViewここまで

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
