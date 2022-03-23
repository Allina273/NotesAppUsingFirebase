//
//  SignupViewController.swift
//  ThinkNotes
//
//  Created by Raj Kumari Soren on 17/03/22.
//

import Foundation
import UIKit
import FirebaseAuth
import Firebase

class SignupViewController: UIViewController{
    
    @IBOutlet weak var Firstname: UITextField!
    @IBOutlet weak var Lastname: UITextField!
    @IBOutlet weak var Password: UITextField!
    
    @IBOutlet weak var Email: UITextField!
    @IBOutlet weak var RePassword: UITextField!
    
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var SignupButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
    }
    
    func setUpElements(){
        
//        hide error label when signing up
        
        errorLabel.alpha = 0
        
//        style the textFields
        
        Utilities.styleTextField(Firstname)
        Utilities.styleTextField(Lastname)
        Utilities.styleTextField(Password)
        Utilities.styleTextField(RePassword)
        Utilities.styleTextField(Email)
        Utilities.styleFilledButton(SignupButton)
    }
    
    // Check the fields for the entered data and validate if the data is correct. If everything is correct, this method returns nil. Otherwise, it returns the error message
    func validateFields() -> String? {
        
        // Check that all fields are filled in
        if Firstname.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            Lastname.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            Email.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            Password.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            RePassword.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
     {
            
            return "Please fill in all fields."
        }
        // Check if the password is secure
        let cleanedPassword = Password.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if isPasswordValid(cleanedPassword) == false {
            // Password isn't secure enough
            return "Please make sure your password is at least 8 characters, contains a special character and a number."
        }
        
        return nil
    }
    
    
        
    //    for password Validation
        
        func isPasswordValid(_ password : String) -> Bool {
            
            let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
            return passwordTest.evaluate(with: password)
        }
    
    
    @IBAction func signupTapped(_ sender: Any) {
        // Validate the fields
        let error = validateFields()
        
        if error != nil {
            
            // There's something wrong with the fields, show error message
            showError(error!)
        }
        else {
            
            // Create cleaned versions of the data
            let firstName = Firstname.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = Lastname.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = Email.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = Password.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            // Create the user
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                
                // Check for errors
                if err != nil {
                    
                    // There was an error creating the user
                    self.showError("Error creating user")
                }
                else {
                    
                    // User was created successfully, now store the first name and last name
                    let db = Firestore.firestore()
                    
                    var ref: DocumentReference? = nil
                    ref = db.collection("users").addDocument(data: ["firstname":firstName, "lastname":lastName, "email": email, "uid": result!.user.uid ]) { (error) in
                        
                        if error != nil {
                            // Show error message
                            self.showError("Error saving user data")
                        }
                    }
                    
                    // Transition to the home screen
                    self.transitionToHome()
                }
                
            }
            
            
            
        }
    }
    
    func showError(_ message:String) {
        
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    func transitionToHome() {

        let homeViewController = storyboard?.instantiateViewController(identifier: "home") as! HomeViewcontroller
        self.navigationController?.pushViewController(homeViewController, animated: true)
//        self.view.window?.rootViewController = homeViewController
        self.view.window?.makeKeyAndVisible()

    }
    
}



        
    
    
    


