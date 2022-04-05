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

   
    var items: [Item] = []
    
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


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemcell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row].title
        cell.detailTextLabel?.text = items[indexPath.row].note
        
        return cell
    }
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let model = items[indexPath.row]

        // Show note controller
        guard let vc = storyboard?.instantiateViewController(identifier: "note") as? NoteViewController else {
            return
        }
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.title = "Note"
       vc.noteTitle = model.title!
       vc.note = model.note!
        navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func newNOte(_ sender: Any) {
 
        guard let vc = storyboard?.instantiateViewController(identifier: "new") as? EntryViewController else {
            return
        }
        vc.title = "New Note"
     
        vc.completion = { noteTitle, note in

            let notesItem = Item(title: noteTitle,note:note)
            
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

    }

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

