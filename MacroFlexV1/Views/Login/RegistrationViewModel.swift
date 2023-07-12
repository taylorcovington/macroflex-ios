////
////  RegistrationViewModel.swift
////  MacroFlexV1
////
////  Created by Taylor Covington on 6/9/23.
////
//
//import Foundation
//
//class RegistrationViewModel: ObservableObject {
//    @Published var username = ""
//    @Published var email = ""
//    @Published var password  = ""
//    @Published var isUserLoggedIn = false
//    @Published var token = ""
//
//
//    func createUser() async throws {
//        let url = URL(string: "http://192.168.1.209:8080/api/auth/signup")!
//
//        var urlRequest = URLRequest(url: url)
//        urlRequest.httpMethod = "POST"
//        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
//
//        let signupData = LoginRequest(email: email, password: password)
//
//        do {
//            let jsonData = try JSONEncoder().encode(signupData)
//            urlRequest.httpBody = jsonData
//
//            let (data, response) = try await URLSession.shared.data(for: urlRequest)
//
//            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
//                // Signup successful, handle response if needed
//            } else {
//                // Signup failed, handle error scenario
//                throw SignupError.signupFailed
//            }
//        } catch {
//            // Error during signup, handle the error
//            throw error
//        }
//    }
//
//    func login() async {
//        do {
//            let url = URL(string: "http://192.168.1.209:8080/api/auth")!
//            var urlRequest = URLRequest(url: url)
//            urlRequest.httpMethod = "POST"
//            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
//
//            let loginData = LoginRequest(email: email, password: password)
//            let jsonData = try JSONEncoder().encode(loginData)
//            urlRequest.httpBody = jsonData
//
//            let (data, response) = try await URLSession.shared.data(for: urlRequest)
//
//            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
//                let jsonResData = try? JSONDecoder().decode(LoggedInUser.self, from: data)
//                print("TOKEN >>>> \(jsonResData?.token)")
//                DispatchQueue.main.async {
//                    self.token = jsonResData?.token ?? ""
//                    self.isUserLoggedIn = true
//                }
//            } else {
//                // Login failed, handle error scenario
//                // You can show an error message or perform any other action here
//            }
//        } catch {
//            // Error during login, handle the error
//            // You can show an error message or perform any other action here
//        }
//    }
//
//
//    }
//
//
//enum LoginError: Error {
//    case loginFailed
//}
//
//enum SignupError: Error {
//    case signupFailed
//}
//
//    struct LoginRequest: Codable {
//        let email: String
//        let password: String
//    }
//
//    struct LoggedInUser: Codable {
//        let token: String
//        let subscription: String
//        let plan: String
//        let permission: String
//        let name: String
//        let accounts: [Account]
//        let accountID: String
//        let hasPassword: Bool
//        let onboarded: Bool
//        let verified: Bool
//
//        enum CodingKeys: String, CodingKey {
//            case token, subscription, plan, permission, name, accounts
//            case accountID = "account_id"
//            case hasPassword = "has_password"
//            case onboarded, verified
//        }
//    }
//
//    struct Account: Codable {
//        let id: String
//        let name: String
//        let permission: String
//    }
