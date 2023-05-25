//
//  GoalsView.swift
//  MacroFlexV1
//
//  Created by Taylor Covington on 4/3/23.
//

import SwiftUI
import SwiftfulRouting

struct WelcomeView: View {
    let router: AnyRouter
    
    /// Feature that is currently shown:
    @State private var currentFeature: AS_Feature = .first
    
    /// An array of features to display:
    private var features: [AS_Feature] {
        Array(AS_Feature.allCases.prefix(4))
    }
    
    var body: some View {
            VStack {
                itemContent
                .animation(
                    .default,
                    value: currentFeature
                )
                .onChange(of: currentFeature) { _ in
                    HapticFeedbacks.selectionChanges()
                }
              
            }
           
    }
}
    
    // MARK: - Item:

    private extension WelcomeView {
        private var item: some View {
            VStack(
                alignment: .center,
                spacing: 0
            ) {
                itemContent
            }
        }
        
        @ViewBuilder
        private var itemContent: some View {
            featuresContent
            bottomToolbar
        }
    }

    // MARK: - Features:

    private extension WelcomeView {
        private var featuresContent: some View {
            featuresItem
                .tabViewStyle(.page(indexDisplayMode: .never))
        }
        
        private var featuresItem: some View {
            TabView(selection: $currentFeature) {
                featuresItemContent
            }
        }
        
        private var featuresItemContent: some View {
            ForEach(
                features,
                content: featureScroll
            )
        }
        
        private func featureScroll(_ feature: AS_Feature) -> some View {
            featureScrollContent(feature)
                .tag(feature)
        }
        
        private func featureScrollContent(_ feature: AS_Feature) -> some View {
            ScrollView {
                self.feature(feature)
            }
        }
        
        private func feature(_ feature: AS_Feature) -> some View {
            featureContent(feature)
                .padding(.top, 24)
                .padding(.bottom, 32)
        }
        
        private func featureContent(_ feature: AS_Feature) -> some View {
            VStack(
                alignment: .center,
                spacing: 48
            ) {
                featureItem(feature)
            }
        }
        
        @ViewBuilder
        private func featureItem(_ feature: AS_Feature) -> some View {
            featureImage(feature)
            featureTextContent(feature)
        }
        
        private func featureImage(_ feature: AS_Feature) -> some View {
            Image(feature.onboardingEightImage)
                .frame(
                    maxWidth: .infinity,
                    alignment: .center
                )
                .background(Color.blue)
        }
        
        private func featureTextContent(_ feature: AS_Feature) -> some View {
            TitleTextView(
                title: feature.title,
                titleFont: Font.title2.bold(),
                text: feature.text,
                textFont: .body,
                spacing: 16,
                horizontalPadding: 16
            )
        }
    }

    // MARK: - Bottom toolbar:

    private extension WelcomeView {
        private var bottomToolbar: some View {
            BottomToolbarView(isDividerShowing: true) {
                bottomToolbarContent
            }
    //        .padding(.bottom, 80)
        }
        
        @ViewBuilder
        private var bottomToolbarContent: some View {
            pagination
               
            nextButton
        }
        
        private var pagination: some View {
            PaginationView(
                current: $currentFeature,
                all: features
            )
        }
        
        private var nextButton: some View {
            ButtonView(title: "Get Started") {
                router.showScreen(.push) { router in
                    ConnectView(router: router)
                }
            }

        }
    }
    




struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        RouterView { router in
            WelcomeView(router: router)
        }
    }
}
