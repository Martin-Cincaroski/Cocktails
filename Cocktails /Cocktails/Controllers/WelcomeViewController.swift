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



class WelcomeViewController: UIViewController, LoginButtonDelegate {
  

    @IBOutlet weak var imageTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var createAcountBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var btnSingIn: UIButton!
    @IBOutlet weak var btnCreateAcound: UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        setButton()
        
        if let token = AccessToken.current, !token.isExpired {
            
            let token = token.tokenString
            
            let request = FBSDKLoginKit.GraphRequest(graphPath: "me",
                                                     parameters: ["fields": "email, name"],
                                                     tokenString: token,
                                                     version: nil,
                                                     httpMethod: .get)
          
            request.start(completionHandler: {connection, result, error in
                print("\(result)")
            })
          
            performSegue(withIdentifier: "listCocktailsSegue", sender: nil)
        } else {
         
            let facebookLoginButton = FBLoginButton()
             facebookLoginButton.frame = CGRect(x: 60, y: 600, width: 290, height: 44)
             facebookLoginButton.layer.cornerRadius = 20
             facebookLoginButton.layer.masksToBounds = true
             facebookLoginButton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
             facebookLoginButton.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
             facebookLoginButton.layer.shadowOpacity = 1.0
             facebookLoginButton.layer.shadowRadius = 5.0
            facebookLoginButton.delegate = self
            facebookLoginButton.permissions = ["public_profile", "email"]
             view.addSubview(facebookLoginButton)
            
        }
        
        if let user = Auth.auth().currentUser {
            getLocalUserData(uid: user.uid)
            return
        }
        
    }
    
   
       
    
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        
        let token = result?.token?.tokenString
        
        let request = FBSDKLoginKit.GraphRequest(graphPath: "me",
                                                 parameters: ["fields": "email, name"],
                                                 tokenString: token,
                                                 version: nil,
                                                 httpMethod: .get)
      
        request.start(completionHandler: {connection, result, error in
            print("\(result)")
            
        })
        performSegue(withIdentifier: "listCocktailsSegue", sender: nil)
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
       print("logout User")
     
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
            }
        }
    }

    func continueTolistCocktailsScreen() {
        performSegue(withIdentifier: "listCocktailsSegue", sender: nil)
    }
    

    
    @IBAction func onRegister(_ sender: UIButton) {
        performSegue(withIdentifier: "registerSegue", sender: nil)
    }
    
    @IBAction func onLogIn(_ sender: UIButton) {
        performSegue(withIdentifier: "LoginSegue", sender: nil)
    }
    
    
}



