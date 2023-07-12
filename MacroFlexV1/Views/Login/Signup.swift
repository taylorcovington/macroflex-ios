//
//  SignUpFiveView.swift
//  App.io
//

import SwiftUI
import SwiftfulRouting

class SignUpViewModel: ObservableObject {
    
    func signUp() {
        
    }
    
}

struct Signup: View {
    let router: AnyRouter
    @StateObject var viewModelNew = SignUpViewModel()
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var email = ""
    @State private var password = ""
//    let signUp = createUser()
    // MARK: - Private properties:
    
    /// Dismisses the view:
    @Environment (\.dismiss) private var dismiss
    
    /// Size of the dynamic type selected by the user:
    @Environment(\.dynamicTypeSize) private var dynamicTypeSize
    
    /// Email inputed by the user:
//    @State private var email: String = ""
//
//    /// Password inputed by the user:
//    @State private var password: String = ""
    
    /// Confirmed Password inputed by the user:
    @State private var confirmedPassword: String = ""
    
    /// 'Bool' value indicating whether or not the user has agreed to the terms and conditions:
    @State private var isAgreeToTermsAndConditions: Bool = false
    
    // MARK: - Private computed properties:
    
    /// 'Bool' value indicating whether or not the 'Create Account' button is disabled:
    private var isCreateAccountButtonDisabled: Bool {
        email.isEmpty
        || password.isEmpty
        || confirmedPassword != password
        || !isAgreeToTermsAndConditions
    }
    
    /// Icon of the 'Terms and Conditions' button:
    private var termsAndConditionsButtonIcon: String {
        isAgreeToTermsAndConditions ? Icons.checkmarkCircle : Icons.circle
    }
    
    /// Symbol variant of the icon of the 'Terms and Conditions' button:
    private var termsAndConditionsButtonIconSymbolVariant: SymbolVariants {
        isAgreeToTermsAndConditions ? .fill : .none
    }
    
    /// Font of the icon of the 'Terms and Conditions' button:
    private var termsAndConditionsButtonIconFont: Font {
        isAgreeToTermsAndConditions ? .headline : .body
    }
    
    /// Color of the icon of the 'Terms and Conditions' button:
    private var termsAndConditionsButtonIconColor: Color {
        isAgreeToTermsAndConditions ? .accentColor : Color(.systemFill)
    }
    
    /// Frame of the 'Terms and Conditions' button:
    private var termsAndConditionsButtonFrame: Double {
        24
    }
    
    /// 'Bool' value indicating whether or not the content should be moved (When dynamic type's size is too large):
    private var shouldMoveContent: Bool {
        dynamicTypeSize >= .accessibility1
    }
    
    // MARK: - View:
    
    var body: some View {
        navigationStack
    }
    
    private var navigationStack: some View {
        NavigationStack {
            content
        }
    }
    
    private var content: some View {
        item
            .toolbar {
                cancelLoginButtonsToolbar
            }
            .animation(
                .default,
                value: isCreateAccountButtonDisabled
            )
            .animation(
                .default,
                value: isAgreeToTermsAndConditions
            )
    }
}

// MARK: - Item:

private extension Signup {
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
        scroll
        bottomToolbar
    }
}

// MARK: - Scroll:

private extension Signup {
    private var scroll: some View {
        ScrollView {
            scrollContent
        }
    }
    
    private var scrollContent: some View {
        scrollItem
            .padding(16)
            .padding(.bottom, 16)
    }
    
    private var scrollItem: some View {
        VStack(
            alignment: .center,
            spacing: 32
        ) {
            scrollItemContent
        }
    }
    
    @ViewBuilder
    private var scrollItemContent: some View {
        iconTitleText
        inputs
    }
}

// MARK: - Icon, title & text:

private extension Signup {
    private var iconTitleText: some View {
        VStack(
            alignment: .center,
            spacing: 24
        ) {
            iconTitleTextContent
        }
    }
    
    @ViewBuilder
    private var iconTitleTextContent: some View {
        icon
        titleText
    }
    
    private var icon: some View {
        Image("iconblue")
            .resizable()
            .frame(width: 100, height: 100)
            .padding()
    }
    
    private var titleText: some View {
        TitleTextView(
            title: "Welcome to MacroFlex",
            titleFont: Font.largeTitle.bold(),
            titleAlignment: .center,
            text: "Please create your free account below to start using our amazing app.",
            textFont: .title3,
            textAlignment: .center,
            alignment: .center,
            spacing: 16
        )
    }
}

// MARK: - Inputs:

private extension Signup {
    private var inputs: some View {
        VStack(
            alignment: .leading,
            spacing: 16
        ) {
            inputsContent
        }
    }
    
    @ViewBuilder
    private var inputsContent: some View {
        emailContent
        passwordContent
        confirmedPasswordContent
        termsAndConditions
    }
    
