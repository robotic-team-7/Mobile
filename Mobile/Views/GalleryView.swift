//
//  GalleryView.swift
//  Mobile
//
//  Created by Filip Flodén on 2022-04-11.
//

import SwiftUI

struct GalleryView: View {
    let data = ["cat", "dog", "fox", "koala", "squirrel"]

    let columns = [
        GridItem(.flexible(), spacing: 15),
        GridItem(.flexible(), spacing: 15)
    ]
    
    var body: some View {
        ZStack {
            Color.scheme.bg
                .ignoresSafeArea()
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(data, id: \.self) { item in
                        ZStack {
                            Image(item)
                                .resizable()
                                .scaledToFill()
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .aspectRatio(1, contentMode: .fit)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.white, lineWidth: 2))
                        }
                    }
                }.padding(.horizontal)
            }
        }
    }
}

struct GalleryView_Previews: PreviewProvider {
    static var previews: some View {
        GalleryView()
    }
}
