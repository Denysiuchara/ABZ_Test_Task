//
//  StatusRegistrationView.swift
//  TestTaskByDaniaDenisuk
//
//  Created by Danya Denisiuk on 25.12.2024.
//

import SwiftUI

struct StatusRegistrationView: View {
    @Environment(\.dismiss) var dismiss
    let postUserResponse: PostUserResponse
    let action: (() -> Void)
    
    init(postUserResponse: PostUserResponse, action: @escaping () -> Void) {
        self.postUserResponse = postUserResponse
        self.action = action
    }
    
    var body: some View {
        VStack(spacing: 40) {
            Image(postUserResponse.success ? .success : .failure)
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
            
            Text(postUserResponse.message)
                .font(Font.custom("NunitoSans-ExtraLight", size: 22))
            
            Button {
                action()
                dismiss()
            } label: {
                Text(postUserResponse.success ? "Got it" : "Try again")
                    .font(Font.custom("NunitoSans-Light", size: 18))
                    .foregroundStyle(.black)
            }
            .frame(width: 140, height: 48)
            .background {
                RoundedRectangle(cornerRadius: 24)
                    .fill(.customYellow)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .safeAreaInset(edge: .top, alignment: .trailing) {
            Button {
                dismiss()
            } label: {
                Image(.close)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
            }
            .padding(30)
        }
    }
}
