//
//  DataStore.swift
//  SocialMedia
//
//  Created by Darko Spasovski on 11/11/20.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseStorage
import FirebaseAuth



class DataStore {
    static let shared = DataStore()
    init() {}
    
    var localUser: User?
    
    private let storage = Storage.storage()

    private let database = Firestore.firestore()
    
   
}
