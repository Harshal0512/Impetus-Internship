//
//  AppViewModel.swift
//  Impetus
//
//  Created by Harshal Kulkarni on 29/04/22.
//

import Foundation
import FirebaseAuth

class AppViewModel: ObservableObject {
    
    let auth = Auth.auth()
    
    @Published var signedIn = false
    @Published var wrongCredentialsToast = false
    @Published var authenticatedToast = false
    
    var isSignedIn: Bool {
        return auth.currentUser != nil
    }
    
    func signIn(email: String, password: String, completionHandler: @escaping (Bool) -> ()) {
        auth.signIn(withEmail: email, password: password) { [weak self] result, error in
            guard result != nil, error == nil else {
                self?.wrongCredentialsToast.toggle()
                completionHandler(false)
                return
            }
            
            //success
            self?.authenticatedToast = true
            DispatchQueue.main.async {
                self?.signedIn = true
                completionHandler(true)
            }
        }
    }
    
    
    func signUp(email: String, password: String, completionHandler: @escaping (Bool) -> ()) {
        auth.createUser(withEmail: email, password: password) { [weak self] result, error in
            guard result != nil, error == nil else {
                completionHandler(false)
                return
            }
            
            //success
            DispatchQueue.main.async {
                self?.signedIn = true
                self?.authenticatedToast = true
                completionHandler(true)
            }
        }
    }
    
    func logout() {
        do {
            try auth.signOut()
            
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
            return
        }
        
        DispatchQueue.main.async {
            self.signedIn = false
            self.authenticatedToast = false
        }
    }
    
}
