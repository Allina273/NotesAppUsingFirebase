//
//  ViewController.swift
//  ThinkNotes
//
//  Created by Raj Kumari Soren on 17/03/22.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {
 
    @IBOutlet weak var EmailTextfield: UITextField!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var errorlabel: UILabel!
    
    @IBOutlet weak var newLabel: UILabel!
    @IBOutlet weak var LoginButton: UIButton!
    @IBOutlet weak var passwordTextfield: UITextField!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
        errorlabel.alpha = 0
        
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if let _ = Auth.auth().currentUser{

            self.transitionToHome()
        }
    }

    func setUpElements(){
        Utilities.styleTextField(EmailTextfield)
        Utilities.styleTextField(passwordTextfield)
        Utilities.styleFilledButton(LoginButton)
        Utilities.styleHollowButton(signupButton)
    
    }
    @IBAction func loginTapped(_ sender: Any) {
        
//        /Validate Text Fields
        
        // Create cleaned versions of the text field
        let email = EmailTextfield.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextfield.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // Signing in the user
      
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
           
            if error != nil {
                // Couldn't sign in
                self.errorlabel.text = error!.localizedDescription
                self.errorlabel.alpha = 1
            }
//            else {
////                self.errorlabel.alpha = 1
////                self.errorlabel.text = "Successfully Logged IN"
                // Transition to the home screen
//                self.transitionToHome()
//            }
            self.transitionToHome()
    
    }
    }
    func transitionToHome() {

        let homeViewController = storyboard?.instantiateViewController(identifier: "home") as! HomeViewcontroller
        self.navigationController?.pushViewController(homeViewController, animated: true)
//        self.view.window?.rootViewController = homeViewController
        self.view.window?.makeKeyAndVisible()

    }
    }
    
    
    




