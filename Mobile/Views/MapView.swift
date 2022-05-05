//
//  MapView.swift
//  Mobile
//
//  Created by user on 2022-04-13.
//

import SwiftUI

struct MapView: View {
    @State private var lines = [Line]()
    @State private var mower = CGPoint()
    @State private var obstacles = [CGPoint]()
    @State private var undoLines = [Line]()
    var body: some View {
        NavigationView {
            ZStack {
                Color.scheme.bg
                ZStack {
                    Canvas { context, size in
                        for line in lines {
                            let path = createPath(for: line.points)
                            context.stroke(path,
                                           with: .color(line.color),
                                           style: StrokeStyle(lineWidth: line.linewidth, dash: [line.dash]))
                        }
                    }
                    .gesture(DragGesture(minimumDistance: 0).onChanged({ value in
                        print(value.location)
                        mower = value.location
                        obstacles.append(value.location)
                        if lines.isEmpty {
                            lines.append(Line(points: [CGPoint](), linewidth: 5, dash: 5, color: .black))
                        }
                        let index = lines.count - 1
                        lines[index].points.append(value.location)
//                        if value.translation.width + value.translation.height == 0 {
//                            // length of line is zero -> new line
//                            lines.append(Line(points: [CGPoint](), linewidth: 1, color: .black))
//                        } else {
//                            print(value.location)
//                            let index = lines.count - 1
//                            lines[index].points.append(value.location)
//                        }
                    }))
                    .background(Image("grasslight-big").resizable().aspectRatio(contentMode: .fill))
                    .cornerRadius(25)
                    .overlay(RoundedRectangle(cornerRadius: 25).stroke(Color.white, lineWidth: 2))
                    .padding()
                    Image(systemName: "mappin.and.ellipse")
                        //.frame(alignment: .topLeading)
                        .position(mower)
                        .font(.title2)
                        .padding()
                    ForEach(obstacles.indices, id: \.self) { index in
                        Image(systemName: "exclamationmark.triangle.fill").position(obstacles[index])/// use each element in the array
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

struct Line: Identifiable {
    var points: [CGPoint]
    var linewidth: CGFloat
    var dash: CGFloat
    var color: Color
    let id = UUID()
}

