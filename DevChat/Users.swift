//
//  Users.swift
//  DevChat
//
//  Created by PRO on 4/29/17.
//  Copyright © 2017 Lazar. All rights reserved.
//

import UIKit

struct Users {
    
    private var _firstName: String
    private var _uid: String
    
    var firstName: String {
        return _firstName
    }
    
    var uid: String {
        return _uid
    }
    
    init(firstName: String, uid: String) {
        _firstName = firstName
        _uid = uid
    }
    
}
