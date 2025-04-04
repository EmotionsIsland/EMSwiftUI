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
