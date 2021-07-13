//
//  SplashScreenViewController.swift
//  Cocktails
//
//  Created by Martin on 6/23/21.
//

import UIKit
import FirebaseAuth

class SplashScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    func checkForUser () {
    if Auth.auth().currentUser != nil, let id = Auth.auth().currentUser?.uid {
        DataStore.shared.getUserWith(id: id) {[weak self] ( user, error) in
            if let user = user {
                DataStore.shared.localUser = user
                self?.performSegue(withIdentifier: "ListCocktailsSegue", sender: nil)
                return
            }
            do {
                self?.performSegue(withIdentifier: "welcomeSegue", sender: nil)
            } catch {
                print(error.localizedDescription)
            }
        }
    }else {
        performSegue(withIdentifier: "welcomeSegue", sender: nil)
    }
}
   

}
