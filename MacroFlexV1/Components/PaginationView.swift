//
//  PaginationView.swift
//  MacroFlexV1
//
//  Created by Taylor Covington on 4/7/23.
//

import SwiftUI

struct PaginationView<Page: Hashable>: View {
    
    // MARK: - Private properties:
    
    /// Currently selected page:
    @Binding private var current: Page
    
    /// All pages:
    private var all: [Page]
    
    /// Color of the dots:
    private var color: Color
    
    /// Frame of the dots:
    private var frame: Double
    
    /// Alignment of the dots:
    private var alignment: VerticalAlignment
    
    /// Spacing between the dots:
    private var spacing: Double
    
    init(
        current: Binding<Page>,
        all: [Page],
        color: Color = .accentColor,
        frame: Double = 8,
        alignment: VerticalAlignment = .center,
        spacing: Double = 10
    ) {
       
        /// Properties initialization:
        _current = current
        self.all = all
        self.color = color
        self.frame = frame
        self.alignment = alignment
        self.spacing = spacing
    }
    
    // MARK: - View:
    
    var body: some View {
        content
    }
    
    private var content: some View {
        HStack(
            alignment: alignment,
            spacing: spacing
        ) {
            pages
        }
    }
}

// MARK: - Pages:

private extension PaginationView {
    private var pages: some View {
        ForEach(
            all,
            id: \.self,
            content: page
        )
    }
    
    private func page(_ page: Page) -> some View {
        Circle()
            .fill(backgroundColor(forPage: page))
            .frame(
                width: frame,
                height: frame
            )
            .onTapGesture {
                current = page
            }
    }
}

// MARK: - Functions:

private extension PaginationView {
    
    // MARK: - Private functions:
    
    /// Returns a background color of each page item based on whether or not it's selected:
    private func backgroundColor(forPage page: Page) -> Color {
        current == page ? color : color.opacity(0.3)
    }
}

// MARK: - Preview:

struct PaginationView_Previews: PreviewProvider {
    static var previews: some View {
        PaginationView(
            current: .constant(PreviewPagination.first),
            all: PreviewPagination.allCases,
            color: .accentColor,
            frame: 8,
            alignment: .center,
            spacing: 10
        )
    }
}

// MARK: - Preview example:

/// This pagination enum is only used for the SwiftUI preview in this file:
fileprivate enum PreviewPagination: Int, Identifiable, CaseIterable {
    
    // MARK: - Cases:
    
    case first
    case second
    case third
    case fourth
    
    // MARK: - Computed properties:
    
    /// Identifier of the preview pagination:
    var id: Int {
        rawValue
    }
}

