//
//  EntryDetailView.swift
//  mindScribe
//
//  Created by user on 2023/06/09.
//
import SwiftUI
import PencilKit
enum Tool: Hashable {
  case pen, pencil, eraser
}
struct EntryDetailView: View {
  @State private var edit = false
  @ObservedObject var viewModel: EntryDetailViewModel
  @Environment(\.presentationMode) var presentationMode
  @Binding var isPresented: Bool
  @State private var selectedTool: Tool = .pen
  init(isPresented: Binding<Bool>, viewModel: EntryDetailViewModel) {
    self._isPresented = isPresented
    self.viewModel = viewModel
  }
  var body: some View {
    VStack {
        if viewModel.entryMode == .handwriting {
            HStack {
              ToolSelectionButton(tool: .pen, selectedTool: $selectedTool)
              ToolSelectionButton(tool: .pencil, selectedTool: $selectedTool)
              ToolSelectionButton(tool: .eraser, selectedTool: $selectedTool)
              .padding()
            }
        }
 
      if viewModel.entryMode == .text {
        TextEditor(text: $viewModel.text)
          .padding()
          .disabled(!edit)
      } else {
        if !viewModel.drawing.bounds.isEmpty {
          CanvasView(drawing: $viewModel.drawing, selectedTool: $selectedTool)
            .frame(width: UIScreen.main.bounds.width - 40, height: 500)
            .border(Color.gray)
            .padding(10)
            .background(LinearGradient(gradient: Gradient(colors: [.gray, .blue]), startPoint: .top, endPoint: .bottom))
            .opacity(0.7)
            .disabled(!edit)
        } else {
          Text("No Drawing Available")
        }
      }
      Button(action: {
        viewModel.saveDiary()
        presentationMode.wrappedValue.dismiss()
        isPresented = false
      }) {
        Text("Save it")
          .font(.title3)
          .foregroundColor(.white)
      }
      .background(Color("3"))
      .buttonStyle(.bordered)
      .cornerRadius(10)
    }
    HStack {
      Toggle(isOn: $edit, label: {
        Text("Edit")
          .frame(maxWidth: .infinity, alignment: .trailing)
          .foregroundColor(Color("3"))
          .bold()
      })
      .toggleStyle(SwitchToggleStyle(tint: Color("3")))
      .toggleStyle(SwitchToggleStyle(tint: .cyan))
      .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 18))
      .onChange(of: edit) { newValue in
        viewModel.isEditing = newValue
      }
    }
  }
}
