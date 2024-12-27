//
//  Array + isLast.swift
//  TestTaskByDaniaDenisuk
//
//  Created by Danya Denisiuk on 25.12.2024.
//

import Foundation

extension Array where Element: Identifiable {
    func isLast(_ item: Element) -> Bool {
        guard let index = firstIndex(where: { $0.id == item.id }) else {
            return false
        }
        return index == count - 1
    }
}
