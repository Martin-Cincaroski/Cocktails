//
//  LoginViewController.swift
//  Cocktails
//
//  Created by Martin on 6/23/21.
//

import UIKit
import Firebase
import SVProgressHUD
import FirebaseAuth


class LoginViewController: UIViewController {
  
    @IBOutlet weak var emailHolderView: UIView!
    @IBOutlet weak var passwordHolderView: UIView!
    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnForgotPassword: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setButton()
        setupBorderAndField()
        
        passwordTextField.delegate = self
        passwordTextField.isSecureTextEntry = true
    }
    
    func setButton() {
        btnLogin.layer.cornerRadius = 20
        btnLogin.layer.masksToBounds = false
        btnLogin.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        btnLogin.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        btnLogin.layer.shadowOpacity = 1.0
        btnLogin.layer.shadowRadius = 5.0
        
        btnForgotPassword.layer.cornerRadius = 20
        btnForgotPassword.layer.masksToBounds = false
        btnForgotPassword.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        btnForgotPassword.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        btnForgotPassword.layer.shadowOpacity = 1.0
        btnForgotPassword.layer.shadowRadius = 5.0
    }
    
    func setupBorderAndField() {
        emailHolderView.layer.cornerRadius = 20
        emailHolderView.layer.masksToBounds = false
        emailHolderView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        emailHolderView.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        emailHolderView.layer.shadowOpacity = 1.0
        emailHolderView.layer.shadowRadius = 5.0
        
        passwordHolderView.layer.cornerRadius = 20
        passwordHolderView.layer.masksToBounds = false
        passwordHolderView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        passwordHolderView.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        passwordHolderView.layer.shadowOpacity = 1.0
        passwordHolderView.layer.shadowRadius = 5.0
    }
    
    @objc func onBack() {
        navigationController?.popViewController(animated: true)
        
    }

    @IBAction func backButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "welcomeSegue", sender: nil)
    }
    
    @IBAction func btnlogin(_ sender: UIButton) {
        guard let email = emailTextField.text, email != "" else {
            showErrorWith(title: "Error", msg: "Please enter your email")
            return
        }
        
        guard let pass = passwordTextField.text, pass != "" else {
            showErrorWith(title: "Error", msg: "Please enter password")
            return
        }
        
        guard email.isValidEmail() else {
            showErrorWith(title: "Error", msg: "Please enter a valid email")
            return
        }
        
        SVProgressHUD.show()
        Auth.auth().signIn(withEmail: email, password: pass) { (authResult, error) in
            SVProgressHUD.dismiss()
            if let error = error {
                let specificError = error as NSError
               
                if specificError.code == AuthErrorCode.invalidEmail.rawValue && specificError.code == AuthErrorCode.wrongPassword.rawValue {
                    self.showErrorWith(title: "Error", msg: "Incorect email or password")
                    return
                }
                
                if specificError.code == AuthErrorCode.userDisabled.rawValue {
                    self.showErrorWith(title: "Error", msg: "You account was disabled")
                    return
                }
                
                self.showErrorWith(title: "Error", msg: error.localizedDescription)
                return
            }
            
            if let authResult = authResult {
                self.getLocalUserData(uid: authResult.user.uid)
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
                self.continuteToMain()
                return
            }
           
        }
    }
    
    func continuteToMain() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "ListCocktailsViewController")
        present(controller, animated: true, completion: nil)
        navigationController?.popToRootViewController(animated: false)
    }
   
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
