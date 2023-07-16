//
//  EntryDetailView.swift
//  mindScribe
//
//  Created by user on 2023/06/09.
//
import SwiftUI
import PencilKit

struct EntryDetailView: View {
    @ObservedObject var viewModel: EntryDetailViewModel
    @Binding var isPresented: Bool
    init(isPresented: Binding<Bool>, viewModel: EntryDetailViewModel) {
        self._isPresented = isPresented
        self.viewModel = viewModel
    }
    var body: some View {
        VStack {
            TextEditor(text: $viewModel.text)
                .padding()
                .onChange(of: viewModel.text) { newValue in
                    viewModel.entry.text = newValue
                    //                    viewModel.save(diary: viewModel.entry)
                }
            if viewModel.entryMode == .text {
                TextEditor(text: $viewModel.text)
              .padding(10)
              .background(LinearGradient(gradient: Gradient(colors: [.teal, .indigo]), startPoint: .top, endPoint: .bottom))
              .opacity(0.7)
          } else {
              if !viewModel.drawing.bounds.isEmpty {
                  CanvasView(drawing: $viewModel.drawing)
                      .frame(width: UIScreen.main.bounds.width - 40, height: 500)
                      .border(Color.gray)
                      .padding(10)
                      .background(LinearGradient(gradient: Gradient(colors: [.red, .blue]), startPoint: .top, endPoint: .bottom))
                      .opacity(0.7)
              } else {
                  Text("No Drawing Available")
              }
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
