//
//  TabView.swift
//  TestTaskByDaniaDenisuk
//
//  Created by Danya Denisiuk on 25.12.2024.
//

import SwiftUI

/// Tab bar for switching between "Users" and "Sign Up" tabs
struct TabView: View {
    @Binding var selectedTab: ContentViewTab
    
    var body: some View {
        HStack {
            Button {
                withAnimation {
                    selectedTab = .user
                }
            } label: {
                HStack {
                    Image(selectedTab == .user ? .peopleGroupButtonSelected : .peopleGroupButtonUnselected)
                        .foregroundStyle(selectedTab == .signUp ? .customBlue : .black.opacity(0.6))
                    
                    Text("Users")
                        .font(Font.custom("NunitoSans-ExtraLight", size: 16))
                        .foregroundStyle(selectedTab == .user ? .customBlue : .black.opacity(0.6))
                }
            }
            .frame(maxWidth: .infinity)
            
            Button {
                withAnimation {
                    selectedTab = .signUp
                }
            } label: {
                HStack {
                    Image(selectedTab == .signUp ? .signUpButtonSelected : .signUpButtonUnselected)
                        .foregroundStyle(selectedTab == .signUp ? .customBlue : .black.opacity(0.6))
                    
                    Text("Sign Up")
                        .font(Font.custom("NunitoSans-ExtraLight", size: 16))
                        .foregroundStyle(selectedTab == .signUp ? .customBlue : .black.opacity(0.6))
                }
            }
            .frame(maxWidth: .infinity)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 56)
        .background(.dirtyWhite)
    }
}

#Preview {
    TabView(selectedTab: .constant(.user))
}
