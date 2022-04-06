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
    var completed: Bool?
    
    // MARK: Initialize with Firebase DataSnapshot
    init (snapshot: DataSnapshot) {
        ref = snapshot.ref

        let data = snapshot.value as? [String:AnyObject]
        title = data?["title"] as? String
        

        note = data?["note"] as? String
        
        completed = data?["completed"] as? Bool
    }
    
    // MARK: Initialize with Raw Data
    init(title:String,note:String,completed : Bool){
        ref = nil
        self.title = title
        self.note = note
        self.completed = completed
    }

   // MARK: Convert Item to AnyObject
    func toAnyObject() -> Any {
      return [
        "title": title,
        "note": note,
        "completed": completed

      ]
    }
  }


