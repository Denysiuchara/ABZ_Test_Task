//
//  TestTaskByDanyloDenysiukApp.swift
//  TestTaskByDanyloDenysiuk
//
//  Created by Danya Denisiuk on 25.12.2024.
//

import SwiftUI

@main
struct TestTaskByDanyloDenysiukApp: App {
    @State private var networkMonitor = NetworkMonitor()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(networkMonitor)
                .preferredColorScheme(.light)
                .ignoresSafeArea(.keyboard)
                .onTapGesture {
                    UIApplication
                        .shared
                        .sendAction(
                            #selector(UIResponder.resignFirstResponder),
                            to: nil,
                            from: nil,
                            for: nil
                        )
                }
        }
    }
}

