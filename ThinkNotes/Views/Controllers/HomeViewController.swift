//
//  HomeViewController.swift
//  ThinkNotes
//
//  Created by DianApps on 23/03/22.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth
import SwiftUI


class HomeViewcontroller: UIViewController,UITableViewDelegate,UITableViewDataSource{
    


    // MARK: Properties
    var user: User!
    var ref : DatabaseReference!
    private var databasehandle: DatabaseHandle!
    var items: [Item] = []

    

    @IBOutlet weak var noNOtes: UILabel!
    @IBOutlet weak var tblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        user = Auth.auth().currentUser
        ref = Database.database().reference()

        
        self.tblView.delegate = self
        self.tblView.dataSource = self
        navigationItem.hidesBackButton  = true
//        title = "ThinkNotes"
//    
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startObservingDatabase()
    }
    func startObservingDatabase(){
        databasehandle = ref.child("users/\(self.user.uid)/items").observe(.value, with: { (snapshot) in
           
            var newItems : [Item] = []
//
            for itemSnapShot in snapshot.children {
                let item = Item(snapshot: itemSnapShot as! DataSnapshot)
                newItems.append(item)
//
                self.tblView.isHidden = false
                self.noNOtes.isHidden = true
               
            }
          
            
            self.items = newItems
            print(self.items as Any)
            
            DispatchQueue.main.async {
                self.tblView.reloadData()
            }
        
        })
    }
    deinit{
        ref.child("users/\(self.user.uid)/items").removeObserver(withHandle: databasehandle)
    }

    // MARK: UITableView Delegate methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemcell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row].title
        cell.detailTextLabel?.text = items[indexPath.row].note
        
//        if model.completed == false{


        toggleCellCheckbox(cell, isCompleted: model.completed ?? false)
       
        return cell
    }
    
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//                    let item = items[indexPath.row]
//                    item.ref?.removeValue()
//        }

//    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
            guard let cell = tableView.cellForRow(at: indexPath) else { return nil }
            let model = items[indexPath.row]
            let completeTitleAction = model.completed! ? "Mark Not Complete" : "Mark Complete"
            self.items[indexPath.row].completed?.toggle()
        
            let completeAction = UITableViewRowAction(style: .normal, title: completeTitleAction){_, indexPath in

                let item = self.items[indexPath.row]
                let toggledCompletion = item.completed!

                self.toggleCellCheckbox(cell, isCompleted: toggledCompletion)
                item.ref?.updateChildValues(["completed": toggledCompletion])
//                self.tblView.reloadRows(at: [indexPath], with: .automatic)
        }
        completeAction.backgroundColor = .cyan
        
            let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete"){  _,indexPath in
            let item = self.items[indexPath.row]
            item.ref?.removeValue()}
         
        return [deleteAction, completeAction]
      }
    

   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
      
        let model = items[indexPath.row]


//        // Show note controller
        guard let vc = storyboard?.instantiateViewController(identifier: "note") as? NoteViewController else {
            return
        }
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.title = "Note"
       vc.noteTitle = model.title!
       vc.note = model.note!

       
       
        navigationController?.pushViewController(vc, animated: true)
       
//       it catches the update data
       
       vc.completionHandler = { noteTitlee, notee, completedd in
           

           let updateItem = Item(title: noteTitlee,note:notee, completed: completedd)
           model.ref?.updateChildValues(updateItem.toAnyObject() as! [AnyHashable : Any])
           
           self.navigationController?.popViewController(animated: true)
       }
   }
 
    
    // MARK: Add Item
    @IBAction func newNOte(_ sender: Any) {
 
        guard let vc = storyboard?.instantiateViewController(identifier: "new") as? EntryViewController else {
            return
        }
        vc.title = "New Note"
     
        vc.completion = { noteTitle, note, completed in

            let notesItem = Item(title: noteTitle,note:note, completed: false)
            
            self.ref.child("users").child(self.user.uid).child("items").childByAutoId().setValue(notesItem.toAnyObject())

            self.navigationController?.popViewController(animated: true)
            self.noNOtes.isHidden = true
            self.tblView.isHidden = false
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func signout(_ sender: Any) {

          do {
            try Auth.auth().signOut()
            self.navigationController?.popToRootViewController(animated: true)
          } catch let error {
            print("Auth sign out failed: \(error)")
          }
        }
    func toggleCellCheckbox(_ cell: UITableViewCell, isCompleted: Bool) {
      if !isCompleted {
        cell.accessoryType = .none
        cell.textLabel?.textColor = .black
        cell.detailTextLabel?.textColor = .black
      } else {
        cell.accessoryType = .checkmark
        cell.textLabel?.textColor = .gray
        cell.detailTextLabel?.textColor = .gray
      }
    }
}











//extension HomeViewcontroller{
//    func handleMarkAsFavourite() {
        
////        let model: [Item]
//        let toggledCompletion = items.completed
//
//        toggleCellCheckbox(cell!, isCompleted: toggledCompletion!)
////        items.ref?.updateChildValues(["completed": toggledCompletion]))
////
//        print("Marked as favourite")
//    }
//
//    private func handleMarkAsComplete() {
//        print("Marked as Complete")
//    }
//
//    private func handleMoveToArchive() {
//        print("Moved to archive")
//    }
//    private func handleMoveToTrash() {
//        print("Moved to trash")
//    }
//}
        //        if model.completed == true{
        //            cell.backgroundColor = .systemOrange
        //
        ////            toggleCellCheckbox(cell, isCompleted: model.completed ?? true)
        //
        //        } else {
        //            cell.backgroundColor = nil
        //        }
        //
//    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//
//
//        let action = UIContextualAction(style:.normal,
//                                        title: "Favourite") { [weak self] (action, view, completionHandler) in
//
//                                            self?.handleMarkAsFavourite()
//                                            completionHandler(true)
//        }
//
//        action.backgroundColor = .systemBlue
//        return UISwipeActionsConfiguration(actions: [action])
//    }
