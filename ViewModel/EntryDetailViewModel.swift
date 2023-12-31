//
//  EntryDetailViewModel.swift
//  mindScribe
//
//  Created by apple on 2023/07/16.
//

import CoreData
import SwiftUI
import PencilKit

class EntryDetailViewModel: ObservableObject {
    
    private let dataManager: DataManager = DataManager()
    @Published var entry: DiaryEntry
    @Published var entryMode: EntryMode = .handwriting
    @Published var drawing: PKDrawing = PKDrawing()
    @Published var text: String
    @Published var isEditing = false
    
    init(entry: DiaryEntry, dataManager: DataManager) {
        self.entry = entry
        self.text = entry.text ?? ""
        if let handwritingData = entry.handwritingData {
            do {
                self.drawing = try PKDrawing(data: handwritingData)
                self.entryMode = .handwriting
                
            } catch {
                print("Failed to load handwriting data: \(error)")
            }
            
        } else {
            self.entryMode = .text
        }
    }
    
    func saveDiary() {
        if isEditing {
            if entryMode == .text {
                entry.text = text
            } else {
                entry.handwritingData = drawing.dataRepresentation()
            }
            CoreDataRepository.shared.save(item: entry)
            isEditing = false
            entry.date = Date()
        }
    }

}
