//
//  GalleryView.swift
//  Mobile
//
//  Created by Filip Flodén on 2022-04-11.
//

import SwiftUI

struct GalleryView: View {
    private let data = ["cat", "dog", "fox", "koala", "squirrel"]
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
                                    .onTapGesture {
                                        selectedImage = item
                                        isSheetPresented = true
                                    }
                                }
                            }
                            .sheet(isPresented: $isSheetPresented) {
                                ObstacleSheetView(imageName: $selectedImage)
                            }
                        }.padding()
                        Button(action: {
                            print("Clear gallery")
                        }) {
                            Text("Clear")
                                .frame(maxWidth: screenWidth * 0.5)
                                .frame(height: 48)
                        }
                        .buttonStyle(.bordered)
                        .disabled(false)
                    }.padding(.horizontal)
                }
            }
            .navigationTitle("Obstacle Gallery")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct GalleryView_Previews: PreviewProvider {
    static var previews: some View {
        GalleryView()
    }
}
