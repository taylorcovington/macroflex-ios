//
//  TitleTextView.swift
//  MacroFlexV1
//
//  Created by Taylor Covington on 4/7/23.
//

import SwiftUI

struct TitleTextView: View {
    
    // MARK: - Private properties:
    
    /// 'Bool' value indicating whether or not the title should be shown:
    private var isShowingTitle: Bool
    
    /// Title of display:
    private var title: String
    
    /// 'Bool' value indicating whether or not the title should be localized:
    private var isTitleLocalized: Bool
    
    /// Font of the title:
    private var titleFont: Font
    
    /// Text case of the title:
    private var titleTextCase: Text.Case?
    
    /// Alignment of the title:
    private var titleAlignment: TextAlignment
    
    /// Color of the title:
    private var titleColor: Color
    
    /// 'Bool' value indicating whether or not the text should be shown:
    private var isShowingText: Bool
    
    /// Text of display:
    private var text: String
    
    /// 'Bool' value indicating whether or not the text should be localized:
    private var isTextLocalized: Bool
    
    /// Font of the text:
    private var textFont: Font
    
    /// Text case of the text:
    private var textTextCase: Text.Case?
    
    /// Alignment of the text:
    private var textAlignment: TextAlignment
    
    /// Color of the text:
    private var textColor: Color
    
    /// Alignment of the title and the text:
    private var alignment: HorizontalAlignment
    
    /// Spacing between the title and the text:
    private var spacing: Double
    
    /// Vertical padding around the content:
    private var verticalPadding: Double
    
    /// Horizontal padding around the content:
    private var horizontalPadding: Double
    
    init(
        isShowingTitle: Bool = true,
        title: String,
        isTitleLocalized: Bool = true,
        titleFont: Font = Font.title2.bold(),
        titleTextCase: Text.Case? = .none,
        titleAlignment: TextAlignment = .center,
        titleColor: Color = .primary,
        isShowingText: Bool = true,
        text: String,
        isTextLocalized: Bool = true,
        textFont: Font = .body,
        textTextCase: Text.Case? = .none,
        textAlignment: TextAlignment = .center,
        textColor: Color = .secondary,
        alignment: HorizontalAlignment = .center,
        spacing: Double = 12,
        verticalPadding: Double = 0,
        horizontalPadding: Double = 0
    ) {
        
        /// Properties initialization:
        self.isShowingTitle = isShowingTitle
        self.title = title
        self.isTitleLocalized = isTitleLocalized
        self.titleFont = titleFont
        self.titleTextCase = titleTextCase
        self.titleAlignment = titleAlignment
        self.titleColor = titleColor
        self.isShowingText = isShowingText
        self.text = text
        self.isTextLocalized = isTextLocalized
        self.textFont = textFont
        self.textTextCase = textTextCase
        self.textAlignment = textAlignment
        self.textColor = textColor
        self.alignment = alignment
        self.spacing = spacing
        self.verticalPadding = verticalPadding
        self.horizontalPadding = horizontalPadding
    }
    
    // MARK: - View:
    
    var body: some View {
        content
    }
    
    private var content: some View {
        item
            .padding(
                .vertical,
                verticalPadding
            )
            .padding(
                .horizontal,
                horizontalPadding
            )
    }
}

// MARK: - Item:

private extension TitleTextView {
    private var item: some View {
        VStack(
            alignment: alignment,
            spacing: spacing
        ) {
            itemContent
        }
    }
    
    @ViewBuilder
    private var itemContent: some View {
        titleContent
        textContent
    }
}

// MARK: - Title:

private extension TitleTextView {
    @ViewBuilder
    private var titleContent: some View {
        if isShowingTitle {
            titleItem
        }
    }
    
    private var titleItem: some View {
        titleItemContent
            .font(titleFont)
            .textCase(titleTextCase)
            .multilineTextAlignment(titleAlignment)
            .foregroundColor(titleColor)
            /// Needed to fix weird text cropping:
            .fixedSize(
                horizontal: false,
                vertical: true
            )
    }
    
    @ViewBuilder
    private var titleItemContent: some View {
        if isTitleLocalized {
            Text(LocalizedStringKey(title))
        } else {
            Text(title)
        }
    }
}

// MARK: - Text:

private extension TitleTextView {
    @ViewBuilder
    private var textContent: some View {
        if isShowingText {
            textItem
        }
    }
    
    private var textItem: some View {
        textItemContent
            .font(textFont)
            .textCase(textTextCase)
            .multilineTextAlignment(textAlignment)
            .foregroundColor(textColor)
            /// Needed to fix weird text cropping:
            .fixedSize(
                horizontal: false,
                vertical: true
            )
    }
    
    @ViewBuilder
    private var textItemContent: some View {
        if isTextLocalized {
            Text(LocalizedStringKey(text))
        } else {
            Text(text)
        }
    }
}

// MARK: - Preview:

struct TitleTextView_Previews: PreviewProvider {
    static var previews: some View {
        TitleTextView(
            isShowingTitle: true,
            title: "Title",
            isTitleLocalized: true,
            titleFont: Font.title2.bold(),
            titleTextCase: .none,
            titleAlignment: .center,
            titleColor: .primary,
            isShowingText: true,
            text: "Text",
            isTextLocalized: true,
            textFont: .body,
            textTextCase: .none,
            textAlignment: .center,
            textColor: .secondary,
            alignment: .center,
            spacing: 12,
            verticalPadding: 0,
            horizontalPadding: 0
        )
    }
}
