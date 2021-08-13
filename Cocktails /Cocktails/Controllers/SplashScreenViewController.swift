//
//  SplashScreenViewController.swift
//  Cocktails
//
//  Created by Martin on 8/6/21.
//

import UIKit
import FirebaseAuth
import SVProgressHUD

class SplashScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if let user = Auth.auth().currentUser {
            getLocalUserData(uid: user.uid)
            return
        }
    }
    func getLocalUserData(uid: String) {
        SVProgressHUD.show()
        DataStore.shared.getUser(uid: uid) { (user, error) in
            SVProgressHUD.dismiss()
            if let error = error {
                self.showErrorWith(title: "Error", msg: error.localizedDescription)
                return
            }

            if let user = user {
                DataStore.shared.localUser = user
                self.continueTolistCocktailsScreen()
            } else {
                self.continueToWelcomeScreen()
            }
        }
    }
    func continueTolistCocktailsScreen() {
        performSegue(withIdentifier: "listCocktailsSegue", sender: nil)
    }
    func continueToWelcomeScreen() {
        performSegue(withIdentifier: "welcomeSegue", sender: nil)
    }
}
