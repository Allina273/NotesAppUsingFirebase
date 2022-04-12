//
//  ViewController.swift
//  ThinkNotes
//
//  Created by Raj Kumari Soren on 17/03/22.
//

import UIKit

class ViewController: UIViewController {
 
    @IBOutlet weak var EmailTextfield: UITextField!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var errorlabel: UILabel!
    @IBOutlet weak var newLabel: UILabel!
    @IBOutlet weak var LoginButton: UIButton!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    private var viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
        errorlabel.alpha = 0
        viewModel.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.EmailTextfield.text = nil
        self.passwordTextfield.text = nil
        EmailTextfield.becomeFirstResponder()
        viewModel.currentUser()
    }
    
    func setUpElements(){
        Utilities.styleTextField(EmailTextfield)
        Utilities.styleTextField(passwordTextfield)
        Utilities.styleFilledButton(LoginButton)
        Utilities.styleHollowButton(signupButton)
    }
    
    @IBAction func loginTapped(_ sender: Any) {

        viewModel.signInUser(EmailTextfield.text!, passwordTextfield.text!)
    }
    
    }

extension ViewController:LoginDelegate{
    func ShowError(_ message: String) {
        self.errorlabel.text = message
        self.errorlabel.alpha = 1
    }
    
    func transitionToHome() {

        let homeViewController = storyboard?.instantiateViewController(identifier: "home") as! HomeViewcontroller
        self.navigationController?.pushViewController(homeViewController, animated: true)
//        self.view.window?.rootViewController = homeViewController
        self.view.window?.makeKeyAndVisible()

    }  
}




