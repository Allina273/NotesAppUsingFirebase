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
    
//    @IBOutlet weak var ImageLabel: UILabel!
//    @IBOutlet weak var noteImg: UIImageView!

    @IBOutlet weak var newLabel: UILabel!
    @IBOutlet weak var LoginButton: UIButton!
    @IBOutlet weak var passwordTextfield: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
        
        
        // Do any additional setup after loading the view.
    }
    func setUpElements(){
        Utilities.styleTextField(EmailTextfield)
        Utilities.styleTextField(passwordTextfield)
        Utilities.styleFilledButton(LoginButton)
        Utilities.styleHollowButton(signupButton)
    
    }
    
    


}

