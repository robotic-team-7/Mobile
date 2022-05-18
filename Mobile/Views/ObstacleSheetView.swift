//
//  ObstacleSheetView.swift
//  Mobile
//
//  Created by Filip Flodén on 2022-05-18.
//

import SwiftUI

struct ObstacleSheetView: View {
    @Binding var imageName: String
    var imageClassification: String = "Fox"
    
    var body: some View {
        ZStack (alignment: .top) {
            Color.scheme.bg.ignoresSafeArea()
            VStack(alignment: .center) {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .aspectRatio(1, contentMode: .fit)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.white, lineWidth: 2))
                
                VStack {
                    Text("Image classification:")
                        .font(.title2)
                    Divider().background(Color.scheme.fg)
                    Text(imageClassification)
                        .font(.title2)
                }
                .foregroundColor(Color.scheme.fg)
                .padding()
            }
            .padding(.vertical)
        }
    }
}

struct ObstacleSheetView_Previews: PreviewProvider {
    static var previews: some View {
        ObstacleSheetView(imageName: .constant("fox"))
    }
}
