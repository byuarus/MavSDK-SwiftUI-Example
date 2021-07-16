//
//  ConnectionView.swift
//  Mavsdk-SwiftUI-Example
//
//  Created by Dmytro Malakhov on 7/12/21.
//

import SwiftUI

struct ConnectionView: View {
    @ObservedObject var model = ConnectionViewModel()
    @ObservedObject var mavsdk = mavsdkDrone

    var body: some View {
        List {
            Section {
                Button("Stop Mavsdk server")
                {
                    mavsdk.stopServer()
                }
                .disabled(!mavsdk.serverStarted)
            }
            
            Section(header: Text("Select comm link to connect")) {
                CommLinkView(name: "Drone", uri: "udp://:14540")
                CommLinkView(name: "Cloud Sim", uri: "tcp://3.80.232.118:5790")
            }
        }
        .listStyle(GroupedListStyle())
    }
}

struct ConnectionView_Previews: PreviewProvider {
    static var previews: some View {
        ConnectionView()
    }
}