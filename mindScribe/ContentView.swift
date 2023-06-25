//
//  ContentView.swift
//  mindScribe
//
//  Created by user on 2023/06/09.
//
import PencilKit
import CoreData
import SwiftUI
struct ContentView: View {
    @EnvironmentObject private var viewModel: DiaryViewModel
    @State private var showNewEntrySheet = false
    @State private var newEntryText = ""

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.entries, id: \.id) { entry in
                    NavigationLink(destination: EntryDetailView(entry: entry)) {
                        if let imageData = entry.handwritingData, // fetchingHandwring
                           let image = UIImage(data: imageData) {
                            Image(uiImage: image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 100, height: 100) // Adjust the size as needed
                        } else {
                            Text(entry.text ?? "")
                        }
                    }
                    .listRowBackground(Color("1"))
                }
                .onDelete(perform: deleteEntry)
                .onMove { indexSet, index in
                    viewModel.entries.move(fromOffsets: indexSet, toOffset: index)
                }
            }
            .navigationBarTitle("Diary")
            .foregroundColor(.purple)
            .navigationBarItems(trailing:
                Button(action: {
                    showNewEntrySheet = true
                }) {
                    Image(systemName: "plus")
                        .foregroundColor(.mint)
                }
            )
            .sheet(isPresented: $showNewEntrySheet) {
                NewEntryView(isPresented: $showNewEntrySheet, newEntryText: $newEntryText)
            }
            .onAppear {
                viewModel.loadEntries()
            }
        }
    }

    private func deleteEntry(at offsets: IndexSet) {
        for index in offsets {
            let entry = viewModel.entries[index]
            CoreDataRepository.shared.delete(item: entry)
        }
    }
}

