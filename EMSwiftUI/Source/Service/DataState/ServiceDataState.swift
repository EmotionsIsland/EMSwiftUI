import Foundation

enum DataState {
    case successfull
    case failed(error: Error)
    case notAvailable
}
