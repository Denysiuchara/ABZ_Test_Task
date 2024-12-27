//
//  UsersViewModel.swift
//  TestTaskByDaniaDenisuk
//
//  Created by Danya Denisiuk on 25.12.2024.
//

import Foundation

final class UsersViewModel: VMRequrementProtocol {
    @Published var users: [User] = []
    @Published var isLoading: Bool = false
    @Published var currentPage: Int = 1
    @Published var hasMorePages: Bool = true
    
    var networkManager: NetworkManager
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    @MainActor
    func fetchUsers(page: Int = 1, count: Int = 5) async throws {
        guard !isLoading else { return }
        
        isLoading = true
        defer { isLoading = false }
        
        let newUsers = try await networkManager.getUsers(page: page, count: count)
        
        if newUsers.count < count {
            hasMorePages = false
        }
        
        if page == 1 {
            self.users = newUsers
        } else {
            self.users.append(contentsOf: newUsers)
        }
        
        currentPage = page
    }
    
    func loadMoreUsers() async throws {
        guard hasMorePages, !isLoading else { return }
        try await fetchUsers(page: currentPage + 1)
    }
}
