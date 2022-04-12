//
//  SignupViewController.swift
//  ThinkNotes
//
//  Created by Raj Kumari Soren on 17/03/22.
//

import Foundation
import UIKit

class SignupViewController: UIViewController {
    
    private var viewModel = SignUpModel()
    
    @IBOutlet weak var Firstname: UITextField!
    @IBOutlet weak var Lastname: UITextField!
    @IBOutlet weak var Password: UITextField!
    @IBOutlet weak var Email: UITextField!
    @IBOutlet weak var RePassword: UITextField!
    
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var SignupButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        setUpElements()
    }
    
    func setUpElements(){
        
        // hide error label when signing up
        
        errorLabel.alpha = 0
        
        //style the textFields
        
        Utilities.styleTextField(Firstname)
        Utilities.styleTextField(Lastname)
        Utilities.styleTextField(Password)
        Utilities.styleTextField(RePassword)
        Utilities.styleTextField(Email)
        Utilities.styleFilledButton(SignupButton)
    }
    
    
    @IBAction func signupTapped(_ sender: Any) {
        // Validate the fields
        let error = viewModel.validatefields(Email.text!, Password.text!, RePassword.text!)
        
        if error != nil {
            
            // There's something wrong with the fields, show error message
            ShowError(error!)
        }
        else {
            //create user
            viewModel.createUser(Email.text!, Password.text!, RePassword.text!)
        }
    }
    
}

extension SignupViewController:SignUpDelegate{

    func ShowError(_ message: String) {
        self.errorLabel.text = message
        self.errorLabel.alpha = 1
    }
    
    func transitiontoHome(){
        let homeViewController = storyboard?.instantiateViewController(identifier: "home") as! HomeViewcontroller
        self.navigationController?.pushViewController(homeViewController, animated: true)
        //        self.view.window?.rootViewController = homeViewController
        self.view.window?.makeKeyAndVisible()
    }
    
}






















































// Check the fields for the entered data and validate if the data is correct. If everything is correct, this method returns nil. Otherwise, it returns the error message
//    func validateFields() -> String? {
//
//        // Check that all fields are filled in
////        if Firstname.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
////            Lastname.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
//        viewModel.cleanfields(Email.text, Password.text, RePassword.text)
//        if
//            Email.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
//            Password.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
//            RePassword.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
//     {
//
//            return "Please fill in all fields."
//        }
//        // Check if the password is secure
//                let correctPassword = Password.text!.trimmingCharacters(in: .whitespacesAndNewlines)
//                let rePassword = RePassword.text!.trimmingCharacters(in: .whitespacesAndNewlines)
//
//                if isPasswordValid(correctPassword) == false {
//                    // Password isn't secure enough
//                    return "Please make sure your password is at least 8 characters, contains a special character and a number."
//
//                } else if passwordSame(correctPassword: correctPassword, RePassword: rePassword) == false {
//                    return "Password doesnt match"
//                }
//                else{
//                    passwordSame(correctPassword: correctPassword, RePassword: rePassword) == true
//                }
//                return nil
//
//    }


////                //  Check if the password and re type password matches
//                func passwordSame(correctPassword: String, RePassword: String) -> Bool{
//                if correctPassword == RePassword{
//                    return true
//
//                     } else {
//
//                       print("Password Does Not Match Confirm Password")
//                         return false
//                     }
////
//
//
//
//    }
////    for password Validation
//
//    func isPasswordValid(_ password : String) -> Bool {
//
//        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
//        return passwordTest.evaluate(with: password)
//    }







///             Create cleaned versions of the data
//            let firstName = Firstname.text!.trimmingCharacters(in: .whitespacesAndNewlines)
//            let lastName = Lastname.text!.trimmingCharacters(in: .whitespacesAndNewlines)
//
//            let email = Email.text!.trimmingCharacters(in: .whitespacesAndNewlines)
//            let password = Password.text!.trimmingCharacters(in: .whitespacesAndNewlines)
//            _ = RePassword.text!.trimmingCharacters(in: .whitespacesAndNewlines)
//
//            // Create the user
//            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
//
//                // Check for errors
//                if err != nil {
//
//                    // There was an error creating the user
//                    self.showError("Error creating user")
////
//                }
//                else {
////
//                    // User was created successfully, now store the first name and last name in the firestore Database
////                    let db = Firestore.firestore()
////
////                    var ref: DocumentReference?
////                    ref = db.collection("notes-items").addDocument(data: ["firstname":firstName, "lastname":lastName, "email": email, "uid": result!.user.uid ]) { (error) in
////
////                        if error != nil {
////                            // Show error message
////                            self.showError("Error saving user data")
////
//////                    // Transition to the home screen
////                    let email = Auth.auth().currentUser?.email
//                    self.transitionToHome()
//                }









//    func transitionToHome() {
//
//        let homeViewController = storyboard?.instantiateViewController(identifier: "home") as! HomeViewcontroller
//        self.navigationController?.pushViewController(homeViewController, animated: true)
////        self.view.window?.rootViewController = homeViewController
//        self.view.window?.makeKeyAndVisible()
//
//    }
