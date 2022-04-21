//
//  HomeView.swift
//  Mobile
//
//  Created by user on 2022-04-04.
//

import SwiftUI

struct DashboardView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color.scheme.bg
                ScrollView {
                    HStack {
                        DashItem(title: "Status", text: "Running", image: "togglepower", progress: nil)
                        DashItem(title: "Battery", text: "20%", image: "bolt.square.fill",  progress: 20)
                    }.fixedSize(horizontal: false, vertical: true)
                    HStack {
                        DashItem(title: "Obstacles", text: "25 avoided", image: nil,  progress: nil)
                        DashItem(title: "Collissions", text: "3 detected", image: nil, progress: nil)
                    }.fixedSize(horizontal: false, vertical: true)
                    HStack {
                        VStack (alignment: .leading) {
                            Text("Power")
                                .font(.title3.bold())
                            Spacer()
                            Toggle(isOn: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Is On@*/.constant(true)/*@END_MENU_TOKEN@*/){}
                                .labelsHidden()
                                .frame(maxWidth: .infinity, alignment: .center)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                        .padding(10)
                        .background(Color.scheme.darkBg)
                        .cornerRadius(/*@START_MENU_TOKEN@*/5.0/*@END_MENU_TOKEN@*/)
                        DashItem(title: "Time running", text: "50 minutes", image: nil, progress: nil)
                    }.fixedSize(horizontal: false, vertical: true)
                }.padding(10)
                
                
            }
            .navigationTitle("Dashboard")
            .navigationBarTitleDisplayMode(.inline)
            
            
        }
    }
    // builder for reusable status item.
    @ViewBuilder
    func DashItem(title: String, text: String, image: String?, progress: CGFloat?)->some View {
        VStack (alignment: .leading) {
            Text(title)
                .font(.title3.bold())
            Spacer()
            HStack(alignment: .bottom) {
                Text(text)
                    .font(.caption2.bold())
                    .foregroundColor(.gray)
                
                Spacer()
                Image(systemName: image ?? "")
                    .frame(width: 32, height: 32)
                    .font(.title2)
                    .background(
                        ZStack {
                            if (progress != nil) {
                                Circle()
                                    .stroke(Color.scheme.darkerFg, lineWidth: 2)
                                Circle()
                                    .trim(from: 0, to: progress! / 100)
                                    .stroke(Color.scheme.fg, lineWidth: 2)
                            }
                        }
                    )
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .padding(10)
        .background(Color.scheme.darkBg)
        .cornerRadius(/*@START_MENU_TOKEN@*/5.0/*@END_MENU_TOKEN@*/)
    }
    struct DashboardView_Previews: PreviewProvider {
        static var previews: some View {
            DashboardView()
        }
    }
}

//        HStack {
//            if image != nil {
//                Image(systemName: image!)
//                    .font(.title2)
//                    .foregroundColor(color)
//                    .padding(10)
//                    .background(
//                        ZStack {
//                            if progress != nil {
//                                Circle()
//                                    .stroke(Color.gray.opacity(0.3), lineWidth: 2)
//
//                                Circle()
//                                    .trim(from: 0, to: progress! / 100)
//                                    .stroke(color.opacity(progress! / 100), lineWidth: 2)
//                            }
//                        }
//
//                    )
//            }
//            VStack(alignment: .leading) {
//                Text("\(Int(progress!))")
//                    .font(.title2.bold())
//
//                Text(title)
//                    .font(.caption2.bold())
//                    .foregroundColor(.gray)
//            }
//        }
//        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
//        .padding(5)
//        .background(Color.scheme.darkBg)
//        .cornerRadius(/*@START_MENU_TOKEN@*/5.0/*@END_MENU_TOKEN@*/)
//
//    }



//
//  HomeView.swift
//  Mobile
//
//  Created by user on 2022-04-04.
//
//
//import SwiftUI
//
//struct DashboardView: View {
//    var body: some View {
//        NavigationView {
//            ZStack {
//                Color.scheme.bg
//                ScrollView {
//                    HStack {
//                        DashItem(title: "Status", image: "", text: "Running", showProgress: false)
//                        DashItem(title: "Battery", image: "bolt.square.fill", text: "20", showProgress: true)
//                    }.fixedSize(horizontal: false, vertical: true)
//                    HStack {
//                        DashItem(title: "Obstacles Avoided", image: "", text: "25", showProgress: false)
//                        DashItem(title: "Collissions", image: "hare.fill", text: "25", showProgress: false)
//                    }.fixedSize(horizontal: false, vertical: true)
//                    HStack {
//                        DashItem(title: "Remaining", image: "", text: "25m", showProgress: false)
//                        DashItem(title: "Status", image: "clock.badge.checkmark", text: "80", showProgress: true)
//                        // DashItem(title: "Power", image: "togglepower", text: "60", showProgress: true)
//                    }.fixedSize(horizontal: false, vertical: true)
//                    HStack {
//                        DashItem(title: "Remaining", image: "clock.fill", text: "50", showProgress: true)
//                        DashItem(title: "Power", image: "togglepower", text: "60", showProgress: true)
//                    }.fixedSize(horizontal: false, vertical: true)
//
////                    LazyVGrid(columns: [.init(), .init()]) {
////                        DashItem(title: "New Order", color: Color("chartColor2"), image: "cart.badge.plus", progress: 68)
////                        DashItem(title: "Order Completed", color: Color("roundColor"), image: "clock.badge.checkmark", progress: 72)
////                        DashItem(title: "New Order", color: Color("chartColor2"), image: "cart.badge.plus", progress: 68)
////                        DashItem(title: "Order Completed", color: Color("roundColor"), image: "clock.badge.checkmark", progress: 72)
////                        GroupBox(label: Label("", systemImage: "bolt.batteryblock").multilineTextAlignment(.center)
////                            .foregroundColor(.red)) {
////                                VStack {
////                                    ProgressView(value: /*@START_MENU_TOKEN@*/0.5/*@END_MENU_TOKEN@*/)
////                                }
////
////                            }
////                        GroupBox(label: Label("", systemImage: "power").multilineTextAlignment(.center)
////                            .foregroundColor(.red)) {
////                                VStack {
////                                    Toggle(isOn: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Is On@*/.constant(true)/*@END_MENU_TOKEN@*/){}
////                                        .labelsHidden()
////                                }
////                            }
////                    }
//
//                }.padding()
//
//            }
//            .navigationTitle("Dashboard")
//            .navigationBarTitleDisplayMode(.inline)
//
//
//        }
//    }
//
// MARK: USER PROGRESS VIEW
//    @ViewBuilder
//    func DashItem(title: String, color: Color?, image: String?, text: String?, progress: CGFloat?)->some View {
//        VStack (alignment: .leading) {
//                Text(title)
//                    .font(.title3.bold())
//        HStack(alignment: .bottom) {
//            Text(text)
//                .font(.caption2.bold())
//                .foregroundColor(.gray)
//
//            Spacer()
//            if !image.isEmpty {
//                Image(systemName: image)
//                    .font(.title2)
//                    .foregroundColor(color)
//                    .padding(6)
//                    .background(
//                        ZStack {
//                            if (progress != nil) {
//                            Circle()
//                                .stroke(Color.gray.opacity(0.3), lineWidth: 2)
//                            Circle()
//                                .trim(from: 0, to: progress / 100)
//                                .stroke(color.opacity(1), lineWidth: 2)
//                            }
//                        }
//                    )
//            }
//        }
//            }
//        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
//        .padding(5)
//        .background(Color.scheme.darkBg)
//        .cornerRadius(/*@START_MENU_TOKEN@*/5.0/*@END_MENU_TOKEN@*/)
//
//    }
//}
