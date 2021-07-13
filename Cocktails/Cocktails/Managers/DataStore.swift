//
//  DataStore.swift
//  Cocktails
//
//  Created by Martin on 7/5/21.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

enum FirebaseCollections: String {
    case users
    case gameRequests
    case games
}

class DataStore {
    static let shared = DataStore()
    init() {}
    
    var localUser: User?
    
    private let storage = Storage.storage()

    private let database = Firestore.firestore()
    
    func setUserData(user: User, completion: @escaping (_ success: Bool,_ error: Error?)-> Void) {
            guard let uid = user.id else {
                completion(false,nil)
                return
            }
            do {
                let usersRef = database.collection("users").document(uid)
                try usersRef.setData(from: user, completion: { error in
                    if let loggedInUser = Auth.auth().currentUser, loggedInUser.uid == uid {
                        self.localUser = user
                    }
                    if let error = error {
                        completion(false, error)
                            return
                    }
                    completion(true, nil)
                })
            } catch {
                print(error.localizedDescription)
            }
        }
    
    func getUser(uid: String, completion: @escaping (_ user: User?, _ error: Error?) -> Void) {
        let userRef = database.collection("users").document(uid)

        userRef.getDocument { (snapshot, error) in
            if let error = error {
                completion(nil,error)
                return
            }
            
            if let document = snapshot {
                do {
                    let user = try document.data(as: User.self)
                    completion(user, nil)
                } catch {
                    print(error.localizedDescription)
                    completion(nil,error)
                }
            }
        }
    }
    func getUserWith(id: String, completion: @escaping(_ user: User?,_ error: Error?) -> Void) {
      let userRef = database.collection(FirebaseCollections.users.rawValue).document(id)
      userRef.getDocument { (document, error) in
        if let document = document {
          do {
            let user = try document.data(as: User.self)
            completion(user, nil)
          } catch {
            completion(nil, error)
          }
        }
      }
    }
    
 
}
