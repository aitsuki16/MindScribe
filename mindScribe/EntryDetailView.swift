//
//  EntryDetailView.swift
//  mindScribe
//
//  Created by user on 2023/06/09.
//
import SwiftUI
import PencilKit

struct EntryDetailView: View {
    @EnvironmentObject private var viewModel: EntryDetailViewModel
    @State private var text: String
    @State private var drawing = PKDrawing()
    @Binding var isPresented: Bool
    @Binding var entry: DiaryEntry
    var body: some View {
        VStack {
            TextEditor(text: $text)
                .padding()
                .onChange(of: text) { newValue in
                    entry.text = newValue
                    viewModel.save(diary: entry)
                }
            if let image = drawingToImage(drawing) {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity, maxHeight: 300)
                    .background(Color.white)
                    .cornerRadius(8)
                    .padding()
            } else {
                Text("No handwriting image")
            }
            Button(action: {
                viewModel.saveDiary()
                isPresented = false
            }) {
                Text("Save Drawing")
            }
            .padding()
        }
        .navigationBarTitle("Diary")
    }
}
