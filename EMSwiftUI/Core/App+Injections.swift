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

extension Container {
    var staticFilterAttributes: Factory<StaticFilterAttributesProtocol> {
        Factory(self) {
            StaticFilterAttributes()
        }
    }

    var filterTagsService: Factory<FilterTagsServiceProtocol> {
        Factory(self) {
            FilterTagsService(netify: self.netify())
        }
    }

    var filterScreenViewModel: Factory<FilterScreenViewModel> {
        Factory(self) {
            FilterScreenViewModel(
                service: self.filterTagsService(),
                options: self.staticFilterAttributes()
            )
        }
    }
}
