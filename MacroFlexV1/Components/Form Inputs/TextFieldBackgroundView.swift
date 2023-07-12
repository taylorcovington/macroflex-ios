//
//  TextFieldBackgroundView.swift
//  App.io
//

import SwiftUI

struct TextFieldBackgroundView: View {
    
    // MARK: - Private properties:
    
    /// Text inputed into the text field:
    @Binding private var text: String
    
    /// Title of the text field:
    private var title: LocalizedStringKey
    
    /// Type of the keyboard this text field should have:
    private var keyboardType: UIKeyboardType
    
    /// 'Bool' value indicating whether or not this text field should be a secure field:
    private var isSecure: Bool
    
    /// Font of the text field:
    private var font: Font
    
    /// Alignment of the text field:
    private var alignment: TextAlignment
    
    /// Color of the text field's value:
    private var valueColor: Color
    
    /// Padding of the text field:
    private var padding: Double
    
    /// Background color of the text field:
    private var backgroundColor: Color
    
    /// Corner radius of the text field:
    private var cornerRadius: Double
    
    /// 'Bool' value indicating whether or not the text field should be disabled:
    private var isDisabled: Bool
    
    init(
        text: Binding<String>,
        title: LocalizedStringKey,
        keyboardType: UIKeyboardType = .default,
        isSecure: Bool = false,
        font: Font = .body,
        alignment: TextAlignment = .leading,
        valueColor: Color = .primary,
        padding: Double = 16,
        backgroundColor: Color = Color(.tertiarySystemFill),
        cornerRadius: Double = 12,
        isDisabled: Bool = false
    ) {
        
        /// Properties initialization:
        _text = text
        self.title = title
        self.keyboardType = keyboardType
        self.isSecure = isSecure
        self.font = font
        self.alignment = alignment
        self.valueColor = valueColor
        self.padding = padding
        self.backgroundColor = backgroundColor
        self.cornerRadius = cornerRadius
        self.isDisabled = isDisabled
    }
    
    // MARK: - Private computed properties:
    
    /// 'Bool' value indicating whether or not a text is empty:
    private var isTextEmpty: Bool {
        text.isEmpty
    }
    
    // MARK: - View:
    
    var body: some View {
        content
    }
    
    private var content: some View {
        item
            .keyboardType(keyboardType)
            .font(font)
            .multilineTextAlignment(alignment)
            .foregroundColor(valueColor)
            .padding(padding)
            .background(backgroundColor)
            .cornerRadius(cornerRadius)
            .disabled(isDisabled)
    }
}

// MARK: - Item:

private extension TextFieldBackgroundView {
    @ViewBuilder
    private var item: some View {
        if isSecure {
            secureItem
        } else {
            regularItem
        }
    }
    
    private var secureItem: some View {
        SecureField(
            title,
            text: $text
        )
    }
    
    private var regularItem: some View {
        TextField(
            title,
            text: $text
        )
    }
}

// MARK: - Preview:

struct TextFieldBackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldBackgroundView(
            text: .constant("info@appsources.io"),
            title: "Email",
            keyboardType: .default,
            isSecure: false,
            font: .body,
            alignment: .leading,
            valueColor: .primary,
            padding: 16,
            backgroundColor: Color(.tertiarySystemFill),
            cornerRadius: 12,
            isDisabled: false
        )
    }
}
