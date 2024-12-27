//
//  ContentView.swift
//  TestTaskByDaniaDenisuk
//
//  Created by Danya Denisiuk on 25.12.2024.
//

import SwiftUI

enum ContentViewTab {
    case user
    case signUp
}

/// Main view of the application
struct ContentView: View {
    // Enum to handle different states of the content view
    enum ContentViewEventHandler {
        case disconnected // No internet connection
        case loading      // Data is being loaded
        case fail         // Data loading failed
        case success      // Data loaded successfully
    }
    
    @Environment(NetworkMonitor.self) private var networkMonitor // Observes network connectivity
    @StateObject private var rootVM: RootViewModel = RootViewModel() // Root view model containing sub-view models
    
    @State private var selectedTab: ContentViewTab = .user // Manages the currently selected tab
    @State private var eventHandler: ContentViewEventHandler = .loading // Tracks the current state of the application
    
    var body: some View {
        TaskZStack {
            try? await Task.sleep(for: .seconds(3)) // Simulates a delay for loading
        } inProgressView: {
            LaunchSreen() // Displays a launch screen while loading
        } inCompletedView: {
            ZStack {
                switch eventHandler {
                case .disconnected:
                    NoConnectionView { // View displayed when there is no internet connection
                        Task {
                            await primaryNetCallAction() // retry network call to fetch data
                        }
                    }
                        .transition(.opacity)
                case .loading:
                    ProgressView() // Shows a loading spinner
                        .transition(.opacity)
                case .fail:
                    Color.red // Background indicating a failure
                        .transition(.opacity)
                case .success:
                    VStack {
                        // Header with a title
                        Text("Working with Get request")
                            .font(Font.custom("NunitoSans-ExtraLight", size: 20))
                            .frame(maxWidth: .infinity)
                            .frame(height: 56)
                            .background(Rectangle().fill(.customYellow))
                        
                        // Main content area
                        ZStack {
                            switch selectedTab {
                            case .user:
                                UsersListView(viewModel: rootVM.usersVM) // Displays a list of users
                                    .transition(.opacity)
                            case .signUp:
                                SignUpView(viewModel: rootVM.signUpVM) // Displays a sign-up form
                                    .transition(.opacity)
                            }
                        }
                        .frame(maxHeight: .infinity)
                        
                        // Tab bar for navigation between tabs
                        TabView(selectedTab: $selectedTab)
                    }
                    .transition(.opacity)
                }
            }
            .task {
                await primaryNetCallAction() // Initial network call to fetch data
            }
        }
    }
    
    // Handles the primary network call and updates the UI based on the result
    func primaryNetCallAction() async {
        if networkMonitor.isConnected {
            do {
                try await rootVM.primaryNetCall() // Attempts to fetch data from the network
                withAnimation {
                    eventHandler = .success // Updates state on success
                }
            } catch {
                withAnimation {
                    eventHandler = .fail // Updates state on failure
                }
            }
        } else {
            withAnimation {
                eventHandler = .disconnected // Updates state when there's no connection
            }
        }
    }
}

#Preview {
    ContentView()
}
