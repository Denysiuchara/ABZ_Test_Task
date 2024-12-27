//
//  TextInputProtocol.swift
//  TestTaskByDaniaDenisuk
//
//  Created by Danya Denisiuk on 25.12.2024.
//

import Foundation

enum Regex: String {
    case phone = "(\\s*)?(\\+)?([- _():=+]?\\d[- _():=+]?){10,14}(\\s*)?"
    case email = #"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?"#
    case name = #"^[a-zA-Zа-яА-Я][a-zA-Zа-яА-Я0-9]*(?: [a-zA-Zа-яА-Я0-9]+)*$"#
}


protocol TextInputProtocol {
    var text: String { get set }
    var predicate: NSPredicate { get set }
    var invalidText: String? { get }
    var isValid: Bool { get }
}

extension TextInputProtocol {
    var isValid: Bool {
        !text.isEmpty ? predicate.evaluate(with: text) : true
    }
}

struct Email: TextInputProtocol {
    var text: String
    var predicate: NSPredicate
    
    var invalidText: String? {
        if text.isEmpty || isValid {
            return nil
        } else {
            return "Invalid email format. Example: test@test.com"
        }
    }
    
    init(text: String) {
        self.text = text
        self.predicate = NSPredicate(format: "SELF MATCHES %@", Regex.email.rawValue)
    }
}


struct Phone: TextInputProtocol {
    var predicate: NSPredicate
    var text: String
    
    var invalidText: String? {
        if text.isEmpty || isValid {
            return nil
        } else {
            return "Invalid phone format. Example: +38(0XX)XXX-XX-XX"
        }
    }
    
    init(text: String) {
        self.text = text
        self.predicate = NSPredicate(format: "SELF MATCHES %@", Regex.phone.rawValue)
    }
}


struct Nickname: TextInputProtocol {
    var text: String
    var predicate: NSPredicate
    
    var isValid: Bool {
        if !text.isEmpty {
            if 2...60 ~= text.count {
                predicate.evaluate(with: text)
            } else {
                false
            }
        } else {
            true
        }
    }
    
    var invalidText: String? {
        if text.isEmpty || isValid {
            return nil
        } else {
            return "Invalid name format. Example: Name Surname"
        }
    }
    
    init(text: String) {
        self.text = text
        self.predicate = NSPredicate(format: "SELF MATCHES %@", Regex.name.rawValue)
    }
}
