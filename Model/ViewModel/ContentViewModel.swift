//
//  ContentViewModel.swift
//  mindScribe
//
//  Created by apple on 2023/07/16.
//

import Foundation

class ContentViewViewModel: ObservableObject {
    @Published var entries: [DiaryEntry] = []
    
    private let dataManager: DataManager = DataManager()

    func loadEntries() {
        entries = dataManager.loadDiaryEntries()
    }
    
    func deleteEntry(entry: DiaryEntry) {
        dataManager.deleteDiaryEntry(entry: entry)
    }

    func delete(at offsets: IndexSet) {
        for index in offsets {
            let entry = self.entries[index]
            deleteEntry(entry: entry)
        }
        loadEntries() // to refresh the entries array after deletion
    }
}
