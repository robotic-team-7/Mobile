//
//  ControllerView.swift
//  Mobile
//
//  Created by user on 2022-04-21.
//

import SwiftUI

struct ControllerView: View {
    @ObservedObject var bleManager = BleManager()
    @State private var deviceSelected = false
    init() {
        UITableView.appearance().backgroundColor = .clear // tableview background
        UITableViewCell.appearance().backgroundColor = .clear // cell background
    }
    var body: some View {
        NavigationView {
            ZStack {
                Color.scheme.bg
                    .ignoresSafeArea()
                if bleManager.isDisconnected {
                    VStack {
                        List(bleManager.peripherals) { peripheral in Button(action: {
                            deviceSelected = true
                            bleManager.connectToPeripheral(peripheral: peripheral.object)
                            // bleManager.writeOutgoingValue(data: "MT")
                        })
                            {
                                HStack {
                                    Text(peripheral.name)
                                    Spacer()
                                    Text(String(peripheral.rssi))
                                }
                            }.listRowBackground(Color.scheme.darkBg)}
                        Spacer()
                        Text("Status")
                        if bleManager.isSwitchedOn {
                            Text("Bluetooth is switched on")
                                .foregroundColor(.green)
                        }
                        else {
                            Text("Bluetooth is switched off")
                                .foregroundColor(.red)
                        }
                        HStack {
                            Button(action: {
                                bleManager.startScanning()
                            }) {
                                Text("Scan")
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 48)
                            }
                            Button(action: {
                                bleManager.disconnectPeripheral()
                            }) {
                                Text("Disconnect")
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 48)
                            }.disabled(bleManager.isDisconnected == true)
                        }
                    }.padding()
                }
                else {
                    VStack() {
                        Spacer()
                        HStack {
                            Button(action: {
                                bleManager.writeOutgoingValue(data: "SD")
                            }) {
                                Image(systemName: "tortoise.fill")
                                    .font(.largeTitle)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 48)
                            }
                            .buttonStyle(.bordered)
                            Button(action: {
                                // bleManager.writeOutgoingValue(data: "MT")
                                bleManager.toggleMowerMode()
                            }) {
                                Image(systemName: "power")
                                    .font(.largeTitle)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 48)
                            }
                            .buttonStyle(.bordered)
                            Button(action: {
                                bleManager.writeOutgoingValue(data: "SI")
                            }) {
                                Image(systemName: "hare.fill")
                                    .font(.largeTitle)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 48)
                            }
                            .buttonStyle(.bordered)
                        }
                        Spacer()
                        HStack {
                            Spacer()
                            Button(action: {
                                bleManager.writeOutgoingValue(data: "MF")
                            }) {
                                Image(systemName: "arrowtriangle.up.fill")
                                    .font(.largeTitle)
                                    .frame(width: 48, height: 48)
                            }
                            .buttonStyle(.bordered)
                            Spacer()
                        }
                        HStack(alignment:.center) {
                            Button(action: {
                                bleManager.writeOutgoingValue(data: "ML")
                            }) {
                                Image(systemName: "arrowtriangle.left.fill")
                                    .font(.largeTitle)
                                    .frame(width: 48, height: 48)
                            }
                            .buttonStyle(.bordered)
                            Button(action: {
                                bleManager.writeOutgoingValue(data: "MS")
                            }) {
                                Image(systemName: "nosign")
                                    .font(.largeTitle)
                                    .frame(width: 48, height: 48)
                            }
                            .buttonStyle(.bordered)
                            Button(action: {
                                bleManager.writeOutgoingValue(data: "MR")
                            }) {
                                Image(systemName: "arrowtriangle.right.fill")
                                    .font(.largeTitle)
                                    .frame(width: 48, height: 48)
                            }
                            .buttonStyle(.bordered)
                        }
                        HStack {
                            Spacer()
                            Button(action: {
                                bleManager.writeOutgoingValue(data: "MB")
                            }) {
                                Image(systemName: "arrowtriangle.down.fill")
                                    .font(.largeTitle)
                                    .frame(width: 48, height: 48)
                                
                            }
                            .buttonStyle(.bordered)
                            Spacer()
                        }
                        Spacer()
                    }.padding()
                }
            }
            .navigationTitle("Bluetooth Remote")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ControllerView_Previews: PreviewProvider {
    static var previews: some View {
        ControllerView()
    }
}
