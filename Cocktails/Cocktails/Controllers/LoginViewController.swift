//
//  LoginViewController.swift
//  Cocktails
//
//  Created by Martin on 6/23/21.
//

import UIKit
import AuthenticationServices

class LoginViewController: UIViewController, UITextFieldDelegate {

    
    
    @IBOutlet weak var cocktailLogoImage: UIImageView!
    @IBOutlet weak var btnAppleSingin: ASAuthorizationAppleIDButton!
    @IBOutlet weak var continueWithFacebook: UIButton!
    @IBOutlet weak var btnSignIn: UIButton!
    @IBOutlet weak var btnCreateAccound: UIButton!
    @IBOutlet weak var btnForgotPassword: UIButton!
    
    
    
    @IBOutlet weak var emailHolderView: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordHolderView: UIView!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButton()
        setupBordersAndFields()
        
       
    }
    
    func setupButton() {
        
        continueWithFacebook.layer.cornerRadius = 20
        continueWithFacebook.layer.masksToBounds = false
        continueWithFacebook.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        continueWithFacebook.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        continueWithFacebook.layer.shadowOpacity = 1.0
        continueWithFacebook.layer.shadowRadius = 5.0
        
        btnSignIn.layer.cornerRadius = 20
        btnSignIn.layer.masksToBounds = false
        btnSignIn.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        btnSignIn.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        btnSignIn.layer.shadowOpacity = 1.0
        btnSignIn.layer.shadowRadius = 5.0
        
        btnAppleSingin.layer.cornerRadius = 20
        btnAppleSingin.layer.masksToBounds = false
        btnAppleSingin.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        btnAppleSingin.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        btnAppleSingin.layer.shadowOpacity = 1.0
        btnAppleSingin.layer.shadowRadius = 5.0
        
        
      
    }
    
    
    func setupBordersAndFields() {
        emailHolderView.layer.cornerRadius = 15
        emailHolderView.layer.masksToBounds = false
        emailHolderView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        emailHolderView.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        emailHolderView.layer.shadowOpacity = 1.0
        emailHolderView.layer.shadowRadius = 5.0
        
        emailTextField.delegate = self
        emailTextField.returnKeyType = .done
        
        passwordHolderView.layer.cornerRadius = 15
        passwordHolderView.layer.masksToBounds = false
        passwordHolderView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        passwordHolderView.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        passwordHolderView.layer.shadowOpacity = 1.0
        passwordHolderView.layer.shadowRadius = 5.0
        
        passwordTextField.delegate = self
        passwordTextField.isSecureTextEntry = true
    }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
