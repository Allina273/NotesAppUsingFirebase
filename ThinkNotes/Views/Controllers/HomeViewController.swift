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

    
    var user: User!
    var ref : DatabaseReference!
    private var databasehandle: DatabaseHandle!
//
//   let uuid = Auth.auth().currentUser
//
//    let ref = Database.database().reference(withPath: "notes-items")
//    let ref = Database.database().reference().child("notes-items/\(uid)/title")
//    let userId = Auth.auth().currentUser!.uid
//    let usersRef = Database.database().reference(withPath: "current")
//    var usersRefObservers: [DatabaseHandle] = []
    
//    var refObservers: [DatabaseHandle] = []
//    var handle: AuthStateDidChangeListenerHandle?
//    var items = [Notes]()
   
   var items = [Item]()
    
    @IBOutlet weak var noNOtes: UILabel!
    @IBOutlet weak var tblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        user = Auth.auth().currentUser
        ref = Database.database().reference()
        startObservingDatabase()
        
        self.tblView.delegate = self
        self.tblView.dataSource = self
        navigationItem.hidesBackButton  = true
//        title = "ThinkNotes"
//
    }
    func startObservingDatabase(){
        databasehandle = ref.child("users/\(self.user.uid)/items").observe(.value, with: { (snapshot) in
            print(snapshot.value as Any)
            var newItems = [Item]()
//            for child in snapshot.children {
//                         if
//                           let snapshot = child as? DataSnapshot,
//                           let noteItem = Notes(snapshot: snapshot) {
//                           newItems.append(noteItem)
//                         }
//            }
            for itemSnapShot in snapshot.children {
                let item = Item(snapshot: itemSnapShot as! DataSnapshot)
                newItems.append(item)

            }
            
            self.items = newItems
            self.tblView.reloadData()
        })
    }
    deinit{
        ref.child("users/\(self.user.uid)/items").removeObserver(withHandle: databasehandle)
    }

//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//
//       let completed = ref.observe(.value) { snapshot in
//            print(snapshot.value as Any)
//
//            var newItems: [Notes] = []
//            for child in snapshot.children {
//              if
//                let snapshot = child as? DataSnapshot,
//                let noteItem = Notes(snapshot: snapshot) {
//                newItems.append(noteItem)
//              }
//            }
//            self.items = newItems
////            print(newItems)
//////            DispatchQueue.main.async {
////           self.noNOtes.isHidden = true
//           self.tblView.isHidden=false
//            self.tblView.reloadData()
//        }
//
//
//        refObservers.append(completed)
////        self.tblView.reloadData()
//        handle = Auth.auth().addStateDidChangeListener{ _, user in
//            guard let user = user else {return}
//            self.user = User(authData: user)
//
////            let currentUserRef = self.usersRef.child(user.uid)
////            currentUserRef.setValue(user.email)
////            currentUserRef.onDisconnectRemoveValue()
//    }
//    }
    
//    override func viewDidDisappear(_ animated: Bool) {
//      super.viewDidDisappear(true)
//        refObservers.forEach(ref.removeObserver(withHandle:))
//      refObservers = []
////        usersRefObservers.forEach(usersRef.removeObserver(withHandle:))
////        usersRefObservers = []
//        guard let handle = handle else { return }
//        Auth.auth().removeStateDidChangeListener(handle)
//
//    }
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
//        cell.detailTextLabel?.text = list.note
        
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
       vc.noteTitle = model.title!
//       vc.note = model.note
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
        vc.completion = { noteTitle in
//            self.navigationController?.popViewController(animated: true)
            
//            guard let user = Auth.auth().currentUser  else { return }
//            let notesItem = Notes(title: noteTitle)
//            let notesItemRef = self.ref.child("notes-items/\(user.uid)")
//            let notesItemRef = self.ref.child(user.uid)
           
//            notesItemRef.setValue(notesItem.toAnyObject())
            self.ref.child("users").child(self.user.uid).child("items").childByAutoId().child("title").setValue(noteTitle)

            self.navigationController?.popViewController(animated: true)
            self.noNOtes.isHidden = true
            self.tblView.isHidden = false
//
        
           
//
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func signout(_ sender: Any) {
//        // 1
//        guard let user = Auth.auth().currentUser  else { return }
//        let onlineRef = Database.database().reference(withPath: "notes-items")
//        // 2
//        onlineRef.removeValue { error, _ in
//          // 3
//          if let error = error {
//            print("Removing online failed: \(error)")
//            return
//          }
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



