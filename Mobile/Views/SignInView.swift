//
//  SignInView.swift
//  Mobile
//
//  Created by Filip Flodén on 2022-04-28.
//

import SwiftUI

struct SignInView: View {
    @State var username: String = ""
    @State var password: String = ""
    
    let screenHeight = UIScreen.main.bounds.size.height
    let screenWidth = UIScreen.main.bounds.size.width
    
    var body: some View {
        ZStack {
            Color.scheme.bg.ignoresSafeArea()
            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .fill(Color.scheme.darkBg)
                VStack() {
                    Text("Sign In")
                        .foregroundColor(Color.scheme.fg)
                        .font(.title)
                    
                    VStack {
                        HStack {
                            Image(systemName: "person")
                                .foregroundColor(Color.scheme.fg.opacity(0.5))
                            ZStack(alignment: .leading) {
                                if username.isEmpty {
                                    Text("Username").foregroundColor(Color.scheme.fg.opacity(0.5))
                                }
                                TextField("", text: $username)
                                    .foregroundColor(Color.scheme.fg)
                                    .tint(.white)
                            }
                        }
                        Divider().background(Color.scheme.fg)
                    }
                    .padding(.horizontal)
                    .padding(.top, 20)
                    
                    VStack {
                        HStack {
                            Image(systemName: "lock")
                                .foregroundColor(Color.scheme.fg.opacity(0.5))
                            ZStack(alignment: .leading) {
                                if password.isEmpty {
                                    Text("Password").foregroundColor(Color.scheme.fg.opacity(0.5))
                                }
                                SecureField("", text: $password)
                                    .foregroundColor(Color.scheme.fg)
                                    .tint(.white)
                            }
                        }
                        Divider().background(Color.scheme.fg)
                    }
                    .padding(.horizontal)
                    .padding(.top, 20)
                    Spacer()
                    Button(action: {
                        API().signIn(username: username, password: password)
                        print("Attempt login")
                    }) {
                        Text("LOGIN")
                            .foregroundColor(Color.scheme.fg)
                            .fontWeight(.bold)
                            .padding(.vertical)
                            .padding(.horizontal, 50)
                            .background(Color.scheme.bg)
                            .clipShape(RoundedRectangle(cornerRadius: 25))
                            .shadow(color: Color.white.opacity(0.05), radius: 5, x: 0, y: 5)
                    }
                    .disabled(false)
                    .padding(.bottom)
                }
                .padding(.horizontal)
                .padding(.top, 80)
            }
            .padding(.horizontal)
            .padding(.vertical, screenHeight * 0.15)
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView().preferredColorScheme(.dark)
    }
}
