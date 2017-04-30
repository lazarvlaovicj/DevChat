//
//  DataService.swift
//  DevChat
//
//  Created by PRO on 4/29/17.
//  Copyright © 2017 Lazar. All rights reserved.
//
let FIR_CHILD_USERS = "users"
import Foundation
import FirebaseDatabase
import FirebaseStorage

class DataService {
    
    private static let _instance = DataService()
    
    static var instance: DataService {
        return ._instance
    }
    
    var dbRef: FIRDatabaseReference {
        return FIRDatabase.database().reference()
    }
    
    var userRef: FIRDatabaseReference {
        return dbRef.child(FIR_CHILD_USERS)
    }
    
    var storageRef: FIRStorageReference {
        return FIRStorage.storage().reference(forURL: "gs://devchat-e0da3.appspot.com/")
    }
    
    var videoStoreRef: FIRStorageReference {
        return storageRef.child("videos")
    }
    
    func saveUser(uid: String) {
        let profile: Dictionary<String, AnyObject> = ["firstName" :"" as AnyObject, "lastName" :"" as AnyObject]
        dbRef.child(FIR_CHILD_USERS).child(uid).child("profile").setValue(profile)
        
    }
    
    func sendMedia(url: URL, sender: String, sendingTo: Dictionary<String, Users>) {
        
        var uids = [String]()
        for uid in sendingTo.keys {
            uids.append(uid)
        }
        
        let url1: Dictionary<String, AnyObject> = ["downloadURL": url.absoluteString as AnyObject, "sender":sender as AnyObject, "recipients":uids as AnyObject]
        
        dbRef.child("pullRequests").childByAutoId().setValue(url1)
        
    }
    
    
}
