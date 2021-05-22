//
//  TelemetryDetailViewModel.swift
//  Mavsdk-SwiftUI-Example
//
//  Created by Douglas on 21/05/21.
//

import Foundation
import RxSwift

final class TelemetryDetailViewModel: ObservableObject {
    @Published private(set) var altitude = 0
    @Published private(set) var battery = 0
    @Published private(set) var photosTaken = 0
    
    lazy var drone = Mavsdk.sharedInstance.drone
    let disposeBag = DisposeBag()
    
    init() {
        observeDroneTelemetry()
    }
    
    func observeDroneTelemetry() {
        drone.telemetry.position
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (position) in
                self.altitude = Int(position.relativeAltitudeM)
            })
            .disposed(by: disposeBag)
        
        drone.telemetry.battery
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (info) in
                self.battery = Int(info.remainingPercent * 100)
            })
            .disposed(by: disposeBag)
        
        drone.camera.captureInfo
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (info) in
                self.photosTaken = Int(info.index)
            })
            .disposed(by: disposeBag)
    }
}
