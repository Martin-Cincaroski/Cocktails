//
//  ForgotPasswordViewController.swift
//  Cocktails
//
//  Created by Martin on 6/24/21.
//

import UIKit
import FirebaseAuth


class ForgotPasswordViewController: UIViewController {
    
    @IBOutlet weak var emailHolderView: UIView!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var btnSend: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBordersAndFields()
        setupButon()

       
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
    }
    
    func setupButon() {
        btnSend.layer.cornerRadius = 20
        btnSend.layer.masksToBounds = false
        btnSend.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        btnSend.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        btnSend.layer.shadowOpacity = 1.0
        btnSend.layer.shadowRadius = 5.0
        
    }
    @IBAction func backButtonTapped(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
        present(controller, animated: true, completion: nil)
        navigationController?.popToRootViewController(animated: false)
    }
    
    @IBAction func btnForgotPasswordTapped(_ sender: Any) {
        
        Auth.auth().sendPasswordReset(withEmail: emailTextField.text!) { (error) in
            if error == nil {
                print("SENT....!")
            } else {
                print("FAILED - \(String(describing: error?.localizedDescription))")
            }
        }
    
    }
}
extension ForgotPasswordViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
