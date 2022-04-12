//
//  HomeViewModel.swift
//  ThinkNotes
//
//  Created by DianApps on 11/04/22.
//

import Foundation
import Firebase
protocol HomeViewModelDelegate:AnyObject{
    func showTable()
   func navigationRootPop()
    func navigationpop()
    func reloadTable()
  
}
class HomeViewModel{
 
    // MARK: Properties
    var title = "New Note"
    var user: User!
    var ref : DatabaseReference!
    private var databasehandle: DatabaseHandle!
    var items: [Item] = []
    var delegate:HomeViewModelDelegate!
    

    func currentUser(){
        user = Auth.auth().currentUser
        ref = Database.database().reference()
    }
    func startObservingDatabase(){
        databasehandle = ref.child("users/\(self.user.uid)/items").observe(.value, with: { [self] (snapshot) in
           
            var newItems : [Item] = []
//
            for itemSnapShot in snapshot.children {
                let item = Item(snapshot: itemSnapShot as! DataSnapshot)
                newItems.append(item)
                self.delegate?.showTable()
              
            }
          
            
            self.items = newItems
            print(self.items as Any)
            
            DispatchQueue.main.async {
                self.delegate?.reloadTable()
            }
        
        })
    }
    deinit{
        ref.child("users/\(self.user.uid)/items").removeObserver(withHandle: databasehandle)
    }
    func newNote(_ noteTitle:String, _ note: String,_ completed: Bool){

            let notesItem = Item(title: noteTitle,note:note,completed: false)
            
            self.ref.child("users").child(self.user.uid).child("items").childByAutoId().setValue(notesItem.toAnyObject())

        delegate?.showTable()
     
    }
    
    func update(_ toggledCompletion:Bool,_ indexPath:Int){
        let item = items[indexPath]
        item.ref?.updateChildValues(["completed": toggledCompletion])

    }
    func delete(_ indexPath:Int){
        let item = items[indexPath]
        item.ref?.removeValue()
    }
    func updateItem(_ noteTitlee:String,_ notee:String,_ completedd:Bool,_ indexPath:Int){
        let model = items[indexPath]
        let updateItem = Item(title: noteTitlee,note:notee, completed: completedd)
       model.ref?.updateChildValues(updateItem.toAnyObject() as! [AnyHashable : Any])
    }
    func signOut(){
        do {
            try Auth.auth().signOut()
            delegate?.navigationRootPop()
        } catch let error {
            print("Auth sign out failed: \(error)")
        }
    }
}





































//    func saveEntry(_ title:String,_ note:String) -> (String,String){
//        let notetitle = title
//        let notee = note
//        let result = (notetitle,notee)
//        return result
//    }
