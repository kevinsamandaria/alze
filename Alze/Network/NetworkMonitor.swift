//
//  NetworkMonitor.swift
//  Alze
//
//  Created by Chrismanto Natanail Manik on 24/06/22.
//

import Foundation
import Network
import SwiftUI

final class NetworkMonitor: ObservableObject{
    let monitor = NWPathMonitor()
    let queue = DispatchQueue(label: "Monitor")
    @Published var isConnect = false
    
    init(){
        monitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                self.isConnect = path.status == .satisfied ? true : false
            }
            
        }
        monitor.start(queue: queue)
    }
    
}

