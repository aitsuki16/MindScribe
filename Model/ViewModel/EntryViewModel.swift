//
//  DiaryViewModel.swift
//  mindScribe
//
//  Created by user on 2023/06/10.
//

import CoreData
import SwiftUI
import PencilKit


class EntryViewModel: ObservableObject {
    @Published var entries: [DiaryEntry] = []
    @Published var entryMode: EntryMode = .handwriting
    @Published var newEntryText: String = ""
    @Published var drawing = PKDrawing()

    func addTextDiary(text: String) {
        let diary: DiaryEntry = CoreDataRepository.shared.newEntity()
        diary.text = text
        diary.date = Date()
        
        CoreDataRepository.shared.save(item: diary)
        loadEntries()
    }
    
    func addHandWritingDiary(handwritingData: Data?) {
        let diary: DiaryEntry = CoreDataRepository.shared.newEntity()
        diary.handwritingData = handwritingData
        diary.text = "hand writing"
        diary.date = Date()
        
        CoreDataRepository.shared.save(item: diary)
        loadEntries()
    }
    
    func save(diary: DiaryEntry) {
        CoreDataRepository.shared.save(item: diary)
    }
    
    func loadEntries() {
        entries = CoreDataRepository.shared.fetch()
    }
    
    func saveEntry() {
      switch entryMode {
      case .text:
        addTextDiary(text: newEntryText)
      case .handwriting:
        addHandWritingDiary(handwritingData: drawing.dataRepresentation())
      }
      newEntryText = ""
    }
}
