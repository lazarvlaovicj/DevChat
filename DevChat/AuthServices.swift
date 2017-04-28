//
//  AuthServices.swift
//  DevChat
//
//  Created by PRO on 4/28/17.
//  Copyright © 2017 Lazar. All rights reserved.
//

import Foundation
import FirebaseAuth

typealias Complete = (_ errMsg: String? , _ data: AnyObject?) -> Void

class AuthServices {
    
    private static let _instance = AuthServices()
    
    static var instance: AuthServices {
        return _instance
    }
    
    func login(email: String, password: String, onComplete: @escaping Complete) {
        
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
            if error != nil {
                
                if let errorCode = FIRAuthErrorCode(rawValue: (error?._code)!) {
                    if errorCode == .errorCodeUserNotFound {
                        //Create an account
                        
                        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
                            if error != nil {
                                self.firebaseError(error: error! as NSError, onComplete: onComplete)
                            } else {
                                if user?.uid != nil {
                                    FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
                                        
                                        if error != nil {
                                            //Print error
                                            self.firebaseError(error: error! as NSError, onComplete: onComplete)
                                        } else {
                                            //Successfully logged in
                                            onComplete(nil, user)
                                        }
                                        
                                    })
                                }
                            }
                        })
                    }
                    
                } else {
                    //Handle all other errors
                    self.firebaseError(error: error! as NSError, onComplete: onComplete)
                }
                
            } else {
                //Successfully signed in account
                onComplete(nil, user)
            }
        })
    }
    
    func firebaseError(error: NSError, onComplete: Complete) {
        print(error.debugDescription)
        if let errorCode = FIRAuthErrorCode(rawValue: error.code) {
            switch errorCode {
            case .errorCodeInvalidEmail:
                onComplete("Invalid email", nil)
                break
            case .errorCodeWrongPassword:
                onComplete("Invalid password", nil)
                break
            case .errorCodeEmailAlreadyInUse, .errorCodeAccountExistsWithDifferentCredential:
                onComplete("Could not create an account. Email already in use", nil)
            default:
                onComplete("There was a problem autheticating", nil)
            }
        }
    
    }
}







