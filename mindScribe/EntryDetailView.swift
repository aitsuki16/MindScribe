//
//  EntryDetailView.swift
//  mindScribe
//
//  Created by user on 2023/06/09.
//
import SwiftUI
import PencilKit


struct EntryDetailView: View {
  @EnvironmentObject private var viewModel: EntryViewModel
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
        print("Failed to load handwriting data: \(error.localizedDescription)")
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
  private func drawingToImage(_ drawing: PKDrawing) -> UIImage? {
    let canvasView = PKCanvasView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
    canvasView.drawing = drawing
    UIGraphicsBeginImageContextWithOptions(canvasView.bounds.size, false, 0.0)
    guard let context = UIGraphicsGetCurrentContext() else { return nil }
    canvasView.layer.render(in: context)
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return image
  }
}
