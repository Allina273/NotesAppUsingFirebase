//
//  Notes.swift
//  ThinkNotes
//
//  Created by DianApps on 24/03/22.
//
import Foundation
import FirebaseDatabase
struct Item{
    
    var ref: DatabaseReference?
    var title: String?
    var note: String?
    
    // MARK: Initialize with Firebase DataSnapshot
    init (snapshot: DataSnapshot) {
        ref = snapshot.ref

        let data = snapshot.value as? [String:AnyObject]
        title = data!["title"] as? String
        

        note = data!["note"] as? String
    }
    
    // MARK: Initialize with Raw Data
    init(title:String,note:String){
        ref = nil
        self.title = title
        self.note = note
    }

   // MARK: Convert Item to AnyObject
    func toAnyObject() -> Any {
      return [
        "title": title,
        "note": note

      ]
    }
  }


