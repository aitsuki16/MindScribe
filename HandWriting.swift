//
//  HandWriting.swift
//  mindScribe
//
//  Created by apple on 2023/07/09.
//

import Foundation

class Stroke: NSObject, NSCoding {
    var points: [CGPoint] = []

    func encode(with coder: NSCoder) {
        coder.encode(points, forKey: "points")
    }

    required init?(coder: NSCoder) {
        points = coder.decodeObject(forKey: "points") as? [CGPoint] ?? []
    }
}

class Handwriting: NSObject, NSCoding {
    var strokes: [Stroke] = []

    func encode(with coder: NSCoder) {
        coder.encode(strokes, forKey: "strokes")
    }

    required init?(coder: NSCoder) {
        strokes = coder.decodeObject(forKey: "strokes") as? [Stroke] ?? []
    }
}
