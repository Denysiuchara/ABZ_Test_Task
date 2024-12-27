//
//  ViewModel.swift
//  TestTaskByDaniaDenisuk
//
//  Created by Danya Denisiuk on 25.12.2024.
//

import SwiftUI
import PhotosUI
import Combine

final class SignUpViewModel: ObservableObject {
    
    @Published var email = Email(text: "")
    @Published var phone = Phone(text: "")
    @Published var name = Nickname(text: "")
    
    @Published var canSubmit = false
    @Published var positions: [Position] = []
    @Published var selectedPosition: Position?
    @Published var selectedPickerItem: PhotosPickerItem? {
        didSet {
            Task { await loadImageData() }
        }
    }
    @Published var selectedImage: UIImage?
    @Published var postUserResponse: PostUserResponse? = nil
    
    private var cancellable: Set<AnyCancellable> = []
    var networkManager: NetworkManager
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
        setReactive()
    }
    
    private func setReactive() {
        Publishers.CombineLatest3($email, $phone, $name)
            .map { email, phone, name in
                email.isValid && phone.isValid && name.isValid
            }
            .assign(to: \.canSubmit, on: self)
            .store(in: &cancellable)
    }
    
    @MainActor
    private func loadImageData() async {
        guard let selectedPickerItem = selectedPickerItem else { return }
        
        do {
            if let data = try await selectedPickerItem.loadTransferable(type: Data.self),
               let image = UIImage(data: data) {
                self.selectedImage = image
            } else {
                self.selectedImage = nil
            }
        } catch {
            print("Error loading image: \(error)")
            self.selectedImage = nil
        }
    }
    
    @MainActor
    func postUser() async throws {
        guard let positionId = selectedPosition?.id else { throw Error.emptyPosition }
        guard let imageAsData = selectedImage?.asBackendReadyData else { throw Error.failureConvertImage }
        
        let token = try await networkManager.getToken()
        let response = try await networkManager.postUser(
            token: token,
            user: NewUser(
                name: name.text,
                email: email.text,
                phone: phone.text,
                positionId: positionId,
                photo: imageAsData
            )
        )
        self.postUserResponse = response
    }
    
    @MainActor
    func getPositions() async throws {
        positions = try await networkManager.getPositions()
        
        guard !positions.isEmpty else { return }
        selectedPosition = positions.first
    }
}


extension SignUpViewModel {
    enum Error: Swift.Error {
        case invalidEmail
        case invalidPassword
        case invalidUsername
        case emptyPosition
        case emptyImage
        case failureConvertImage
    }
}
