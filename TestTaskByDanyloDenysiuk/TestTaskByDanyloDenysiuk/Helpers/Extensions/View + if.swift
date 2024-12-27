//
//  View+ if.swift
//  TestTaskByDaniaDenisuk
//
//  Created by Danya Denisiuk on 25.12.2024.
//

import SwiftUI

extension View {
    @ViewBuilder
    func `if`<Content: View>(
        _ condition: @autoclosure () -> Bool,
        ifScope: ((Self) -> Content),
        elseScope: ((Self) -> Content)? = nil
    ) -> some View {
        if condition() {
            ifScope(self)
        } else {
            if let elseScope {
                elseScope(self)
            } else {
                self
            }
        }
    }
}
