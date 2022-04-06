//
//  PasswordTextField.swift
//  ThinkNotes
//
//  Created by Raj Kumari Soren on 05/04/22.
//

import UIKit

class PasswordTextField: UITextField {
    
    
    
    

    override init(frame: CGRect) {
            super.init(frame: frame)
            setup()
        }

        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            setup()
        }
        
         func setup() {
            self.isSecureTextEntry = true
            
            //show/hide button
             let button = UIButton(type: .custom)
             button.setImage(UIImage(systemName: "eye"), for: .selected)
             button.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)

             button.frame = CGRect(x: 0, y: 0, width: -12, height: 0)
             button.addTarget(self, action: #selector(showHidePassword(_:)), for: .touchUpInside)
             button.tintColor = UIColor.init(red: 57/255, green: 126/255, blue: 247/255, alpha: 1)
             button.alpha = 1.0
             rightView = button
             rightViewMode = .always
        
           
        }
        
        @objc private func showHidePassword(_ sender: UIButton) {
            sender.isSelected = !sender.isSelected
            self.isSecureTextEntry = !sender.isSelected

        }
        
    }












































//            let img1 = UIImage(named: "")
//            let img2 = UIImage(named: "")
//            let tintedImage = img1?.withRenderingMode(.alwaysOriginal)
//            let tintedImage2 = img2?.withRenderingMode(.alwaysOriginal)
//            button.setImage(tintedImage, for: .normal)
//            button.setImage(tintedImage2, for: .normal)
//             button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -12, bottom: 0, right: 0)
