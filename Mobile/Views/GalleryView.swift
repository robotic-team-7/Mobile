//
//  GalleryView.swift
//  Mobile
//
//  Created by Filip Flodén on 2022-04-11.
//

import SwiftUI

struct GalleryView: View {
    @EnvironmentObject private var apiManager: ApiManager
    private let columns = [
        GridItem(.flexible(), spacing: 15),
        GridItem(.flexible(), spacing: 15)
    ]
    
    let screenWidth = UIScreen.main.bounds.size.width
    @State var isSheetPresented = false
    @State var selectedImage = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.scheme.bg
                    .ignoresSafeArea()
                if (apiManager.mowingSession.isEmpty){
                    Text("No Session")
                }
                else {
                    VStack {
                        ScrollView {
                            LazyVGrid(columns: columns) {
                                ForEach(apiManager.mowingSession[0].Obstacles, id: \.self) { obstacle in
                                    ZStack {
                                        AsyncImage(url: URL(string: obstacle.imagePath)) { image in
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
                                        }
                                    }
                                    .onTapGesture {
                                        selectedImage = obstacle.imagePath
                                        isSheetPresented = true
                                    }
                                }
                            }
                            .sheet(isPresented: $isSheetPresented) {
                                ObstacleSheetView(imagePath: $selectedImage)
                            }
                        }
                    }.padding()
                }
            }
            .navigationTitle("Obstacle Gallery")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct GalleryView_Previews: PreviewProvider {
    static var previews: some View {
        GalleryView().environmentObject(ApiManager())
    }
}
