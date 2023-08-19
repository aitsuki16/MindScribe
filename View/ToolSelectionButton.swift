//
//  ToolSelectionButton.swift
//  mindScribe
//
//  Created by user on 2023/08/19.
//

import SwiftUI

struct ToolSelectionButton: View {
    var tool: Tool
    @Binding var selectedTool: Tool
    
    var body: some View {
        Button(action: {
            withAnimation {
                selectedTool = tool
            }
        }) {
            Text(toolText(for: tool))
                .frame(maxWidth: .infinity)
                .background(selectedTool == tool ? Color.cyan : Color.gray)
                .foregroundColor(.white)
                .cornerRadius(8)
        }
        .padding()
    }
    
    private func toolText(for tool: Tool) -> String {
        switch tool {
            case .pen: return "Pen"
            case .pencil: return "Pencil"
            case .eraser: return "Eraser"
        }
    }
}

