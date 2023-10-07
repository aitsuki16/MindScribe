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

extension PKStroke {
    func rainbowStroke() -> [PKStroke] {
        let rainbowColors: [UIColor] = [
            .red, .orange, .yellow, .green, .blue
        ]

        var newStrokes: [PKStroke] = []
        let segmentLength = 1.0 / CGFloat(rainbowColors.count)

        for (index, color) in rainbowColors.enumerated() {
            let start = CGFloat(index) * segmentLength
            let end = CGFloat(index + 1) * segmentLength
            
            var subpoints: [PKStrokePoint] = []
            var t = start
            while t <= end {
                let point = self.path.interpolatedPoint(at: t)
                subpoints.append(point)
                t += segmentLength / CGFloat(100) // incrementally sample 100 points between start and end
            }

            let subpath = PKStrokePath(controlPoints: subpoints, creationDate: Date())
            let newInk = PKInk(.pen, color: color)
            let newStroke = PKStroke(ink: newInk, path: subpath, transform: self.transform, mask: nil)
            newStrokes.append(newStroke)
        }

        return newStrokes
    }
}
