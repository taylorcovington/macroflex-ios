//
//  LoadingView.swift
//  MacroFlexV1
//
//  Created by Taylor Covington on 4/7/23.
//

import SwiftUI

struct LoadingView: View {
    
    // MARK: - Private properties:
    
    /// 'Bool' value indicating whether or not the loading indicator should be shown:
    private var isShowing: Bool
    
    /// Title of the loading indicator:
    private var title: String?
    
    /// 'Bool' value indicating whether or not the title should be localized:
    private var isTitleLocalized: Bool
    
    /// Color of the loading indicator:
    private var color: Color
    
    /// Scale of the loading indicator ('1' is the default scale, anything more will increase the size of the indicator, anything less will decrease its size):
    private var scale: Double
    
    /// Frame of the view (If needed, can simply be 'nil'):
    private var frame: CGFloat?
    
    init(
        isShowing: Bool = false,
        title: String? = nil,
        isTitleLocalized: Bool = true,
        color: Color = .accentColor,
        scale: Double = 1,
        frame: CGFloat? = nil
    ) {
        
        /// Properties initialization:
        self.isShowing = isShowing
        self.title = title
        self.isTitleLocalized = isTitleLocalized
        self.color = color
        self.scale = scale
        self.frame = frame
    }
    
    // MARK: - View:
    
    var body: some View {
        content
    }
    
    @ViewBuilder
    private var content: some View {
        if isShowing {
            item
        }
    }
}

// MARK: - Item:

private extension LoadingView {
    private var item: some View {
        itemContent
            .progressViewStyle(.circular)
            .tint(color)
            .scaleEffect(scale)
            .frame(
                width: frame,
                height: frame
            )
    }
    
    @ViewBuilder
    private var itemContent: some View {
        if let title {
            titleItem(title)
        } else {
            ProgressView()
        }
    }
    
    private func titleItem(_ title: String) -> some View {
        ProgressView()
    }
}

// MARK: - Title:

private extension LoadingView {
    @ViewBuilder
    private func titleContent(_ title: String) -> some View {
        if isTitleLocalized {
            Text(LocalizedStringKey(title))
        } else {
            Text(title)
        }
    }
}

// MARK: - Preview:

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView(
            isShowing: true,
            title: "Title",
            isTitleLocalized: true,
            color: .accentColor,
            scale: 1,
            frame: nil
        )
    }
}
