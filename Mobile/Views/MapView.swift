//
//  MapView.swift
//  Mobile
//
//  Created by user on 2022-04-13.
//

import SwiftUI

struct MapView: View {
    @State private var mowerPath = [Line]()
    @State private var mowerPosition = CGPoint()
    @State private var obstacles = [CGPoint]()
    let timer = Timer.publish(every: 10, on: .main, in: .common).autoconnect()
    @EnvironmentObject private var appSettings: AppSettings
    @EnvironmentObject private var apiManager: ApiManager
    var body: some View {
        NavigationView {
            ZStack {
                Color.scheme.bg
                ZStack {
                    Canvas { context, size in
                        for line in mowerPath {
                            let path = createPath(for: line.points)
                            context.stroke(path,
                                           with: .color(line.color),
                                           style: StrokeStyle(lineWidth: line.linewidth, dash: [line.dash]))
                        }
                    }.onAppear {
                        mowerPath.append(Line(points: [CGPoint](), linewidth: 5, dash: 5, color: .black))
                    }
                    .onReceive(timer) { input in
                        apiManager.getMowingSession(sessionId: appSettings.selectedSessionId!)
                        for mowerPosition in apiManager.mowingSession[0].mowerPositions.points {
                            mowerPath[0].points.append(CGPoint(x: mowerPosition[0], y: mowerPosition[1]))
                        }
                        mowerPosition = CGPoint(x: apiManager.mowingSession[0].mowerPositions.points.last!.first ?? 0, y: apiManager.mowingSession[0].mowerPositions.points.last!.last ?? 0)
                        for obstacle in apiManager.mowingSession[0].Obstacles {
                            print(obstacle)
                        }
                    }
                    .background(Image("grasslight-big").resizable().aspectRatio(contentMode: .fill))
                    .cornerRadius(25)
                    .overlay(RoundedRectangle(cornerRadius: 25).stroke(Color.white, lineWidth: 2))
                    .padding()
                    Image(systemName: "mappin.and.ellipse")
                        .position(mowerPosition)
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

