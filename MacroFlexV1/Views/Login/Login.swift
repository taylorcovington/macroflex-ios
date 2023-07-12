//
//  LoginFiveView.swift
//  App.io
//

import SwiftUI
import SwiftfulRouting

struct LoginFiveView: View {
    let router: AnyRouter
    @ObservedObject var authViewModel: AuthViewModel
    @State private var email = ""
    @State private var password = ""
    @EnvironmentObject var userData: UserData
    @State private var showAlert = false
    @State private var alertMessage = ""
//    @EnvironmentObject var viewModel: AuthViewModel
    
    /// Dismisses the view:
    @Environment (\.dismiss) private var dismiss
    
    /// 'Bool' value indicating whether or not the 'Login' button is disabled:
    private var isLoginButtonDisabled: Bool {
        email.isEmpty
        || password.isEmpty
    }
    
    // MARK: - View:
    
    var body: some View {
        navigationStack
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Login Failed"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
    }
        
    
    private var navigationStack: some View {
        NavigationStack {
            content
        }
    }
    
    private var content: some View {
        item
//            .toolbar {
//                cancelSignUpButtonsToolbar
//            }
            .animation(
                .default,
                value: isLoginButtonDisabled
            )
    }
}

// MARK: - Item:

private extension LoginFiveView {
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

private extension LoginFiveView {
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

private extension LoginFiveView {
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
            text: "Please enter your account details below to start tracking your fitness journey.",
            textFont: .title3,
            textAlignment: .center,
            alignment: .center,
            spacing: 16
        )
    }
}

// MARK: - Inputs:

private extension LoginFiveView {
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
}

// MARK: - Bottom toolbar:

private extension LoginFiveView {
    private var bottomToolbar: some View {
        BottomToolbarView(
            spacing: 16,
            isDividerShowing: true
        ) {
            bottomToolbarContent
        }
    }
    
    @ViewBuilder
    private var bottomToolbarContent: some View {
        loginButton
        forgotPasswordButton
    }
    
    private var loginButton: some View {
        ButtonView(
            title: "Login",
            isDisabled: isLoginButtonDisabled
        ) {
            Task {
                do {
                    // I want to return if user is authenicated
                    
//                   let loginRequest = try await viewModel.login()
                    
                    // Perform login request
                    // Perform login request
                    let loginRequest = LoginRequest(email: email, password: password)
                    authViewModel.authenticateUser(with: loginRequest) { success, error in
                        if !success, let error = error {
                            showAlert = true
                            alertMessage = error
                        }
                    }
                    
//                    let logingRequest =  LoginRequest(email: email, password: password)
//
//                    let res = try await viewModel.login()
                   
                    
                } catch {
                    print("something went wrong")
                }
                
            }
        }
    }
    
    private var forgotPasswordButton: some View {
        ButtonView(
            title: "Sign up",
            color: .accentColor,
            verticalPadding: 0,
            horizontalPadding: 0,
            backgroundColor: .clear
        ) {
//            forgotPassword()
//            TODO: Navigate to sign up
            
                router.showScreen(.fullScreenCover) { router in
                    Signup(router: router)
                        .environmentObject(authViewModel)
                }
            
        }
    }
}

// MARK: - Cancel & sign up buttons toolbar:

private extension LoginFiveView {
    @ToolbarContentBuilder
    private var cancelSignUpButtonsToolbar: some ToolbarContent {
        cancelButtonToolbar
        signUpButtonToolbar
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
    
    private var signUpButtonToolbar: some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            signUpButton
        }
    }
    
    private var signUpButton: some View {
        Button {
            signUp()
        } label: {
            signUpButtonLabel
        }
    }
    
    private var signUpButtonLabel: some View {
        Text("Sign Up")
            .font(.headline)
            .foregroundColor(.accentColor)
    }
}

// MARK: - Functions:

private extension LoginFiveView {
    
    // MARK: - Private functions:
    
    /// Lets the user to log in:
    private func login() async throws {
     
//
//    let (data, response) = try await URLSession.shared.data(from: url)
//
//    guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
//        throw UError.invalidResponse
//    }
//
//    do {
//        let decoder = JSONDecoder()
//        decoder.keyDecodingStrategy = .convertFromSnakeCase
//        return try decoder.decode(User.self, from: data)
//    } catch {
//        throw UError.invalidData
//    }
        
        /*
         
         NOTE: You can add your own logic for logging the user in here.
         
         */
        
    }
    
    /// Lets the user reset the password.
    private func forgotPassword() {
        
        /*
         
         NOTE: You can add your own logic for resetting the password here.
         
         */
        
    }
    
    /// Lets the user sign up:
    private func signUp() {
        
       
        
        /*
         
         NOTE: You can add your own logic for signing up here.
         
         */
        
        
    }
}

// MARK: - Preview:

//struct LoginFiveView_Previews: PreviewProvider {
//    static var previews: some View {
//
//        RouterView { router in
//            LoginFiveView(router: router, )
//        }
//    }
//}

enum UError: Error {
    case invalidUrl
    case invalidResponse
    case invalidData
}

// api/auth

//await Axios({
//
//        data: data,
//        url: props.url,
//        method: props.method
//
//      });
//"baseURL": "http://192.168.1.209:8080",


struct User: Codable {
    let name: String
}
