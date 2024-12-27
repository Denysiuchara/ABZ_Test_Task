//
//  RootViewModel.swift
//  TestTaskByDaniaDenisuk
//
//  Created by Danya Denisiuk on 25.12.2024.
//

import Foundation

protocol VMRequrementProtocol: ObservableObject {
    var networkManager: NetworkManager { get set }
}

final class RootViewModel: VMRequrementProtocol {
    @Published private(set) var usersVM: UsersViewModel
    @Published private(set) var signUpVM: SignUpViewModel
    
    var networkManager: NetworkManager = NetworkManager()
    
    init() {
        usersVM = UsersViewModel(networkManager: networkManager)
        signUpVM = SignUpViewModel(networkManager: networkManager)
    }
    
    func primaryNetCall() async throws {
        try await usersVM.fetchUsers()
        try await signUpVM.getPositions()
    }
}
