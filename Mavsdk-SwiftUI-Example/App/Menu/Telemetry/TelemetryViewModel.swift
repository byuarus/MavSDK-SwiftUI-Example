//
//  TelemetryViewModel.swift
//  Mavsdk-SwiftUI-Example
//
//  Created by Douglas on 14/05/21.
//

import Foundation
import RxSwift
import Mavsdk

final class TelemetryViewModel: ObservableObject {
    @Published private(set) var flightMode = "N/A"
    @Published private(set) var armed = "N/A"
    @Published private(set) var droneCoordinate = "N/A"
    @Published private(set) var droneAltitude = "N/A"
    @Published private(set) var attitudeEuler = "N/A"
    @Published private(set) var cameraAttitudeEuler = "N/A"
    @Published private(set) var battery = "N/A"
    @Published private(set) var gpsInfo = "N/A"
    @Published private(set) var health = "N/A"
    @Published private(set) var landedState = "N/A"
    
    
    lazy var drone = mavsdkDrone.drone
    let disposeBag = DisposeBag()
    
    init() {
        observeDroneTelemetry()
    }
    
    func observeDroneTelemetry() {
        drone!.telemetry.flightMode
            .subscribeOn(MavScheduler)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (mode) in
                self.flightMode = mode.toString()
            })
            .disposed(by: disposeBag)
        
        drone!.telemetry.armed
            .subscribeOn(MavScheduler)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (armed) in
                self.armed = armed ? "Armed" : "Not armed"
            })
            .disposed(by: disposeBag)
        
        drone!.telemetry.position
            .subscribeOn(MavScheduler)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (position) in
                self.droneCoordinate = String(format: "lat:%.8f\n long:%.8f", position.latitudeDeg, position.longitudeDeg)
                self.droneAltitude = String(format: "absolute:%.2f\n relative:%.2f", position.absoluteAltitudeM, position.relativeAltitudeM)
            })
            .disposed(by: disposeBag)
        
        drone!.telemetry.attitudeEuler
            .subscribeOn(MavScheduler)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (attitudeEuler) in
                self.attitudeEuler = String(format: "pitchDeg:%.2f\n yawDeg:%.2f", attitudeEuler.pitchDeg, attitudeEuler.yawDeg)
            })
            .disposed(by: disposeBag)
        
        drone!.telemetry.cameraAttitudeEuler
            .subscribeOn(MavScheduler)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (cameraAttitudeEuler) in
                self.attitudeEuler = String(format: "pitchDeg:%.2f\n yawDeg:%.2f", cameraAttitudeEuler.pitchDeg, cameraAttitudeEuler.yawDeg)
            })
            .disposed(by: disposeBag)
        
        drone!.telemetry.battery
            .subscribeOn(MavScheduler)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (battery) in
                self.battery = String(format: "remainingPercent:%.2f", battery.remainingPercent)
            })
            .disposed(by: disposeBag)
        
        drone!.telemetry.gpsInfo
            .subscribeOn(MavScheduler)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (gpsInfo) in
                self.gpsInfo = String(format: "remainingPercent:%@\nnumSatellites:%d", String(describing: gpsInfo.fixType), gpsInfo.numSatellites)
            })
            .disposed(by: disposeBag)
        
        drone!.telemetry.healthAllOk
            .subscribeOn(MavScheduler)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (healthAllOk) in
                self.health = healthAllOk ? "Ok" : "Not OK"
            })
            .disposed(by: disposeBag)
        
        drone!.telemetry.landedState
            .subscribeOn(MavScheduler)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (landedState) in
                self.landedState = String(describing: landedState)
            })
            .disposed(by: disposeBag)
    }
}

extension Telemetry.FlightMode {
    func toString() -> String {
        var modeString = ""
        switch self {
        case .unknown:
            modeString = "Unknown"
        case .ready:
            modeString = "Ready"
        case .takeoff:
            modeString = "Take Off"
        case .hold:
            modeString = "Hold"
        case .mission:
            modeString = "Mission"
        case .returnToLaunch:
            modeString = "RTL"
        case .land:
            modeString = "Land"
        case .offboard:
            modeString = "Offboard"
        case .followMe:
            modeString = "Follow Me"
        case .UNRECOGNIZED(_):
            modeString = "Unrecognized"
        case .manual:
            modeString = "Manual"
        case .altctl:
            modeString = "Altitude Control"
        case .posctl:
            modeString = "Position Control"
        case .acro:
            modeString = "Acro"
        case .stabilized:
            modeString = "Stabilized"
        case .rattitude:
            modeString = "Rattitude"
        }
        
        return modeString
    }
}
