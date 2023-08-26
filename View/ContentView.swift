//
//  ContentView.swift
//  mindScribe
//
//  Created by user on 2023/06/09.
//
import SwiftUI
import PencilKit

struct ContentView: View {
    @Environment(\.managedObjectContext) var context
    @StateObject var viewModel: ContentViewModel = ContentViewModel()
    @State private var showNewEntrySheet = false
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        return formatter
    }()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.entries) { entry in
                    NavigationLink(destination: EntryDetailView(isPresented: $showNewEntrySheet, viewModel: EntryDetailViewModel(entry: entry, dataManager: viewModel.dataManager))) {
                        ZStack {
                        HStack {
                            Image(systemName: "pencil")
                                .foregroundColor(.indigo)
                                .font(.headline)
                            
                            VStack(alignment: .leading) {
                                Text(entry.text ?? "")
                                    .font(.headline)
                                if let date = entry.date {
                                    Text(dateFormatter.string(from: date))
                                        .foregroundColor(.secondary)
                                        .font(.footnote)
                                }
                            }
                            .padding(.vertical, 8)
                           }
                        }
                    }
                    //.listRowBackground(Color("5"))

                }
                .onMove { indexSet, index in
                    viewModel.entries.move(fromOffsets: indexSet, toOffset: index)
                }
                .onDelete(perform: deleteEntry)
            }
            .scrollContentBackground(.hidden)
            .background(LinearGradient(gradient: Gradient(colors: [.indigo, .cyan]), startPoint: .topLeading, endPoint: .bottom))
            .opacity(0.7)
            .navigationTitle("MindScribe")
            .navigationBarTitleDisplayMode(.inline)
            
            .navigationBarItems(trailing:
                HStack {
                    Button(action: {
                        showNewEntrySheet = true
                    }) {
                        Image(systemName: "plus")
                            .foregroundColor(.white)
                    }
                }
            )
            .sheet(isPresented: $showNewEntrySheet, onDismiss: {
                viewModel.loadEntries()
            }) {
                NewEntryView(isPresented: $showNewEntrySheet, onCancel: {
                    showNewEntrySheet = false
                })
                .accentColor(Color.blue)
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
