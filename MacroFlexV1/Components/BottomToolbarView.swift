//
//  BottomToolbarView.swift
//  MacroFlexV1
//
//  Created by Taylor Covington on 4/7/23.
//

import SwiftUI

struct BottomToolbarView<ToolbarContent: View>: View {
    
    // MARK: - Private properties:
    
    /// Size of the dynamic type selected by the user:
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize
    
    /// Horizontal alignment of the toolbar's content:
    private var horizontalAlignment: HorizontalAlignment
    
    /// Vertical alignment of the toolbar's content:
    private var verticalAlignment: VerticalAlignment
    
    /// Spacing between the content of the toolbar:
    private var spacing: Double
    
    /// Padding around the content:
    private var padding: Double
    
    /// 'Bool' value indicating whether or not the divider should be shown:
    private var isDividerShowing: Bool
    
    /// Alignment of the content:
    private var contentAlignment: AS_Alignment
    
    /// Color of the toolbar's background:
    private var backgroundColor: Color
    
    /// Content of the toolbar:
    private var toolbarContent: ToolbarContent
    
    init(
        horizontalAlignment: HorizontalAlignment = .center,
        verticalAlignment: VerticalAlignment = .center,
        spacing: Double = 24,
        padding: Double = 16,
        isDividerShowing: Bool = false,
        contentAlignment: AS_Alignment = .vertical,
        backgroundColor: Color = .clear,
        @ViewBuilder
        toolbarContent: @escaping () -> ToolbarContent
    ) {
        
        /// Properties initialization:
        self.horizontalAlignment = horizontalAlignment
        self.verticalAlignment = verticalAlignment
        self.spacing = spacing
        self.padding = padding
        self.isDividerShowing = isDividerShowing
        self.contentAlignment = contentAlignment
        self.backgroundColor = backgroundColor
        self.toolbarContent = toolbarContent()
    }
    
    // MARK: - Private computed properties:
    
    /// 'Bool' value indicating whether or not the scroll should be added (When dynamic type's size is too large):
    private var shouldAddScroll: Bool {
        dynamicTypeSize >= .accessibility1
    }
    
    // MARK: - View:
    
    var body: some View {
        content
    }
    
    private var content: some View {
        item
            .frame(
                maxWidth: .infinity,
                maxHeight: shouldAddScroll ? 200 : nil,
                alignment: .top
            )
            .background(backgroundColor)
    }
}

// MARK: - Item:

private extension BottomToolbarView {
    @ViewBuilder
    private var item: some View {
        VStack(
            alignment: horizontalAlignment,
            spacing: 0
        ) {
            itemContent
        }
    }
    
    @ViewBuilder
    private var itemContent: some View {
        divider
        toolbar
    }
}

// MARK: - Divider:

private extension BottomToolbarView {
    @ViewBuilder
    private var divider: some View {
        if isDividerShowing {
            Divider()
        }
    }
}

// MARK: - Toolbar:

private extension BottomToolbarView {
    @ViewBuilder
    private var toolbar: some View {
        if shouldAddScroll {
            toolbarScroll
        } else {
            toolbarItem
        }
    }
    
    private var toolbarScroll: some View {
        ScrollView(showsIndicators: false) {
            toolbarItem
        }
    }
    
    private var toolbarItem: some View {
        toolbarItemContent
            .padding(padding)
            .padding(.bottom, 16)
    }
    
    @ViewBuilder
    private var toolbarItemContent: some View {
        switch contentAlignment {
        case .vertical: verticalToolbarItemContent
        case .horizontal: horizontalToolbarItemContent
        }
    }
    
    private var verticalToolbarItemContent: some View {
        VStack(
            alignment: horizontalAlignment,
            spacing: spacing
        ) {
            toolbarContent
        }
    }
    
    private var horizontalToolbarItemContent: some View {
        HStack(
            alignment: verticalAlignment,
            spacing: spacing
        ) {
            toolbarContent
        }
    }
}

// MARK: - Preview:

struct BottomToolbarView_Previews: PreviewProvider {
    static var previews: some View {
        BottomToolbarView(
            horizontalAlignment: .center,
            verticalAlignment: .center,
            spacing: 24,
            padding: 16,
            isDividerShowing: false,
            contentAlignment: .vertical,
            backgroundColor: .clear
        ) {
            Text("Toolbar Content")
                .foregroundColor(.secondary)
        }
    }
}
