//
//  EntryDetailView.swift
//  mindScribe
//
//  Created by user on 2023/06/09.
//
import SwiftUI
import PencilKit

struct EntryDetailView: View {
    @State private var edit = false

    @ObservedObject var viewModel: EntryDetailViewModel
    @Binding var isPresented: Bool

    init(isPresented: Binding<Bool>, viewModel: EntryDetailViewModel) {
        self._isPresented = isPresented
        self.viewModel = viewModel
    }

    var body: some View {
        VStack {
            if viewModel.entryMode == .text {
                TextEditor(text: $viewModel.text)
                    .padding()
                    .disabled(!edit)
            } else {
                if !viewModel.drawing.bounds.isEmpty {
                    CanvasView(drawing: $viewModel.drawing)
                        .frame(width: UIScreen.main.bounds.width - 40, height: 500)
                        .border(Color.gray)
                        .padding(10)
                        .background(LinearGradient(gradient: Gradient(colors: [.red, .blue]), startPoint: .top, endPoint: .bottom))
                        .opacity(0.7)
                        .disabled(!edit)
                } else {
                    Text("No Drawing Available")
                }
            }

            Toggle("Edit", isOn: $edit)
                      .onChange(of: edit) { newValue in
                          viewModel.isEditing = newValue
                      }
            
            Button(action: {
                viewModel.saveDiary()
                isPresented = false
            }) {
                Text("Save it")
                    .font(.title3)
                    .foregroundColor(.white)
            }
            .tint(Color.blue)
            .buttonStyle(.borderedProminent)
            .buttonBorderShape(.roundedRectangle)
            .controlSize(.regular)
            .padding()
        }
        .navigationBarTitle("Diary")
    }
}
