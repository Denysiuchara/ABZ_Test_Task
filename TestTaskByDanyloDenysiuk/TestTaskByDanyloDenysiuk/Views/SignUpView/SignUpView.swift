//
//  SignUpView.swift
//  TestTaskByDaniaDenisuk
//
//  Created by Danya Denisiuk on 25.12.2024.
//


import SwiftUI
import PhotosUI

struct SignUpView: View {
    // ViewModel to handle the sign-up logic
    @ObservedObject var viewModel: SignUpViewModel
    @State private var showStatusRegistration = false // Controls the visibility of the registration status view
    @State private var showActionSheet = false // Controls the visibility of the photo source selection
    @State private var showImagePicker = false // Controls the visibility of the image picker
    @State private var showCameraPicker = false // Controls the visibility of the camera picker
    
    private let vStackSpacing: CGFloat = 35
    
    init(viewModel: SignUpViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: vStackSpacing) {
                TextFields // User input fields for sign-up
                PositionList // List of selectable user positions
                UploadView // UI for uploading a profile photo
                SignUpButton // Button to submit the sign-up form
            }
            .padding(.horizontal, 20)
            .sheet(isPresented: $showStatusRegistration) {
                if let postUserResponse = viewModel.postUserResponse {
                    StatusRegistrationView(postUserResponse: postUserResponse) {
                        viewModel.postUserResponse = nil
                        if !postUserResponse.success {
                            showStatusRegistration = false
                            Task {
                                do {
                                    try await viewModel.postUser() // Retry registration if failed
                                    showStatusRegistration = true
                                } catch {
                                    print("SignUp Network Error: \(error.localizedDescription)")
                                }
                            }
                        }
                    }
                }
            }
            // Displays the camera picker for photo capture
            .sheet(isPresented: $showCameraPicker) { CameraView(isPresented: $showCameraPicker, image: $viewModel.selectedImage) }
            // Displays the photo library picker
            .photosPicker(isPresented: $showImagePicker, selection: $viewModel.selectedPickerItem, matching: .images)
            // Opens photo library or camera
            .actionSheet(isPresented: $showActionSheet) {
                ActionSheet(
                    title: Text("Select Photo Source"),
                    buttons: [
                        .default(Text("Library")) {
                            showImagePicker.toggle()
                        },
                        .default(Text("Camera")) {
                            showCameraPicker.toggle()
                        },
                        .cancel(Text("Cancel"))
                    ]
                )
            }
        }
    }
}

extension SignUpView {
    @ViewBuilder
    var TextFields: some View {
        VStack(spacing: vStackSpacing) {
            CustomTextField(
                textInput: $viewModel.name,
                placeholder: "Your Name"
            )
            .padding(.top, 30)
            
            CustomTextField(
                textInput: $viewModel.email,
                placeholder: "Email",
                inputExample: "test@test.com"
            )
            .keyboardType(.emailAddress)
            
            CustomTextField(
                textInput: $viewModel.phone,
                placeholder: "Phone",
                inputExample: "+38 (XXX) XXX - XX - XX"
            )
            .keyboardType(.decimalPad)
        }
    }
    
    @ViewBuilder
    var PositionList: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Select your position")
                .font(Font.custom("NunitoSans-ExtraLight", size: 22))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            ForEach(viewModel.positions, id: \.id) { element in
                HStack(spacing: 25) {
                    Button {
                        viewModel.selectedPosition = element
                    } label: {
                        Circle()
                            .fill(.clear)
                            .frame(width: 15, height: 15)
                            .if(viewModel.selectedPosition == element) { ifCase in
                                ifCase
                                    .overlay {
                                        Circle()
                                            .stroke(.customBlue, lineWidth: 5)
                                    }
                            } elseScope: { elseCase in
                                elseCase
                                    .overlay {
                                        Circle()
                                            .stroke(.black.opacity(0.4), lineWidth: 1)
                                    }
                            }
                    }
                    
                    Text(element.name)
                        .font(Font.custom("NunitoSans-ExtraLight", size: 17))
                }
                .padding(.horizontal, 10)
            }
        }
    }
    
    @ViewBuilder
    var UploadView: some View {
        HStack {
            if let selectedImage = viewModel.selectedImage {
                HStack {
                    Text("Image:")
                        .font(Font.custom("NunitoSans-ExtraLight", size: 18))
                    
                    Image(systemName: "photo.artframe")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .foregroundStyle(.customBlue)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            } else {
                Text("Upload your photo")
                    .foregroundStyle(.black.opacity(0.4))
                    .font(Font.custom("NunitoSans-ExtraLight", size: 18))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            Button {
                showActionSheet.toggle()
            } label: {
                Text("Upload")
                    .font(Font.custom("NunitoSans-ExtraLight", size: 18))
                    .foregroundStyle(.customBlue)
            }
        }
        .padding(20)
        .frame(height: 60)
        .overlay {
            RoundedRectangle(cornerRadius: 4)
                .stroke(.black.opacity(0.6), lineWidth: 1)
        }
    }
    
    @ViewBuilder
    var SignUpButton: some View {
        Button {
            Task {
                do {
                    try await viewModel.postUser()
                    showStatusRegistration.toggle()
                } catch {
                    print("SignUp Network Error: \(error.localizedDescription)")
                }
            }
        } label: {
            Text("Sign up")
                .font(Font.custom("NunitoSans-Light", size: 20))
                .foregroundStyle(.black.opacity(viewModel.canSubmit ? 1.0 : 0.6))
        }
        .disabled(!viewModel.canSubmit)
        .frame(width: 140, height: 48)
        .background {
            RoundedRectangle(cornerRadius: 24)
                .fill(viewModel.canSubmit ? .customYellow : .dirtyWhite)
        }
        .frame(maxWidth: .infinity)
    }
}


#Preview {
    SignUpView(viewModel: SignUpViewModel(networkManager: NetworkManager()))
}





