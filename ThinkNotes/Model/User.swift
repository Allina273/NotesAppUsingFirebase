//
//  User.swift
//  ThinkNotes
//
//  Created by DianApps on 25/03/22.
//

import Foundation
import Firebase

struct User: Codable{
    let uid:String
//    let email: String
    
    init(authData:Firebase.User){
    uid = authData.uid
}
init(uid:String){
    self.uid = uid}
}
