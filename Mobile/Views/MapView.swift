//
//  MapView.swift
//  Mobile
//
//  Created by user on 2022-04-13.
//

import SwiftUI

struct MapView: View {
    @State private var lines = [Line]()
    @State private var undoLines = [Line]()
    var body: some View {
        NavigationView {
            ZStack {
                Color.scheme.bg
                VStack {
                    Canvas { context, size in
                        for line in lines {
                            let path = createPath(for: line.points)
                            context.stroke(path,
                                           with: .color(line.color),
                                           lineWidth: 4)
                        }
                    }
                    .gesture(DragGesture(minimumDistance: 0).onChanged({ value in
                        if value.translation.width + value.translation.height == 0 {
                            // length of line is zero -> new line
                            lines.append(Line(points: [CGPoint](), linewidth: 1, color: .green))
                        } else {
                            print(value.location)
                            let index = lines.count - 1
                            lines[index].points.append(value.location)
                        }
                    }))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    
                    HStack {
                        Button("Create Line", role: .destructive) {
                            lines.append(Line(points: [CGPoint(x: 150.0, y: 150.0)], linewidth: 1, color: .green))
                            lines[lines.startIndex].points.append(CGPoint(x: 300.0, y: 150.0))
                            lines[lines.startIndex].points.append(CGPoint(x: 300.0, y: 300.0))
                            lines[lines.startIndex].points.append(CGPoint(x: 150.0, y: 300.0))
                        }
                    }
                }
                .navigationTitle("Map")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
    func createPath(for line: [CGPoint]) -> Path {
        var path = Path()
        if let firstPoint = line.first {
            path.move(to:firstPoint)
        }
        if line.count > 2 {
            for index in 1..<line.count {
                let mid = calculateMidPoint(line[index - 1], line[index])
                path.addQuadCurve(to: mid, control: line[index - 1])
            }
        }
        if let last = line.last {
            path.addLine(to: last)
        }
        return path
    }
    
    func calculateMidPoint(_ point1: CGPoint, _ point2: CGPoint) -> CGPoint {
        let newMidPoint = CGPoint(x: (point1.x + point2.x)/2, y: (point1.y + point2.y)/2)
        return newMidPoint
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}
