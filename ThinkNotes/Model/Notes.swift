//
//  Notes.swift
//  ThinkNotes
//
//  Created by DianApps on 24/03/22.
//
import Foundation
import FirebaseDatabase
class Item{
    
    var ref: DatabaseReference?
    var title: String?

    init (snapshot: DataSnapshot) {
        ref = snapshot.ref

        let data = snapshot.value as! Dictionary<String, String>
        title = data["title"]! as String
    }


}
//struct Notes {
//   let ref: DatabaseReference?
//    let key: String
//    let title: String
////    let note : String
////    let uid : String
//
//
//
//    // MARK: Initialize with Raw Data
//    init(title: String, note: String, key:String = "") {
//      self.ref = nil
//      self.key = key
//      self.title = title
////      self.note = note
////        self.uid = uid
//    }
//
//    // MARK: Initialize with Firebase DataSnapshot
//    init(snapshot: DataSnapshot) {
//        ref = snapshot.ref
//        let value = snapshot.value as! [String: String]
////        let value = snapshot.value as! [String: AnyObject]
//         title = value["title"]! as String
////         note = value["note"]! as String
////            let uid = value["uid"] as? String
////      else {
////        return nil
////      }
//
//
//      self.key = snapshot.key
////      self.title = title
////      self.note = note
////        self.uid = uid
//
//
//
//    }
//
//    // MARK: Convert GroceryItem to AnyObject
//    func toAnyObject() -> Any {
//      return [
//        "title": title,
////        "note": note
//
//      ]
//    }
//  }


