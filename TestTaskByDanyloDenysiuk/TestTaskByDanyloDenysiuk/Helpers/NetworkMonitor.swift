
import Foundation
import Network
import SwiftUI

@Observable
final class NetworkMonitor {
    var isConnected = false
    
    private let networkMonitor: NWPathMonitor = NWPathMonitor()
    private let networkQueue = DispatchQueue(label: "com.NetworkMonitor.networkQueue")
    
    init() {
        networkMonitor.pathUpdateHandler = { path in
            withAnimation {
                self.isConnected = path.status == .satisfied
            }
        }
        networkMonitor.start(queue: networkQueue)
    }
}
