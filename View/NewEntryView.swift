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
  @EnvironmentObject private var viewModel: EntryViewModel
 
  var body: some View {
    NavigationView {
      VStack(alignment: .center) {
        Text("New Entry")
          .font(.largeTitle)
          .padding()
          Picker("Entry Mode", selection: $viewModel.entryMode) {
          Text("Text").tag(EntryMode.text)
          Text("Handwriting").tag(EntryMode.handwriting)
        }
        .pickerStyle(.navigationLink)
        .padding()
          if viewModel.entryMode == .text {
              TextEditor(text: $viewModel.newEntryText)
            .padding(10)
            .background(LinearGradient(gradient: Gradient(colors: [.teal, .indigo]), startPoint: .top, endPoint: .bottom))
            .opacity(0.7)
        } else {
            CanvasView(drawing: $viewModel.drawing)
            .frame(width: UIScreen.main.bounds.width - 40, height: 500)
            .border(Color.gray)
            .padding(10)
            .background(LinearGradient(gradient: Gradient(colors: [.red, .blue]), startPoint: .top, endPoint: .bottom))
            .opacity(0.7)
        }
        Button(action: {
            viewModel.saveEntry()
            isPresented = false
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
}

struct NewEntryView_Previews: PreviewProvider {
  static var previews: some View {
    NewEntryView(isPresented: .constant(false))
  }
}
