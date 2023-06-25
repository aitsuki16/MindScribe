//
//  CanvasView.swift
//  mindScribe
//
//  Created by user on 2023/06/21.
//

import SwiftUI
import PencilKit

struct CanvasView: UIViewRepresentable {
    @Binding var drawing: PKDrawing
    
    func makeUIView(context: Context) -> PKCanvasView {
        let canvasView = PKCanvasView()
        canvasView.drawing = drawing
        canvasView.drawingPolicy = .anyInput
        canvasView.tool = PKInkingTool(.pen, color: .black, width: 10)
        
        return canvasView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        uiView.drawing = drawing
    }
}
