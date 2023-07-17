//
//  CanvasView.swift
//  mindScribe
//
//  Created by user on 2023/06/21.
//

import SwiftUI
import PencilKit
import UIKit

struct CanvasView: UIViewRepresentable {
    @Binding var drawing: PKDrawing
    
    func makeUIView(context: Context) -> PKCanvasView {
        let canvasView = PKCanvasView()
        canvasView.drawingPolicy = .anyInput
        canvasView.tool = PKInkingTool(.pen, color: .black, width: 10)
        canvasView.delegate = context.coordinator
        return canvasView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        uiView.drawing = drawing
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, PKCanvasViewDelegate {
        var parent: CanvasView
        
        init(_ parent: CanvasView) {
            self.parent = parent
        }
        
        func canvasViewDidEndUsingTool(_ canvasView: PKCanvasView) {
            parent.drawing = canvasView.drawing
            print("Drawing ended with data size: \(canvasView.drawing.dataRepresentation().count)")
        }
    }
}
