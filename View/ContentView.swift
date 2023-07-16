//
//  ContentView.swift
//  mindScribe
//
//  Created by user on 2023/06/09.
//
import SwiftUI
import PencilKit

struct ContentView: View {
  @EnvironmentObject private var entryViewModel: EntryViewModel
  @State private var showNewEntrySheet = false
  var body: some View {
    NavigationView {
      List {
        ForEach(entryViewModel.entries, id: \.id) { entry in
          NavigationLink(destination: EntryDetailView(entry: entry)) {
            Text(entry.text ?? "")
          }
          .listRowBackground(Color("1"))
        }
        .onDelete(perform: deleteEntry)
        .onMove { indexSet, index in
          entryViewModel.entries.move(fromOffsets: indexSet, toOffset: index)
        }
      }
      .navigationBarTitle("Diary")
      .foregroundColor(.white)
      .navigationBarItems(trailing:
      Button(action: {
        showNewEntrySheet = true
      }) {
        Image(systemName: "plus")
          .foregroundColor(.mint)
      }
      )
      .sheet(isPresented: $showNewEntrySheet) {
        NewEntryView(isPresented: $showNewEntrySheet)
      }
      .onAppear {
        entryViewModel.loadEntries()
      }
    }
  }
  private func deleteEntry(at offsets: IndexSet) {
    for index in offsets {
      let entry = entryViewModel.entries[index]
      CoreDataRepository.shared.delete(item: entry)
    }
  }
}
struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
