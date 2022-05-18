//
//  ObstacleSheetView.swift
//  Mobile
//
//  Created by Filip Flodén on 2022-05-18.
//

import SwiftUI

struct ObstacleSheetView: View {
    @Binding var imagePath: String
    var imageClassification: String = "Fox"
    
    var body: some View {
        ZStack (alignment: .top) {
            Color.scheme.bg.ignoresSafeArea()
            VStack(alignment: .center) {
                AsyncImage(url: URL(string: imagePath)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .aspectRatio(1, contentMode: .fit)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.white, lineWidth: 2))
                } placeholder: {
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFill()
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .aspectRatio(1, contentMode: .fit)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.white, lineWidth: 2))
                }.padding(.horizontal, 3)
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
        ObstacleSheetView(imagePath: .constant("fox"))
    }
}
