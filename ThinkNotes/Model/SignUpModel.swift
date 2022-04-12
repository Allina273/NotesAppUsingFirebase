//
//  SignUpModel.swift
//  ThinkNotes
//
//  Created by DianApps on 11/04/22.
//

import Foundation
import FirebaseAuth

protocol SignUpDelegate: AnyObject{
//    func CleanFields()
    func ShowError(_ message:String)
    func transitiontoHome()
    
}

class SignUpModel{
    var delegate:SignUpDelegate!
    
    func validatefields(_ Email:String,_ Password:String,_ RePassword:String) -> String? {
        if
            Email.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            Password.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            RePassword.trimmingCharacters(in: .whitespacesAndNewlines) == ""
     {
            
            return "Please fill in all fields."
        }
        // Check if the password is secure
                let correctPassword = Password.trimmingCharacters(in: .whitespacesAndNewlines)
                let rePassword = RePassword.trimmingCharacters(in: .whitespacesAndNewlines)
                
                if isPasswordValid(correctPassword) == false {
                    // Password isn't secure enough
                    return "Please make sure your password is at least 8 characters, contains a special character and a number."
                    
                } else if passwordSame(correctPassword: correctPassword, RePassword: rePassword) == false {
                    return "Password doesnt match"
                }
                else{
//                    passwordSame(correctPassword: correctPassword, RePassword: rePassword) == true
                }
                return nil
                
    }
    
    

//    for password Validation
    
    func isPasswordValid(_ password : String) -> Bool {
        
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
    //  Check if the password and re type password matches
    func passwordSame(correctPassword: String, RePassword: String) -> Bool{
          if correctPassword == RePassword{
              return true

               } else {

                 print("Password Does Not Match Confirm Password")
                   return false
               }
          }

    func createUser(_ Email:String,_ Password:String,_ RePassword:String){
//        Create cleaned versions of the data
              
                 
                 let email = Email.trimmingCharacters(in: .whitespacesAndNewlines)
                 let password = Password.trimmingCharacters(in: .whitespacesAndNewlines)
                 _ = RePassword.trimmingCharacters(in: .whitespacesAndNewlines)

                 // Create the user
        Auth.auth().createUser(withEmail: email, password: password) { [self] (result, err) in

                     // Check for errors
                     if err != nil {

                         // There was an error creating the user

                         delegate?.ShowError("Error creating user")
    }
            else {
//
                // User was created successfully, now store the first name and last name in the firestore Database
//                    let db = Firestore.firestore()
//
//                    var ref: DocumentReference?
//                    ref = db.collection("notes-items").addDocument(data: ["firstname":firstName, "lastname":lastName, "email": email, "uid": result!.user.uid ]) { (error) in
//
//                        if error != nil {
//                            // Show error message
//                            self.showError("Error saving user data")
//
////                    // Transition to the home screen
//                    let email = Auth.auth().currentUser?.email
                delegate?.transitiontoHome()
            }
                 }
  
}
}
