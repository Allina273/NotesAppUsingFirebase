//
//  Notes.swift
//  ThinkNotes
//
//  Created by DianApps on 24/03/22.
//

import Firebase

struct Notes {
    let ref: DatabaseReference?
    let key: String
    let title: String
    let note : String


    // MARK: Initialize with Raw Data
    init(title: String, note: String,key: String = "") {
      self.ref = nil
      self.key = key
      self.title = title
      self.note = note
    }

    // MARK: Initialize with Firebase DataSnapshot
    init?(snapshot: DataSnapshot) {
      guard
        let value = snapshot.value as? [String: AnyObject],
        let title = value["title"] as? String,
        let note = value["note"] as? String
      else {
        return nil
      }

      self.ref = snapshot.ref
      self.key = snapshot.key
      self.title = title
      self.note = note
     
    }

    // MARK: Convert GroceryItem to AnyObject
    func toAnyObject() -> Any {
      return [
        "title": title,
        "note": note
      ]
    }
  }


