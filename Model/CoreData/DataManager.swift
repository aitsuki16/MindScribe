//
//  DataManager.swift
//  mindScribe
//
//  Created by apple on 2023/07/16.
//

import Foundation

class DataManager {
    func save(diary: DiaryEntry) {
        CoreDataRepository.shared.save(item: diary)
    }
    
    func loadDiaryEntries () -> [DiaryEntry] {
        CoreDataRepository.shared.fetch()
    }
    
    func deleteDiaryEntry(entry: DiaryEntry) {
        CoreDataRepository.shared.delete(item: entry)
    }
}
