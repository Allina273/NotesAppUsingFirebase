//
//  LoginViewModel.swift
//  ThinkNotes
//
//  Created by DianApps on 12/04/22.
//
protocol LoginDelegate:AnyObject{
  func ShowError(_ message:String)
    func transitionToHome()
}
import Foundation
import FirebaseAuth
class LoginViewModel{
    weak var delegate : LoginDelegate!
    func currentUser(){
        if let _ = Auth.auth().currentUser{

            delegate?.transitionToHome()
        }
    }
    func signInUser(_ Email:String,_ password:String){
        
        // Create cleaned versions of the text field
        let email = Email.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = password.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Signing in the user
      
        Auth.auth().signIn(withEmail: email, password: password) { [self] (user, error) in
           
            if error != nil {
                // Couldn't sign in
                delegate?.ShowError(error!.localizedDescription)
            }
//            else {
////                self.errorlabel.alpha = 1
////                self.errorlabel.text = "Successfully Logged IN"
                // Transition to the home screen
//                self.transitionToHome()
//            }
            delegate?.transitionToHome()
    
    }
    }
}
