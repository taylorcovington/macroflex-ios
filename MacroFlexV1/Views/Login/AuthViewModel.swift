//
//  RegistrationViewModel.swift
//  MacroFlexV1
//
//  Created by Taylor Covington on 6/9/23.
//

import Foundation
import JWTDecode


class AuthViewModel: ObservableObject {
    @Published var isAuthenticated = false
    private let tokenKey = "AuthToken"
    
    init() {
        checkTokenExpiration()
    }

    func authenticateUser(with request: LoginRequest, completion: @escaping (Bool, String?) -> Void) {
        // Perform API request to authenticate the user
        // Assuming the API endpoint is /login and returns a result
        guard let url = URL(string: "http://192.168.1.209:8080/api/auth") else {
            return
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = try? JSONEncoder().encode(request)
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let data = data else {
                completion(false, "Network Error")
                // Handle error
                return
            }

            if let response = try? JSONDecoder().decode(LoginResponse.self, from: data) {
                if let errorMessage = response.message {
                    if let inputError = response.inputError, inputError == "password" {
                        print("There was a password error")
                        completion(false, errorMessage)
                    } else {
                        print("There was an error but not a password error")
                        completion(false, errorMessage)
                    }
                } else {
                    self.isAuthenticated = true
                    completion(true, nil)
                }
          } else {
              completion(false, "Invalid Response")
          }
        }.resume()
    }
    
    func logout() {
           isAuthenticated = false
           UserDefaults.standard.removeObject(forKey: tokenKey)
       }
    
    private func saveAuthToken(_ token: String) {
           UserDefaults.standard.set(token, forKey: tokenKey)
       }
    
    private func checkTokenExpiration() {
            guard let token = UserDefaults.standard.string(forKey: tokenKey) else {
                return
            }

            // Perform token expiration check, e.g., by decoding the token and checking the expiration date
            // If the token is expired, reset the authentication state
            let isTokenExpired = isTokenExpired(token) // Implement this method according to your token format and expiration logic

            if isTokenExpired {
                isAuthenticated = false
                UserDefaults.standard.removeObject(forKey: tokenKey)
            } else {
                isAuthenticated = true
            }
        }

    private func isTokenExpired(_ token: String) -> Bool {
        do {
            let jwt = try decode(jwt: token)
            
            guard let expirationTimeInterval = jwt.claim(name: "exp").double else {
                // Token does not have a valid expiration claim
                return false
            }
            
            let expirationDate = Date(timeIntervalSince1970: expirationTimeInterval)
            return expirationDate < Date()
        } catch {
            // Error decoding the token or accessing the expiration claim
            return false
        }
    }

}
    

enum LoginError: Error {
    case loginFailed
}

enum SignupError: Error {
    case signupFailed
}

    struct LoginRequest: Codable {
        let email: String
        let password: String
    }

    struct LoggedInUser: Codable {
        let token: String
        let subscription: String
        let plan: String
        let permission: String
        let name: String
        let accounts: [Account]
        let accountID: String
        let hasPassword: Bool
        let onboarded: Bool
        let verified: Bool

        enum CodingKeys: String, CodingKey {
            case token, subscription, plan, permission, name, accounts
            case accountID = "account_id"
            case hasPassword = "has_password"
            case onboarded, verified
        }
    }

    struct Account: Codable {
        let id: String
        let name: String
        let permission: String
    }

struct LoginResponse: Codable {
    let message: String?
    let inputError: String?
}

//class AuthViewModel: ObservableObject {
 
//}
