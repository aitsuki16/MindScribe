//
//  EntryDetailView.swift
//  mindScribe
//
//  Created by user on 2023/06/09.
//
import SwiftUI
import PencilKit

struct EntryDetailView: View {
    @EnvironmentObject private var viewModel: DiaryViewModel
    @State private var text: String
    @State private var drawing = PKDrawing()

    let entry: DiaryEntry

    init(entry: DiaryEntry) {
        self.entry = entry
        _text = State(initialValue: entry.text ?? "")
        if let handwritingData = entry.handwritingData {
            do {
                _drawing = try State(initialValue: PKDrawing(data: handwritingData))
            } catch {
                _drawing = State(initialValue: PKDrawing())
            }
        } else {
            _drawing = State(initialValue: PKDrawing())
        }
    }

    var body: some View {
        VStack {
            TextEditor(text: $text)
                .padding()
                .onChange(of: text) { newValue in
                    entry.text = newValue
                    viewModel.save(diary: entry)
                }

            CanvasView(drawing: $drawing)
                .frame(width: UIScreen.main.bounds.width - 40, height: 500)
                .border(Color.gray)
                .padding(10)
                .background(LinearGradient(gradient: Gradient(colors: [.red, .blue]), startPoint: .top, endPoint: .bottom))
                .opacity(0.7)

            Button(action: {
                saveDrawing()
            }) {
                Text("Save Drawing")
            }
            .padding()
        }
        .navigationBarTitle("Diary")
    }

    private func saveDrawing() {
        let drawingData = drawing.dataRepresentation()
        entry.handwritingData = drawingData
        viewModel.save(diary: entry)
    }
}

struct EntryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        EntryDetailView(entry: CoreDataRepository.shared.newEntity())
    }

}
