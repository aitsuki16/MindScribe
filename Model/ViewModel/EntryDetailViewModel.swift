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
    
//    func saveDrawing() {
//      let drawingData = drawing.dataRepresentation()
//      entry.handwritingData = drawingData
//      viewModel.save(diary: entry)
//    }
    
    func saveDiary() {
//        dataManager.save(diary: entry)
    }
}
