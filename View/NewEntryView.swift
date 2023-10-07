//
//  NewEntryView.swift
//  mindScribe
//
//  Created by user on 2023/06/09.
//
import SwiftUI
import PencilKit

struct NewEntryView: View {
    @Binding var isPresented: Bool
    @StateObject var viewModel: EntryViewModel = EntryViewModel()
    var onCancel: () -> Void
    @State private var selectedTool: Tool = .pen
    @State private var toolColor: Color = .black
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                CustomSegmentedControl(selection: $viewModel.entryMode)
                
                if viewModel.entryMode == .handwriting {
                    HStack {
                        ToolSelectionButton(tool: .pen, selectedTool: $selectedTool)
                        ToolSelectionButton(tool: .pencil, selectedTool: $selectedTool)
                        ToolSelectionButton(tool: .eraser, selectedTool: $selectedTool)
                    }
                }
                
                if viewModel.entryMode == .text {
                    TextEditor(text: $viewModel.newEntryText)
                        .frame(maxWidth: 400, maxHeight: 250)
                        .padding(8)
                        .background(LinearGradient(gradient: Gradient(colors: [.gray, .indigo]), startPoint: .top, endPoint: .bottom))
                        .opacity(0.8)
                } else {
                    CanvasView(drawing: $viewModel.drawing, selectedTool: $selectedTool, toolColor: $toolColor)
                    
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    
                        .padding(8)
                        .background(LinearGradient(gradient: Gradient(colors: [.indigo, .cyan]), startPoint: .top, endPoint: .bottom))
                        .opacity(0.7)
                    ColorPicker("Color", selection: $toolColor)
                    Button(action: {
                        viewModel.applyRainbowStroke()
                        selectedTool = .pen
                        toolColor = .black // Reset to default
                    }) {
                        Text("Apply Rainbow")
                            .foregroundColor(.indigo)
                    }
                    .padding()
                    .buttonStyle(.borderedProminent)
                }
                
                Button(action: {
                    viewModel.saveEntry()
                    isPresented = false
                }) {
                    Text("Save")
                        .foregroundColor(.indigo)
                        .frame(width: 50,height: 20)
                }
                .padding()
                .tint(Color("1"))
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.roundedRectangle)
                .controlSize(.regular)
            }
            .padding()
            .navigationBarItems(trailing: Button("Cancel", action: {
                onCancel()
            }))
        }
    }
}

struct NewEntryView_Previews: PreviewProvider {
    static var previews: some View {
        NewEntryView(isPresented: .constant(false), onCancel: {})
    }
}
