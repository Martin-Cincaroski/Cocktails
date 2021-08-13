//
//  User.swift
//  Cocktails
//
//  Created by Martin on 6/24/21.
//

import Foundation

typealias UserSaveCompletion = (_ success: Bool,_ error: Error?)-> Void

struct User: Codable {
    var email: String?
    var fullName: String?
    var dob: String?
    var gender: String?
    var id: String?
    
    
    init(id: String) {
        self.id = id
    }
    
    func save(completion: UserSaveCompletion?) {
//        DataStore.shared.localUser = self
        
        DataStore.shared.setUserData(user: self) { (sucess, error) in
            completion?(sucess, error)
        }
    }
}
