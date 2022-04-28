//
//  BlePeripheral.swift
//  Mobile
//
//  Created by user on 2022-04-28.
//

import Foundation
import CoreBluetooth

class BlePeripheral {
    static var connectedPeripheral: CBPeripheral?
    static var connectedService: CBService?
    static var connectedTXChar: CBCharacteristic?
    static var connectedRXChar: CBCharacteristic?
}
