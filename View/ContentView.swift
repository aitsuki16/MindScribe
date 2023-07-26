//
//  ContentView.swift
//  mindScribe
//
//  Created by user on 2023/06/09.
//
import SwiftUI
import PencilKit

struct ContentView: View {
    @StateObject var viewModel: ContentViewModel = ContentViewModel()
    @State private var showNewEntrySheet = false
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.entries, id: \.id) { entry in
                    NavigationLink(destination: EntryDetailView(isPresented: $showNewEntrySheet, viewModel: EntryDetailViewModel(entry: entry, dataManager: viewModel.dataManager))) {
                        if let txt = entry.text {
                            if txt.count > 15 {
                                Text(String(txt.prefix(15)) + " ...")
                            } else {
                                Text(txt)
                            }
                        } else {
                            Text("")
                        }
                    }
                    .listRowBackground(Color("1"))
                }
                
                .onMove { indexSet, index in
                    viewModel.entries.move(fromOffsets: indexSet, toOffset: index)
                }
                .onDelete(perform: deleteEntry)
            }
            .navigationBarTitle("Diary")
            .foregroundColor(.indigo)
            .navigationBarItems(trailing:
                                    
            Button(action: {
                showNewEntrySheet = true
            }) {
                Image(systemName: "plus")
                    .foregroundColor(.mint)
            }
            )
            .sheet(isPresented: $showNewEntrySheet, onDismiss: {
                viewModel.loadEntries()
            }) {
                NewEntryView(isPresented: $showNewEntrySheet, onCancel: {
                    showNewEntrySheet = false
                })
            }
            .onAppear {
                viewModel.loadEntries()
            }
        }
    }
    func deleteEntry(at offsets: IndexSet) {
        for index in offsets {
            let entry = viewModel.entries[index]
            viewModel.deleteEntry(entry: entry)
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
