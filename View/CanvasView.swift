//
//  CanvasView.swift
//  mindScribe
//
//  Created by user on 2023/06/21.
//

import PencilKit
import UIKit
import SwiftUI

struct CanvasView: UIViewRepresentable {
    @Binding var drawing: PKDrawing
    var tmpDrawing: PKDrawing? = nil
    @Binding var selectedTool: Tool

    func makeUIView(context: Context) -> PKCanvasView {
        let canvasView = PKCanvasView()
        canvasView.drawingPolicy = .anyInput
        
        switch selectedTool {
            case .pen:
                print("Selected Tool: Pen")
                canvasView.tool = PKInkingTool(.pen, color: .black, width: 3)
            case .pencil:
                print("Selected Tool: Pencil")
                canvasView.tool = PKInkingTool(.pencil, color: .blue, width: 3)
            case .eraser:
                print("Selected Tool: Eraser")
            canvasView.tool = PKEraserTool(.bitmap)
            }
        
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
        
        switch selectedTool {
            case .pen:
                print("Selected Tool: Pen")
                uiView.tool = PKInkingTool(.pen, color: .black, width: 3)
            case .pencil:
                print("Selected Tool: Pencil")
                uiView.tool = PKInkingTool(.pencil, color: .blue, width: 3)
            case .eraser:
                print("Selected Tool: Eraser")
                uiView.tool = PKEraserTool(.bitmap)
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
