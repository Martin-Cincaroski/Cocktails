//
//  SetupProfileViewController.swift
//  Cocktails
//
//  Created by Martin on 7/5/21.
//

import UIKit
import SVProgressHUD
import FirebaseAuth

enum SetupProfileState {
    case register
    case login
    case editProfile
}

class SetupProfileViewController: UIViewController {
    
    
    @IBOutlet weak var fullNameHolderView: UIView!
    @IBOutlet weak var dobHolderView: UIView!
    @IBOutlet weak var genderHolderView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var dobTextField: UITextField!
    @IBOutlet weak var genderTextField: UITextField!
    
    @IBOutlet weak var btnSave: UIButton!
    
    var state: SetupProfileState = .register
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBordersAndFields()
    
        if state != .editProfile {
            reorderNavigation()
        } else if state == .editProfile {
            setupViewForEdit()
        }
    }
    
    private func setupViewForEdit() {
        guard let localUser = DataStore.shared.localUser else { return }
        btnSave.setTitle("Save profile", for: .normal)
        fullNameTextField.text = localUser.fullName
        dobTextField.text = localUser.dob
        genderTextField.text = localUser.gender
        
    }
    
    func reorderNavigation() {
        var controllers = [UIViewController]()
        navigationController?.viewControllers.forEach({ (controller) in
            if !(controller is RegisterViewController) {
                controllers.append(controller)
            }
        })
        navigationController?.viewControllers.forEach({
            if !($0 is RegisterViewController) {
                controllers.append($0)
            }
        })
        navigationController?.setViewControllers(controllers, animated: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setKeyboardObservers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeKeyboardObservers()
    }
    
    func setKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow(notification:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidHide(notification:)), name: UIResponder.keyboardDidHideNotification, object: nil)
    }
    
    func removeKeyboardObservers() {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardDidShow(notification: Notification) {
        guard let userInfo = notification.userInfo else {
            return
        }
        
        guard let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
            return
        }
        
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardFrame.height, right: 0)
        scrollView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardFrame.height, right: 0)
    }
    
    @objc func keyboardDidHide(notification: Notification) {
        scrollView.contentInset = UIEdgeInsets.zero
        scrollView.scrollIndicatorInsets = .zero
    }
    
    func setupBordersAndFields() {
        fullNameHolderView.layer.cornerRadius = 15
        fullNameHolderView.layer.masksToBounds = false
        fullNameHolderView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        fullNameHolderView.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        fullNameHolderView.layer.shadowOpacity = 1.0
        fullNameHolderView.layer.shadowRadius = 5.0
        
        fullNameTextField.delegate = self
        fullNameTextField.returnKeyType = .done
        
        dobHolderView.layer.cornerRadius = 15
        dobHolderView.layer.masksToBounds = false
        dobHolderView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        dobHolderView.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        dobHolderView.layer.shadowOpacity = 1.0
        dobHolderView.layer.shadowRadius = 5.0
        
        dobTextField.delegate = self
        dobTextField.returnKeyType = .done
        
        genderHolderView.layer.cornerRadius = 15
        genderHolderView.layer.masksToBounds = false
        genderHolderView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        genderHolderView.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        genderHolderView.layer.shadowOpacity = 1.0
        genderHolderView.layer.shadowRadius = 5.0
        
        genderTextField.delegate = self
        genderTextField.returnKeyType = .done
    }
  
    func getUser() -> User? {
        guard let localUser = DataStore.shared.localUser else {
            return nil
        }
        return localUser
    }
    
    func createUser() -> User? {
        guard let user = Auth.auth().currentUser else { return nil }
        let localUser = User(id: user.uid)
        return localUser
    }
    
    private func saveUserProfile() {
        var user = getUser()
        var shouldUpdate = false

        if user?.fullName != fullNameTextField.text {
            shouldUpdate = true
            user?.fullName = fullNameTextField.text
        } else if user?.dob != dobTextField.text {
            shouldUpdate = true
            user?.dob = dobTextField.text
        } else if user?.gender != genderTextField.text {
            shouldUpdate = true
            user?.gender = genderTextField.text
        }
        if shouldUpdate {
            saveUser(user: user!)
        }
    }
    
    @IBAction func onContinue(_ sender: Any) {
        var user: User?
     
        switch state {
        case .login:
            user = createUser()
        case .register:
            user = getUser()
        case .editProfile:
            saveUserProfile()
            return
        }
        
        guard var localUser = user else {
            showErrorWith(title: "Error", msg: "User does not exists")
            navigationController?.popToRootViewController(animated: true)
            return
        }
        
        localUser.fullName = fullNameTextField.text
        localUser.gender = genderTextField.text
        localUser.dob = dobTextField.text
        
        saveUser(user: localUser)
    }
    private func saveUser(user: User) {
        
        DataStore.shared.setUserData(user: user) { (success, error) in
            
            if let error = error {
                self.showErrorWith(title: "Error", msg: error.localizedDescription)
                return
            }
            
            if success {
                DataStore.shared.localUser = user
                if self.state != .editProfile {
                    self.performSegue(withIdentifier: "ListCoctailsSegue", sender: nil)
                } else {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
}

extension SetupProfileViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
