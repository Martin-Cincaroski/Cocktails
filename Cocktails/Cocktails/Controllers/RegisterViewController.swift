//
//  RegisterViewController.swift
//  Cocktails
//
//  Created by Martin on 6/24/21.
//

import UIKit
import Firebase
import SVProgressHUD


class RegisterViewController: UIViewController {

    @IBOutlet weak var emailHolderView: UIView!
    @IBOutlet weak var passwordHolderView: UIView!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    @IBOutlet weak var btnRegister: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBordersAndFields()
        setButton()
        
        passwordTextField.delegate = self
        passwordTextField.isSecureTextEntry = true
        
    }
    func setupBordersAndFields() {
        
       
        emailHolderView.layer.cornerRadius = 20
        emailHolderView.layer.masksToBounds = false
        emailHolderView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        emailHolderView.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        emailHolderView.layer.shadowOpacity = 1.0
        emailHolderView.layer.shadowRadius = 5.0
        emailTextField.delegate = self
        emailTextField.returnKeyType = .done
            
        passwordHolderView.layer.cornerRadius = 20
        passwordHolderView.layer.masksToBounds = false
        passwordHolderView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        passwordHolderView.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        passwordHolderView.layer.shadowOpacity = 1.0
        passwordHolderView.layer.shadowRadius = 5.0
        passwordTextField.delegate = self
        passwordTextField.returnKeyType = .continue
    }

    func setButton() {
        btnRegister.layer.cornerRadius = 20
        btnRegister.layer.masksToBounds = false
        btnRegister.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        btnRegister.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        btnRegister.layer.shadowOpacity = 1.0
        btnRegister.layer.shadowRadius = 5.0
    }

    @IBAction func onRegister(_ sender: Any) {
        
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
        
        guard pass.count >= 6 else {
            showErrorWith(title: "Error", msg: "Password must contain at least 6 characters")
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: pass) { (authResult, error) in
            if let error = error {
                let specificError = error as NSError
               
                if specificError.code == AuthErrorCode.emailAlreadyInUse.rawValue {
                    self.showErrorWith(title: "Error", msg: "Email already in use!")
                    return
                }
                
                if specificError.code == AuthErrorCode.weakPassword.rawValue {
                    self.showErrorWith(title: "Error", msg: "Your password is too weak")
                    return
                }
                
                self.showErrorWith(title: "Error", msg: error.localizedDescription)
                return
            }
            
            if let authResult = authResult {
                self.saveUser(uid: authResult.user.uid)
            }
        }
 }
    func saveUser(uid: String) {
        let user = User(id: uid)
        SVProgressHUD.show()
        DataStore.shared.setUserData(user: user) { (success, error) in
            SVProgressHUD.dismiss()
            if let error = error {
                self.showErrorWith(title: "Error", msg: error.localizedDescription)
                return
            }
            
            if success {
                DataStore.shared.localUser = user
                self.continueToLogin()
            }
        }
    }
    
    func continueToLogin() {
        performSegue(withIdentifier: "LoginSegue", sender: nil)
    }
    
    
}
extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
