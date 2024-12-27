//
//  NoConnectionView.swift
//  TestTaskByDaniaDenisuk
//
//  Created by Danya Denisiuk on 25.12.2024.
//

import SwiftUI

/// View displayed when there is no internet connection
struct NoConnectionView: View {
    var action: () -> Void
    
    var body: some View {
        VStack(spacing: 30) {
            Image(.noneConnection) // Image for no connection
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
            
            Text("There is no internet connection")
                .font(Font.custom("NunitoSans-ExtraLight", size: 20))
            
            Button {
                action()
            } label: {
                Text("Try again")
                    .font(Font.custom("NunitoSans-ExtraLight", size: 20))
                    .foregroundStyle(.black)
            }
            .padding()
            .frame(width: 140, height: 48)
            .background {
                RoundedRectangle(cornerRadius: 24)
                    .fill(.customYellow)
            }
        }
    }
}
