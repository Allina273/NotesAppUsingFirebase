//
//  NoteViewController.swift
//  ThinkNotes
//
//  Created by DianApps on 23/03/22.
//

import Foundation
import UIKit

class NoteViewController: UIViewController {
    
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var noteLabel: UITextView!
    public var noteTitle: String = ""
    public var note: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = noteTitle
        noteLabel.text = note
    }


}
