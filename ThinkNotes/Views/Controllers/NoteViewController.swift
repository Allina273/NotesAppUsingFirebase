//
//  NoteViewController.swift
//  ThinkNotes
//
//  Created by DianApps on 23/03/22.
//

import Foundation
import Firebase
import UIKit

class NoteViewController: UIViewController {
    
    var items: [String] = []
    var user: User!
    var ref : DatabaseReference!
    private var databasehandle: DatabaseHandle!
    var item: [Item] = []
    public var completionHandler: ((String,String,Bool) -> Void)?
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var noteLabel: UITextView!
//    @IBOutlet weak var saveButton: UIButton!
    public var noteTitle: String = ""
    public var note: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = noteTitle
        noteLabel.text = note

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(didTapSave))
    
}

    @objc func didTapSave() {
        if let text = titleLabel.text, !text.isEmpty ,!noteLabel.text.isEmpty{
            completionHandler?(text, noteLabel.text, false)
            
        }
    }

}























//override func setEditing(_ editing: Bool, animated: Bool) {
////        super.setEditing(editing, animated: animated)
//        if (self.isEditing == true){
////            self.editButtonItem.title = "Edit"
//            titleLabel.text = titleLabel.text
//            noteLabel.text = noteLabel.text
////            let model = items
////            let updateItem = Item(title: noteTitle,note:note)
////            ref?.updateChildValues(updateItem.toAnyObject() as! [AnyHashable : Any])
//
//
//
//        } else {
////            self.editButtonItem.title = "Save"
//            titleLabel.text = titleLabel.text
//            noteLabel.text = noteLabel.text
////            let updateItem = Item(title: noteTitle,note:note)
////            ref?.updateChildValues(updateItem.toAnyObject() as! [AnyHashable : Any])
//        }
//
//    }
