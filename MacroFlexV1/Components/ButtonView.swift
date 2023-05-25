//
//  ButtonView.swift
//  MacroFlexV1
//
//  Created by Taylor Covington on 4/7/23.
//

import SwiftUI

struct ButtonView: View {
    
    // MARK: - Private properties:
    
    /// Title of the button:
    private var title: String
    
    /// 'Bool' value indicating whether or not the title should be localized:
    private var isTitleLocalized: Bool
    
    /// Icon to display (If needed, depending on the button style):
    private var icon: String
    
    /// Symbol variant of the icon:
    private var iconSymbolVariant: SymbolVariants
    
    /// Font of the button:
    private var font: Font
    
    /// Text case of the button:
    private var textCase: Text.Case?
    
    /// Alignment of the button's title:
    private var titleAlignment: TextAlignment
    
    /// Color of the button:
    private var color: Color
    
    /// Style of the button:
    private var style: AS_ButtonStyle
    
    /// Vertical padding of the button:
    private var verticalPadding: Double
    
    /// Horizontal padding of the button:
    private var horizontalPadding: Double
    
    /// 'Bool' value indicating whether or not the button should take the full available width:
    private var isFullWidth: Bool
    
    /// Alignment of the button:
    private var alignment: Alignment
    
    /// Background color of the button:
    private var backgroundColor: Color
    
    /// Corner radius of the button:
    private var cornerRadius: Double
    
    /// 'Bool' value indicating whether or not the loading indicator should be shown:
    private var isLoading: Bool
    
    /// Color of the loading indicator:
    private var loadingIndicatorColor: Color
    
    /// Scale of the loading indicator ('1' is the default scale, anything more will increase the size of the indicator, anything less will decrease its size):
    private var loadingIndicatorScale: Double
    
    /// Frame of the loading indicator (If needed, can simply be 'nil'):
    private var loadingIndicatorFrame: CGFloat?
    
    /// Color of the shadow:
    private var shadowColor: Color
    
    /// Radius of the shadow:
    private var shadowRadius: Double
    
    /// X-axis of the shadow:
    private var shadowXAxis: Double
    
    /// Y-axis of the shadow:
    private var shadowYAxis: Double
    
    /// Padding around the button:
    private var padding: Double
    
    /// 'Bool' value indicating whether or not the button should be disabled:
    private var isDisabled: Bool
    
    /// Action of the button:
    private var action: () -> Void
    
    init(
        title: String,
        isTitleLocalized: Bool = true,
        icon: String = "",
        iconSymbolVariant: SymbolVariants = .fill,
        font: Font = .headline,
        textCase: Text.Case? = .none,
        titleAlignment: TextAlignment = .center,
        color: Color = .white,
        style: AS_ButtonStyle = .titleOnly,
        verticalPadding: Double = 16,
        horizontalPadding: Double = 16,
        isFullWidth: Bool = true,
        alignment: Alignment = .center,
        backgroundColor: Color = .accentColor,
        cornerRadius: Double = 16,
        isLoading: Bool = false,
        loadingIndicatorColor: Color = .white,
        loadingIndicatorScale: Double = 1,
        loadingIndicatorFrame: CGFloat? = nil,
        shadowColor: Color = .clear,
        shadowRadius: Double = 0,
        shadowXAxis: Double = 0,
        shadowYAxis: Double = 0,
        padding: Double = 0,
        isDisabled: Bool = false,
        action: @escaping () -> Void
    ) {
        
        /// Properties initialization:
        self.title = title
        self.isTitleLocalized = isTitleLocalized
        self.icon = icon
        self.iconSymbolVariant = iconSymbolVariant
        self.font = font
        self.textCase = textCase
        self.titleAlignment = titleAlignment
        self.color = color
        self.style = style
        self.verticalPadding = verticalPadding
        self.horizontalPadding = horizontalPadding
        self.isFullWidth = isFullWidth
        self.alignment = alignment
        self.backgroundColor = backgroundColor
        self.cornerRadius = cornerRadius
        self.isLoading = isLoading
        self.loadingIndicatorColor = loadingIndicatorColor
        self.loadingIndicatorScale = loadingIndicatorScale
        self.loadingIndicatorFrame = loadingIndicatorFrame
        self.shadowColor = shadowColor
        self.shadowRadius = shadowRadius
        self.shadowXAxis = shadowXAxis
        self.shadowYAxis = shadowYAxis
        self.padding = padding
        self.isDisabled = isDisabled
        self.action = action
    }
    
