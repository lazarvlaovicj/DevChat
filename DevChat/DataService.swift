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
    
    func saveUser(uid: String) {
        
        let profile: Dictionary<String, AnyObject> = ["firstName" :"" as AnyObject, "lastName" :"" as AnyObject]
        dbRef.child(FIR_CHILD_USERS).child(uid).child("profile").setValue(profile)
        
    }
    
}
