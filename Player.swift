//
//  Player.swift
//  MyQuizApp
//
//  Created by Ognjen Milovanovic on 04.08.20.
//  Copyright © 2020 Ognjen Milivanovic. All rights reserved.
//

import Foundation
import MultipeerConnectivity

class Player: NSObject {
    var name: String = "Anynomous"
    var peerId: MCPeerID?
    
    init(name: String, peerId: MCPeerID?) {
        self.name = name
        self.peerId = peerId
    }
    
    func getInfoForService() -> [String: String] {
        return ["name": name]
    }
}
