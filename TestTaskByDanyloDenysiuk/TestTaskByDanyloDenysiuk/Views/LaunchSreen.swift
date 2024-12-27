//
//  LaunchScreen.swift
//  TestTaskByDaniaDenisuk
//
//  Created by Danya Denisiuk on 25.12.2024.
//

import SwiftUI

/// Launch screen displayed during initial loading
struct LaunchSreen: View {
    var body: some View {
        ZStack {
            Color
                .customYellow
                .ignoresSafeArea()
            
            Image(.logo)
                .resizable()
                .scaledToFit()
                .frame(width: 160, height: 106.46)
        }
    }
}
