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
  @State private var pickerIndex = 0

 
  var body: some View {
    NavigationView {
      VStack(alignment: .center) {
        Text("New Entry")
          .font(.largeTitle)
          .padding()
          Picker("", selection: $pickerIndex) {
              Text("Text").tag(0)
              Text("Handwriting").tag(1)
          }
          .pickerStyle(SegmentedPickerStyle())
          .background(Color.blue)
          .cornerRadius(8)
          .padding()
          .gesture(
              TapGesture()
                  .onEnded {
                      pickerIndex = (pickerIndex + 1) % 2
                  }
          )

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
                .foregroundColor(.gray)
        }
        .tint(Color("1"))
        .buttonStyle(.borderedProminent)
        .buttonBorderShape(.roundedRectangle)
        .controlSize(.regular)
      }
    }
  }
}

struct NewEntryView_Previews: PreviewProvider {
  static var previews: some View {
    NewEntryView(isPresented: .constant(false))
  }
}