    private var emailContent: some View {
        TextFieldBackgroundView(
            text: $email,
            title: "Email",
            keyboardType: .emailAddress
        )
    }
    
    private var passwordContent: some View {
        TextFieldBackgroundView(
            text: $password,
            title: "Password",
            isSecure: true
        )
    }
    
    private var confirmedPasswordContent: some View {
        TextFieldBackgroundView(
            text: $confirmedPassword,
            title: "Confirm Password",
            isSecure: true
        )
    }
    
    @ViewBuilder
    private var termsAndConditions: some View {
        if shouldMoveContent {
            verticalTermsAndConditions
        } else {
            horizontalTermsAndConditions
        }
    }
    
    private var verticalTermsAndConditions: some View {
        VStack(
            alignment: .leading,
            spacing: 8
        ) {
            termsAndConditionsContent
        }
    }
    
    private var horizontalTermsAndConditions: some View {
        HStack(
            alignment: .top,
            spacing: 8
        ) {
            termsAndConditionsContent
        }
    }
    
    @ViewBuilder
    private var termsAndConditionsContent: some View {
        termsAndConditionsButton
        termsAndConditionsTitle
    }
    
    private var termsAndConditionsButton: some View {
        Button {
            agreeToTermsAndConditions()
        } label: {
            termsAndConditionsButtonLabel
        }
    }
    
    private var termsAndConditionsButtonLabel: some View {
        Image(systemName: termsAndConditionsButtonIcon)
            .symbolVariant(termsAndConditionsButtonIconSymbolVariant)
            .font(termsAndConditionsButtonIconFont)
            .foregroundColor(termsAndConditionsButtonIconColor)
            .frame(
                width: termsAndConditionsButtonFrame,
                height: termsAndConditionsButtonFrame,
                alignment: shouldMoveContent ? .leading : .center
            )
    }
    
    private var termsAndConditionsTitle: some View {
        Text("By signing up, I acknowledge that I have read and agree to our \(Text("[terms & conditions](https://www.designtech.so/appsources-terms-of-use)").underline().foregroundColor(.accentColor)) and \(Text("[privacy policy](https://www.designtech.so/appsources-privacy-policy)").underline().foregroundColor(.accentColor)).")
            .font(.footnote)
            .multilineTextAlignment(.leading)
            .foregroundColor(.secondary)
    }
}

// MARK: - Bottom toolbar:

private extension Signup {
    private var bottomToolbar: some View {
        BottomToolbarView(
            spacing: 16,
            isDividerShowing: true
        ) {
            createAccountButton
        }
    }
    
    private var createAccountButton: some View {
        ButtonView(
            title: "Create Account",
            isDisabled: isCreateAccountButtonDisabled
        ) {
            Task {

                do {
                    print("signing up")
//                    try await createUser()
                } catch {
                    print("something went wrong")
                }
            }
        }
    }
}

// MARK: - Cancel & login buttons toolbar:

private extension Signup {
    @ToolbarContentBuilder
    private var cancelLoginButtonsToolbar: some ToolbarContent {
        cancelButtonToolbar
        loginButtonToolbar
    }
    
    private var cancelButtonToolbar: some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            cancelButton
        }
    }
    
    private var cancelButton: some View {
        Button {
            dismiss.callAsFunction()
        } label: {
            cancelButtonLabel
        }
    }
    
    private var cancelButtonLabel: some View {
        Text("Cancel")
            .font(.headline)
            .foregroundColor(.accentColor)
    }
    
    private var loginButtonToolbar: some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            loginButton
        }
    }
    
    private var loginButton: some View {
        Button {
            login()
        } label: {
            loginButtonLabel
        }
    }
    
    private var loginButtonLabel: some View {
        Text("Login")
            .font(.headline)
            .foregroundColor(.accentColor)
    }
}

// MARK: - Functions:

private extension Signup {
    
    // MARK: - Private functions:
    
    /// Agrees to the terms & conditions:
    private func agreeToTermsAndConditions() {
        
        /// Toggling the 'isAgreeToTermsAndConditions' property:
        isAgreeToTermsAndConditions.toggle()
        
        /// Triggering the haptic feedback:
        HapticFeedbacks.selectionChanges()
    }
    
    /// Creates an account:
    private func createAccount() {
        
        /*
         
         NOTE: You can add your own logic for creating an account here.
         
         */
        
    }
    
    /// Lets the user to log in:
    private func login() {
        
        /*
         
         NOTE: You can add your own logic for logging the user in here.
         
         */
        
    }
}

// MARK: - Preview:

struct SignUpFiveView_Previews: PreviewProvider {
    static var previews: some View {
        RouterView { router in
            Signup(router: router)
        }
    }
}
