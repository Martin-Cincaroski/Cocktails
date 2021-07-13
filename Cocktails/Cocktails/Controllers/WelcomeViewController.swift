//
//  WelcomeViewController.swift
//  Cocktails
//
//  Created by Martin on 7/6/21.
//

import UIKit
import SVProgressHUD
import FBSDKLoginKit
import FBSDKCoreKit
import Firebase
import FirebaseAuth
import AuthenticationServices


class WelcomeViewController: UIViewController {
 
    
   
    
    @IBOutlet weak var btnFacebook: UIButton!
    @IBOutlet weak var btnSingIn: UIButton!
    @IBOutlet weak var btnAppleSIgnin: ASAuthorizationAppleIDButton!
    @IBOutlet weak var btnCreateAcound: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setButton()
        
        if let user = Auth.auth().currentUser {
            getLocalUserData(uid: user.uid)
            return
        }

       }
    
    
    func setButton() {
        btnSingIn.layer.cornerRadius = 20
        btnSingIn.layer.masksToBounds = false
        btnSingIn.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        btnSingIn.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        btnSingIn.layer.shadowOpacity = 1.0
        btnSingIn.layer.shadowRadius = 5.0
        
        btnCreateAcound.layer.cornerRadius = 20
        btnCreateAcound.layer.masksToBounds = false
        btnCreateAcound.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        btnCreateAcound.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        btnCreateAcound.layer.shadowOpacity = 1.0
        btnCreateAcound.layer.shadowRadius = 5.0
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    func userDidLogin(token: String) {
        let credential = FacebookAuthProvider.credential(withAccessToken: token)
        
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            
            if let authResult = authResult {
                let user = authResult.user
                print(user)
                self.getLocalUserData(uid: user.uid)
            }
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
                self.continueToListCocktailsScreen()
            }
        }
    }

    func continueToListCocktailsScreen() {
        performSegue(withIdentifier: "listCocktailsSegue", sender: nil)
    }
    
    @IBAction func onFaceBook(_ sender: Any) {
        let manager = LoginManager()
        manager.logIn(permissions: ["public_profile","email"], from: self) { (loginResult, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                if let result = loginResult, !result.isCancelled, let token = result.token {
                    self.userDidLogin(token: token.tokenString)
                } else {
                    print("User Canceled flow")
                }
            }
        }
    }
    
    @IBAction func onRegister(_ sender: UIButton) {
        performSegue(withIdentifier: "registerSegue", sender: nil)
    }
    
    @IBAction func onLogIn(_ sender: UIButton) {
        performSegue(withIdentifier: "LoginSegue", sender: nil)
    }
    
    
}

    
    

