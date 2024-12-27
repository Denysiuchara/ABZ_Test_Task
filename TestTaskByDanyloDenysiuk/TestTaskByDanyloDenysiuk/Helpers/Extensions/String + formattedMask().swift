//
//  String + formattedMask().swift
//  TestTaskByDaniaDenisuk
//
//  Created by Danya Denisiuk on 25.12.2024.
//

import Foundation

extension String {
    var validPhoneField: String {
        self
            .replacingOccurrences(of: "(", with: "")
            .replacingOccurrences(of: ")", with: "")
            .replacingOccurrences(of: "-", with: "")
    }

    func applyPhoneMask(mask: String = "+XX(XXX)XXX-XX-XX") -> String {
            let cleanNumber = self.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
            var formattedNumber = ""
            var index = cleanNumber.startIndex

            for ch in mask where index < cleanNumber.endIndex {
                if ch == "X" {
                    formattedNumber.append(cleanNumber[index])
                    index = cleanNumber.index(after: index)
                } else {
                    formattedNumber.append(ch)
                }
            }

            return formattedNumber
        }
}
