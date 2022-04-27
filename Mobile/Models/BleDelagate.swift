//
//  SceneDelegate.swift
//  Mobile
//
//  Created by user on 2022-04-27.
//

import UIKit
import SwiftUI
import CoreBluetooth

class BleDelegate: NSObject, ObservableObject, CBCentralManagerDelegate, CBPeripheralDelegate {
    // CB Properties
    private var cbCentralManager: CBCentralManager!
    @Published var cbPeripheral: CBPeripheral!
    private var cbCharacteristic: CBCharacteristic!
    //private var bleData: BleData!
    public var serviceUUID = CBUUID.init(string: "8d73daf8-208b-432d-bb8f-631e11a37a56")
    public var characteristicUUID = CBUUID.init(string: "88e7e723-b754-4394-9ef5-a6b121e8dfce")
    
    @Published var connected: Bool = false
    @Published var command: Int = 0
    
    
    func sendCommand(command: UInt8) {
        cbCentralManager = CBCentralManager(delegate: self, queue: nil)
        cbPeripheral.writeValue(Data([command]), for: self.cbCharacteristic, type: .withResponse)
        // sendCommand(command)
    }
    

    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        print("CB central manager's state was updated")
        guard central.state == .poweredOn else {
            print("CB central manager is powered off")
            return
        }
        print("CB central manager is scanning for", serviceUUID)
        cbCentralManager.scanForPeripherals(withServices: [serviceUUID], options: nil)
    }
    
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String: Any], rssi RSSI: NSNumber) {

        print("centralManager  didDiscover", peripheral)
        self.cbCentralManager.stopScan()
        // Copy the peripheral instance
        self.cbPeripheral = peripheral
        self.cbPeripheral.delegate = self
        
        // Connect!
        self.cbCentralManager.connect(self.cbPeripheral, options: nil)
    }
    
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        guard peripheral == self.cbPeripheral else {
            print("Connected to a different peripheral than the intended one")
            return
        }
        print("Connected to the intended peripheral")
        //bleData.mowerName = peripheral.name!
        //bleData.connected = true
        connected = true
        peripheral.discoverServices([serviceUUID])
    }
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        if let services = peripheral.services {
            for service in services {
                if service.uuid == serviceUUID {
                    print("The service of BluetoothPeripheral found")
                    peripheral.discoverCharacteristics([
                        characteristicUUID
                    ], for: service)
                    return
                }
            }
        }
    }

    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        if let characteristics = service.characteristics {
            for characteristic in characteristics {
                if characteristic.uuid == characteristicUUID {
                    print("The characteristic found: ", characteristic)
                    cbCharacteristic = characteristic
                }
            }
        }
    }
}


class BlePeripheralDelegate: NSObject, CBPeripheralDelegate {
    
}
