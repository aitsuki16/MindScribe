//
//  HandWritingView.swift
//  mindScribe
//
//  Created by user on 2023/06/17.
//

import SwiftUI
import PencilKit

struct HandWritingView: View {
    @Binding var canvasView: PKCanvasView
    @Binding var handwritingImage: UIImage?
    var body: some View {
        ZStack {
            canvasView(canvasView: $canvasView)
                .edgesIgnoringSafeArea(.all)
            if let image = handwritingImage {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
        }    }
}

struct HandWritingView_Previews: PreviewProvider {
    static var previews: some View {
        HandWritingView()
    }
}
