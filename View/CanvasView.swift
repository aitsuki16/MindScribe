import PencilKit
import UIKit
import SwiftUI

struct CanvasView: UIViewRepresentable {
    @Binding var drawing: PKDrawing
    var tmpDrawing: PKDrawing? = nil
    @Binding var selectedTool: Tool
    @Binding var toolColor: Color // pen color selection


    func makeUIView(context: Context) -> PKCanvasView {
        let canvasView = PKCanvasView()
        canvasView.drawingPolicy = .anyInput
        
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
                print("Selected Tool: Pen from updateui")
                let uiColor = UIColor(toolColor)
                uiView.tool = PKInkingTool(.pen, color: uiColor, width: 3)
            case .pencil:
                let uiColor = UIColor(toolColor)
            print("Selected Tool: Pencil from update ui")
                uiView.tool = PKInkingTool(.pencil, color: uiColor, width: 3)
            case .eraser:
                print("Selected Tool: Eraser from update ui")
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
