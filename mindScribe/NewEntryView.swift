//
//  NewEntryView.swift
//  mindScribe
//
//  Created by user on 2023/06/09.
//



import SwiftUI
import PencilKit

enum EntryMode {
    case text
    case handwriting
}

struct NewEntryView: View {
    @Binding var isPresented: Bool
    @Binding var newEntryText: String
    @EnvironmentObject private var viewModel: DiaryViewModel
    @State private var entryMode: EntryMode = .handwriting
    @State private var drawing = PKDrawing()
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                Text("New Entry")
                    .font(.largeTitle)
                    .padding()
                
                Picker("Entry Mode", selection: $entryMode) {
                    Text("Text").tag(EntryMode.text)
                    Text("Handwriting").tag(EntryMode.handwriting)
                }
                .pickerStyle(.navigationLink)
                .padding()
                
                if entryMode == .text {
                    TextEditor(text: $newEntryText)
                        .padding(10)
                        .background(LinearGradient(gradient: Gradient(colors: [.teal, .indigo]), startPoint: .top, endPoint: .bottom))
                        .opacity(0.7)
                } else {
                    CanvasView(drawing: $drawing)
                        .frame(width: UIScreen.main.bounds.width - 40, height: 500)
                        .border(Color.gray)
                        .padding(10)
                        .background(LinearGradient(gradient: Gradient(colors: [.red, .blue]), startPoint: .top, endPoint: .bottom))
                        .opacity(0.7)
                }
                
                Button(action: {
                    saveEntry()
                }) {
                    Text("Save")
                        .font(.title3)
                        .foregroundColor(.primary)
                        .padding()
                }
                .padding()
                .foregroundColor(.teal)
                .bold()
                .font(.title3)
                .background(Color("1"))
            }
        }
    }
    
    private func saveEntry() {
        switch entryMode {
        case .text:
            viewModel.addDiary(text: newEntryText, handwritingData: nil)
        case .handwriting:
            viewModel.addDiary(text: newEntryText, handwritingData: drawing.dataRepresentation())
        }
        newEntryText = ""
        isPresented = false
    }
}

struct NewEntryView_Previews: PreviewProvider {
    static var previews: some View {
        NewEntryView(isPresented: .constant(false), newEntryText: .constant(""))
    }
}
