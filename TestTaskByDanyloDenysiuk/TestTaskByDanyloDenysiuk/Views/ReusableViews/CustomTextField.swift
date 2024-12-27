//
//  CustomTextField.swift
//  TestTaskByDaniaDenisuk
//
//  Created by Danya Denisiuk on 25.12.2024.
//

import SwiftUI

struct CustomTextField<T: TextInputProtocol>: View {
    @Binding var textInput: T
    let placeholder: String
    let inputExample: String?
    
    init(
        textInput: Binding<T>,
        placeholder: String,
        inputExample: String? = nil
    ) {
        self._textInput = textInput
        self.placeholder = placeholder
        self.inputExample = inputExample
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            TextField(text: $textInput.text) {
                Text(placeholder)
                    .font(Font.custom("NunitoSans-ExtraLight", size: 18))
            }
            .onChange(of: textInput.text) { newValue in
                if T.self == Phone.self {
                    var phone = newValue
                    
                    if !phone.starts(with: "+38") {
                        phone = "+38" + phone
                    }
                    
                    textInput.text = phone.applyPhoneMask()
                }
            }
            .padding(20)
            .overlay {
                RoundedRectangle(cornerRadius: 4)
                    .stroke(textInput.isValid ? .black.opacity(0.6) : .red, lineWidth: 1)
            }
            
            if let inputExample = inputExample, textInput.isValid {
                Text(inputExample)
                    .font(Font.custom("NunitoSans-ExtraLight", size: 15))
                    .padding(.horizontal, 20)
                    .foregroundStyle(.black.opacity(0.6))
            }
            
            if let invalidText = textInput.invalidText {
                Text(invalidText)
                    .font(Font.custom("NunitoSans-ExtraLight", size: 15))
                    .padding(.horizontal, 20)
                    .foregroundStyle(.red)
            }
        }
    }
}