    // MARK: - View:
    
    var body: some View {
        content
    }
    
    private var content: some View {
        item
            .padding(padding)
    }
}

// MARK: - Item:

private extension ButtonView {
    private var item: some View {
        itemContent
            .disabled(isDisabled || isLoading)
    }
    
    private var itemContent: some View {
        Button {
            action()
        } label: {
            label
        }
    }
}

// MARK: - Label:

private extension ButtonView {
    @ViewBuilder
    private var label: some View {
        switch style {
        case .none: labelContent
        case .titleAndIcon: titleAndIcon
        case .titleOnly: titleOnlyLabel
        case .iconOnly: iconOnlyLabel
        }
    }
    
    private var titleAndIcon: some View {
        labelContent
            .labelStyle(.titleAndIcon)
    }
    
    private var titleOnlyLabel: some View {
        labelContent
            .labelStyle(.titleOnly)
    }
    
    private var iconOnlyLabel: some View {
        labelContent
            .labelStyle(.iconOnly)
    }
    
    private var labelContent: some View {
        labelItem
            .font(font)
            .textCase(textCase)
            .multilineTextAlignment(titleAlignment)
            .foregroundColor(color)
            .padding(
                .vertical,
                verticalPadding
            )
            .padding(
                .horizontal,
                horizontalPadding
            )
            .frame(
                maxWidth: isFullWidth ? .infinity : nil,
                alignment: alignment
            )
            .background(backgroundColor)
            .clipShape(
                RoundedRectangle(
                    cornerRadius: cornerRadius,
                    style: .continuous
                )
            )
            .shadow(
                color: shadowColor,
                radius: shadowRadius,
                x: shadowXAxis,
                y: shadowYAxis
            )
    }
    
    @ViewBuilder
    private var labelItem: some View {
        if isLoading {
            loading
        } else {
            labelItemContent
        }
    }
    
    private var labelItemContent: some View {
        Label {
            titleContent
        } icon: {
            iconContent
        }
    }
}

// MARK: - Loading:

private extension ButtonView {
    private var loading: some View {
        LoadingView(
            isShowing: isLoading,
            color: loadingIndicatorColor,
            scale: loadingIndicatorScale,
            frame: loadingIndicatorFrame
        )
    }
}

// MARK: - Title:

private extension ButtonView {
    @ViewBuilder
    private var titleContent: some View {
        if isTitleLocalized {
            Text(LocalizedStringKey(title))
        } else {
            Text(title)
        }
    }
}

// MARK: - Icon:

private extension ButtonView {
    private var iconContent: some View {
        Image(systemName: icon)
            .symbolVariant(iconSymbolVariant)
    }
}

// MARK: - Preview:

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView(
            title: "Title",
            isTitleLocalized: true,
            icon: "",
            iconSymbolVariant: .fill,
            font: .headline,
            textCase: .none,
            titleAlignment: .center,
            color: .white,
            style: .titleOnly,
            verticalPadding: 16,
            horizontalPadding: 16,
            isFullWidth: true,
            alignment: .center,
            backgroundColor: .accentColor,
            cornerRadius: 16,
            isLoading: false,
            loadingIndicatorColor: .white,
            loadingIndicatorScale: 1,
            loadingIndicatorFrame: nil,
            shadowColor: .clear,
            shadowRadius: 0,
            shadowXAxis: 0,
            shadowYAxis: 0,
            padding: 0,
            isDisabled: false
        ) {
            
        }
    }
}

