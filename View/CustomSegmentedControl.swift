//
//  CustomSegmentedControl.swift
//  mindScribe
//
//  Created by user on 2023/07/19.
//

import SwiftUI

struct CustomSegmentedControl: View {
    @Binding var selection: EntryMode

    var body: some View {
            HStack {
                Button(action: {
                    withAnimation {
                        selection = .text
                    }
                }) {
                    Text("Text")
                        .padding(2)
                        .frame(maxWidth: .infinity)
                        .background(selection == .text ? Color.indigo : Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .buttonStyle(PlainButtonStyle())
                .gesture(
                    TapGesture()
                        .onEnded {
                            withAnimation {
                                selection = .text
                            }
                        })
                Button(action: {
                    withAnimation {
                        selection = .handwriting
                    }
                }) {
                    Text("Handwriting")
                        .padding(2)
                        .frame(maxWidth: .infinity)
                        .background(selection == .handwriting ? Color.indigo : Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .buttonStyle(PlainButtonStyle())
                .gesture(
                    TapGesture()
                        .onEnded {
                            withAnimation {
                                selection = .handwriting
                            }
                        })
        }
            
    //}
        .pickerStyle(SegmentedPickerStyle())
        .background(Color.white)
        .cornerRadius(8)
        .padding()
    }
}


//struct CustomSegmentedControl_Previews: PreviewProvider {
//    static var previews: some View {
//        CustomSegmentedControl()
//    }
//}
