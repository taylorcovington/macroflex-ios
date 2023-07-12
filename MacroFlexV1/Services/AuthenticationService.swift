//
//  AuthenticationService.swift
//  AuthApp
//
//  Created by Neal Archival on 7/16/22.
//

import Foundation
//import FirebaseAuth
//import Supabase

class AuthService: ObservableObject {
    
//    @Published var userSession: LoggedInUser
    @Published var isUserLoggedIn = false
    @Published var token = ""
    
    static let shared = AuthService()
   
    
    init() {
        // check to see if user is logged in
//        self.userSession = Auth.auth().currentUser
        print("initializing")
    }
    
    func login(withEmail email: String, password: String) async throws {
        let url = URL(string: "http://192.168.1.209:8080/api/auth")!
    //    "https://macroflex-server-stg.herokuapp.com/api/demo/stats")!
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
   
   let loginData = LoginRequest(email: email, password: password)
   
   do {
       let jsonData = try JSONEncoder().encode(loginData)
       urlRequest.httpBody = jsonData
       
       let (data, response) = try await URLSession.shared.data(for: urlRequest)
       // Handle the response data as needed
       
       let jsonResData = try JSONDecoder().decode(LoggedInUser.self, from: data)

       print(jsonResData.token)
       token = jsonResData.token
       isUserLoggedIn = true
   } catch {
       print("Error encoding JSON: \(error)")
   }

    }
    
    func createUser(email: String, password: String, username: String) async throws {
        print("creatingUser")
        
    }
    
    func loadUserData() async throws {
        
    }
    
    func signout() {
        
    }
}



//struct LoginRequest: Codable {
//    let email: String
//    let password: String
//}
//
//struct LoggedInUser: Codable {
//    let token: String
//    let subscription: String
//    let plan: String
//    let permission: String
//    let name: String
//    let accounts: [Account]
//    let accountID: String
//    let hasPassword: Bool
//    let onboarded: Bool
//    let verified: Bool
//
//    enum CodingKeys: String, CodingKey {
//        case token, subscription, plan, permission, name, accounts
//        case accountID = "account_id"
//        case hasPassword = "has_password"
//        case onboarded, verified
//    }
//}
//
//struct Account: Codable {
//    let id: String
//    let name: String
//    let permission: String
//}
