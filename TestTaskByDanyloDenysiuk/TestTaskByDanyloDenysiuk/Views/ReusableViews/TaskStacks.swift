
import SwiftUI

// MARK: - TaskVStack
struct TaskVStack<InProgressView: View, InCompletedView: View>: View {
    let alignment: HorizontalAlignment
    let spacing: CGFloat?
    let task: () async -> Void
    
    @ViewBuilder let inProgressView: () -> InProgressView
    @ViewBuilder let inCompletedView: () -> InCompletedView
    
    @State private var isCompleted: Bool = false
    
    init(
        alignment: HorizontalAlignment = .center,
        spacing: CGFloat? = nil,
        task: @escaping () async -> Void,
        @ViewBuilder inProgressView: @escaping () -> InProgressView,
        @ViewBuilder inCompletedView: @escaping () -> InCompletedView
    ) {
        self.alignment = alignment
        self.spacing = spacing
        self.task = task
        self.inProgressView = inProgressView
        self.inCompletedView = inCompletedView
    }
    
    var body: some View {
        VStack(alignment: alignment, spacing: spacing) {
            if isCompleted {
                inCompletedView()
                    .transition(.opacity)
            } else {
                inProgressView()
                    .transition(.opacity)
            }
        }
        .task {
            await task()
            withAnimation {
                isCompleted = true
            }
        }
    }
}


// MARK: - TaskHStack
struct TaskHStack<InProgressView: View, InCompletedView: View>: View {
    let alignment: VerticalAlignment
    let spacing: CGFloat?
    let task: () async -> Void
    
    @ViewBuilder let inProgressView: () -> InProgressView
    @ViewBuilder let inCompletedView: () -> InCompletedView
    
    @State private var isCompleted: Bool = false
    
    init(
        alignment: VerticalAlignment = .center,
        spacing: CGFloat? = nil,
        task: @escaping () async -> Void,
        @ViewBuilder inProgressView: @escaping () -> InProgressView,
        @ViewBuilder inCompletedView: @escaping () -> InCompletedView
    ) {
        self.alignment = alignment
        self.spacing = spacing
        self.task = task
        self.inProgressView = inProgressView
        self.inCompletedView = inCompletedView
    }
    
    var body: some View {
        HStack(alignment: alignment, spacing: spacing) {
            if isCompleted {
                inCompletedView()
                    .transition(.opacity)
            } else {
                inProgressView()
                    .transition(.opacity)
            }
        }
        .task {
            await task()
            withAnimation {
                isCompleted = true
            }
        }
    }
}


// MARK: - TaskZStack
struct TaskZStack<InProgressView: View, InCompletedView: View>: View {
    let alignment: Alignment
    let task: () async -> Void
    
    @ViewBuilder let inProgressView: () -> InProgressView
    @ViewBuilder let inCompletedView: () -> InCompletedView
    
    @State private var isCompleted: Bool = false
    
    init(
        alignment: Alignment = .center,
        task: @escaping () async -> Void,
        @ViewBuilder inProgressView: @escaping () -> InProgressView,
        @ViewBuilder inCompletedView: @escaping () -> InCompletedView
    ) {
        self.alignment = alignment
        self.task = task
        self.inProgressView = inProgressView
        self.inCompletedView = inCompletedView
    }
    
    var body: some View {
        ZStack(alignment: alignment) {
            if isCompleted {
                inCompletedView()
                    .transition(.opacity)
            } else {
                inProgressView()
                    .transition(.opacity)
            }
        }
        .task {
            await task()
            withAnimation {
                isCompleted = true
            }
        }
    }
}


#Preview {
    TaskVStack {
        try? await Task.sleep(for: .seconds(5))
    } inProgressView: {
        ProgressView {
            Text("Loading...")
        }
    } inCompletedView: {
        Text("All completed")
    }
}
