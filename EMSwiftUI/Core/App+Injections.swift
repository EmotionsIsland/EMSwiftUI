//
//  App+Injections.swift
//  EMSwiftUI
//
//  Created by Akbar Umetov on 17/3/25.
//

import Factory
import Logify
import Netify

extension Container {
    var netify: Factory<Netify> {
        Factory(self) { NetifyImpl(session: .shared, log: self.logify()) }
    }
    
    var logify: Factory<Logify> {
        Factory(self) { LogifyImpl(logLevel: .debug) }
    }
}
