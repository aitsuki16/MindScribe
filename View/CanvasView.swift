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
    var tmpDrawing: PKDrawing? = nil
    
    func makeUIView(context: Context) -> PKCanvasView {
        let canvasView = PKCanvasView()
        canvasView.drawingPolicy = .anyInput
        canvasView.tool = PKInkingTool(.pen, color: .black, width: 10)
        canvasView.delegate = context.coordinator
        return canvasView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        if let tmpDrawing = context.coordinator.tmpDrawing {
            uiView.drawing = tmpDrawing
            context.coordinator.tmpDrawing = nil
        } else {
            uiView.drawing = drawing
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, PKCanvasViewDelegate {
        var parent: CanvasView
        var tmpDrawing: PKDrawing?
        
        init(_ parent: CanvasView) {
            self.parent = parent
        }

        func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {
            Task {
                let newDrawing = canvasView.drawing
                if newDrawing != self.parent.drawing {
                    self.parent.drawing = newDrawing
                }
            }
        }

        func canvasViewDidEndUsingTool(_ canvasView: PKCanvasView) {
            
        }
    }
}
