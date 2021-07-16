//
//  TelemetryView.swift
//  Mavsdk-SwiftUI-Example
//
//  Created by Douglas on 14/05/21.
//

import SwiftUI


struct TelemetryView: View {
    @EnvironmentObject var mavsdkDrone: MavsdkDrone
    @ObservedObject var telemetryViewModel = TelemetryViewModel()
    
    var body: some View {
        List {
            TelemetryRow(title: "Flight Mode", value: telemetryViewModel.flightMode)
            TelemetryRow(title: "Armed", value: telemetryViewModel.armed)
            TelemetryRow(title: "Location", value: telemetryViewModel.droneCoordinate)
            TelemetryRow(title: "Altitude", value: telemetryViewModel.droneAltitude)
            TelemetryRow(title: "Attitude", value: telemetryViewModel.attitudeEuler)
            TelemetryRow(title: "Camera Attitude", value: telemetryViewModel.cameraAttitudeEuler)
            TelemetryRow(title: "GPS Info", value: telemetryViewModel.gpsInfo)
            TelemetryRow(title: "Landed State", value: telemetryViewModel.landedState)
        }
        .font(.system(size: 14, weight: .medium, design: .default))
        .listStyle(PlainListStyle())
    }
}

struct TelemetryView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            TelemetryView()
                .previewLayout(.fixed(width: 896, height: 100))
        }
    }
}

struct TelemetryRow: View {
    let title: String
    let value: String
    
    var body: some View {
        HStack {
            Text(title)
            Spacer()
            Text(value)
                .foregroundColor(.gray)
        }
        .padding()
    }
}
