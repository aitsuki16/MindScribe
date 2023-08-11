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

    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                Text("New Entry")
                    .font(.largeTitle)
                    .foregroundColor(.cyan)
                    .padding()

                CustomSegmentedControl(selection: $viewModel.entryMode)

                if viewModel.entryMode == .text {
                    TextEditor(text: $viewModel.newEntryText)
                        .frame(width: UIScreen.main.bounds.width - 40, height: 250)

                        .padding(10)
                        .background(LinearGradient(gradient: Gradient(colors: [.cyan, .indigo]), startPoint: .top, endPoint: .bottom))
                        .opacity(0.8)
                } else {
                    CanvasView(drawing: $viewModel.drawing)
                        .frame(width: UIScreen.main.bounds.width - 40, height: 500)
                        .padding(10)
                        .background(LinearGradient(gradient: Gradient(colors: [.indigo, .cyan]), startPoint: .top, endPoint: .bottom))
                        .opacity(0.7)
                }

                Button(action: {
                    viewModel.saveEntry()
                    isPresented = false
                }) {
                    Text("Save")
                        .font(.title3)
                        .foregroundColor(.indigo)
                }
                .tint(Color("1"))
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.roundedRectangle)
                .controlSize(.regular)
            }
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
