//
//  mindScribeApp.swift
//  mindScribe
//
//  Created by user on 2023/06/09.
//

import SwiftUI
import CoreData

@main 
struct mindScribeApp: App {
    let persistenceContainer = CoreDataRepository.shared //

    @StateObject private var viewModel = EntryViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
        }
    }
}
