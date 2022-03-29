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

class HomeViewcontroller: UIViewController,UITableViewDelegate,UITableViewDataSource{

    
    var user: User?
   
    let ref = Database.database().reference(withPath: "notes-items")
//    let ref = Database.database().reference().child("notes-items/\(uid)/title")
    
    
    var refObservers: [DatabaseHandle] = []
    var handle: AuthStateDidChangeListenerHandle?
    var items: [Notes] = []
   
   
    
    @IBOutlet weak var noNOtes: UILabel!
    @IBOutlet weak var tblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tblView.delegate = self
        self.tblView.dataSource = self
        navigationItem.hidesBackButton  = true
//        title = "ThinkNotes"
//
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
       let completed = ref.observe(.value) { snapshot in
//            print(snapshot.value as Any)
         
            var newItems: [Notes] = []
            for child in snapshot.children {
              if
                let snapshot = child as? DataSnapshot,
                let noteItem = Notes(snapshot: snapshot) {
                newItems.append(noteItem)
              }
            }
            self.items = newItems
//            print(newItems)
////            DispatchQueue.main.async {
           self.noNOtes.isHidden = true
           self.tblView.isHidden=false
            self.tblView.reloadData()
        }
          
       
        refObservers.append(completed)
//        self.tblView.reloadData()
        handle = Auth.auth().addStateDidChangeListener{ _, user in
            guard let user = user else {return}
            self.user = User(authData: user)
        }
    }

    
    override func viewDidDisappear(_ animated: Bool) {
      super.viewDidDisappear(true)
        refObservers.forEach(ref.removeObserver(withHandle:))
      refObservers = []
        guard let handle = handle else { return }
        Auth.auth().removeStateDidChangeListener(handle)

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let list = self.items[indexPath.row]
        
        cell.textLabel?.text = list.title
        cell.detailTextLabel?.text = list.note
        
        return cell
    }
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let model = self.items[indexPath.row]

        // Show note controller
        guard let vc = storyboard?.instantiateViewController(identifier: "note") as? NoteViewController else {
            return
        }
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.title = "Note"
        vc.noteTitle = model.title
        vc.note = model.note
        navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func newNOte(_ sender: Any) {
//    }
//    @IBAction func newNote() {
//     performSegue(withIdentifier: "new", sender: sender)
        guard let vc = storyboard?.instantiateViewController(identifier: "new") as? EntryViewController else {
            return
        }
        vc.title = "New Note"
//        vc.navigationItem.largeTitleDisplayMode = .never
        vc.completion = { noteTitle, note in
//            self.navigationController?.popViewController(animated: true)
            
            
            let notesItem = Notes(title: noteTitle, note: note)
            let notesItemRef = self.ref.child(noteTitle.lowercased())
           
            notesItemRef.setValue(notesItem.toAnyObject())
        

            self.navigationController?.popViewController(animated: true)
            self.noNOtes.isHidden = true
            self.tblView.isHidden = false
//
        
           
//
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func signout(_ sender: Any) {
        // 1
        guard let user = Auth.auth().currentUser else { return }
        let onlineRef = Database.database().reference(withPath: "notes-items\(user.uid)")
        // 2
        onlineRef.removeValue { error, _ in
          // 3
          if let error = error {
            print("Removing online failed: \(error)")
            return
          }
          // 4
          do {
            try Auth.auth().signOut()
            self.navigationController?.popToRootViewController(animated: true)
          } catch let error {
            print("Auth sign out failed: \(error)")
          }
        }

    }
    //    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//
//    }
//
//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let deleteAction = UIContextualAction(style: .normal, title: "Delete",handler: { ( UIContextualAction, UIView, success:(Bool) -> Void) in
//            success(true)
//        })
//        deleteAction.backgroundColor = .red
//        return UISwipeActionsConfiguration(actions: [deleteAction])
//        
//        
//                                        
//    }
}



