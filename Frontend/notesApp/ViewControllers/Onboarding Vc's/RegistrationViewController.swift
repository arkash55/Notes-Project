//
//  RegistrationViewController.swift
//  notesApp
//
//  Created by Arkash Vijayakumar on 17/12/2021.
//

import UIKit

class RegistrationViewController: UIViewController {
    
    private let scrollView = UIScrollView()
    
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "Sign up here"
        titleLabel.font = .systemFont(ofSize: 32, weight: .regular)
        titleLabel.textColor = Constants.secondaryColor
        titleLabel.textAlignment = .center
        return titleLabel
    }()
    
    private let usernameField: UnderlinedTextField = {
        let usernameField = UnderlinedTextField()
        usernameField.placeholder = "Enter Username..."
        usernameField.textColor = .label
        usernameField.autocorrectionType = .no
        usernameField.autocapitalizationType = .none
        usernameField.returnKeyType = .next
        usernameField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        usernameField.layer.masksToBounds = true
        usernameField.leftViewMode = .always
        usernameField.borderStyle = .none
        return usernameField
    }()
    
    private let emailField: UnderlinedTextField = {
        let emailField = UnderlinedTextField()
        emailField.placeholder = "Enter Email..."
        emailField.textColor = .label
        emailField.autocorrectionType = .no
        emailField.autocapitalizationType = .none
        emailField.returnKeyType = .next
        emailField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        emailField.layer.masksToBounds = true
        emailField.leftViewMode = .always
        emailField.borderStyle = .none
        return emailField
    }()
    
    private let firstNameField: UnderlinedTextField = {
        let firstNameField = UnderlinedTextField()
        firstNameField.placeholder = "Enter First Name..."
        firstNameField.textColor = .label
        firstNameField.autocorrectionType = .no
        firstNameField.autocapitalizationType = .none
        firstNameField.returnKeyType = .next
        firstNameField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        firstNameField.layer.masksToBounds = true
        firstNameField.leftViewMode = .always
        firstNameField.borderStyle = .none
        return firstNameField
    }()
    
    private let lastNameField: UnderlinedTextField = {
        let lastNameField = UnderlinedTextField()
        lastNameField.placeholder = "Enter Last Name..."
        lastNameField.textColor = .label
        lastNameField.autocorrectionType = .no
        lastNameField.autocapitalizationType = .none
        lastNameField.returnKeyType = .next
        lastNameField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        lastNameField.layer.masksToBounds = true
        lastNameField.leftViewMode = .always
        lastNameField.borderStyle = .none
        return lastNameField
    }()
    
    
    private let passwordField: UnderlinedTextField = {
        let passwordField = UnderlinedTextField()
        passwordField.placeholder = "Enter Password..."
        passwordField.textColor = .label
        passwordField.autocorrectionType = .no
        passwordField.autocapitalizationType = .none
        passwordField.returnKeyType = .next
        passwordField.isSecureTextEntry = true
        passwordField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        passwordField.leftViewMode = .always
        return passwordField
    }()
    
    private let confirmPasswordField: UnderlinedTextField = {
        let confirmPasswordField = UnderlinedTextField()
        confirmPasswordField.placeholder = "Confirm Password..."
        confirmPasswordField.textColor = .label
        confirmPasswordField.autocorrectionType = .no
        confirmPasswordField.autocapitalizationType = .none
        confirmPasswordField.returnKeyType = .done
        confirmPasswordField.isSecureTextEntry = true
        confirmPasswordField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        confirmPasswordField.leftViewMode = .always
        return confirmPasswordField
    }()
    
    private let registerButton: UIButton = {
        let registerButton = UIButton()
        registerButton.setTitle("Register", for: .normal)
        registerButton.setTitleColor(.label, for: .normal)
        registerButton.backgroundColor = Constants.secondaryColor
        registerButton.layer.cornerRadius = Constants.cornerRadius
        registerButton.layer.borderWidth = 1.0
        registerButton.layer.borderColor = registerButton.backgroundColor?.cgColor
        return registerButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.backgroundColor
        addTargets()
        addSubviewsAndDelegates()
        configureNavigationBar()
        configureScrollView(scrollView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let registerSize = view.width/3
        let titleSize = view.width/2
        
        titleLabel.frame = CGRect(x: view.frame.midX - titleSize/2,
                                  y: view.safeAreaInsets.top + 15,
                                  width: titleSize,
                                  height: 35)
        
        usernameField.frame = CGRect(x: 25,
                                     y: titleLabel.frame.maxY + 60,
                                     width: view.width-50,
                                     height: 52)
        
        emailField.frame = CGRect(x: 25,
                                  y: usernameField.frame.maxY + 10,
                                  width: view.width-50,
                                  height: 52)
        
        firstNameField.frame = CGRect(x: 25,
                                      y: emailField.frame.maxY + 10,
                                      width: view.width-50,
                                      height: 52)
        
        lastNameField.frame = CGRect(x: 25,
                                     y: firstNameField.frame.maxY + 10,
                                     width: view.width-50,
                                     height: 52)
        
        passwordField.frame = CGRect(x: 25,
                                     y: lastNameField.frame.maxY + 10,
                                     width: view.width-50,
                                     height: 52)
        
        confirmPasswordField.frame = CGRect(x: 25,
                                            y: passwordField.frame.maxY + 10,
                                            width: view.width-50,
                                            height: 52)
        
        
        registerButton.frame = CGRect(x: view.frame.midX - registerSize/2,
                                      y: confirmPasswordField.frame.maxY+35,
                                      width: registerSize,
                                      height: 40)
        
        
    }
    
    //METHODS
    private func addSubviewsAndDelegates() {
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(usernameField)
        scrollView.addSubview(emailField)
        scrollView.addSubview(firstNameField)
        scrollView.addSubview(lastNameField)
        scrollView.addSubview(confirmPasswordField)
        scrollView.addSubview(passwordField)
        scrollView.addSubview(registerButton)
        view.addSubview(scrollView)
        emailField.delegate = self
        usernameField.delegate = self
        confirmPasswordField.delegate = self
        firstNameField.delegate = self
        lastNameField.delegate = self
        passwordField.delegate = self
        scrollView.delegate = self
    }
    
    private func configureScrollView(_ scrollView: UIScrollView) {
        scrollView.frame = view.bounds
        scrollView.contentSize = CGSize(width: view.width, height: view.height*1.5)
        scrollView.isScrollEnabled = true
        scrollView.showsVerticalScrollIndicator = true
    }
    
    private func addTargets() {
        registerButton.addTarget(self, action: #selector(didTapRegisterButton), for: .touchUpInside)
    }
    
    private func configureNavigationBar() {
        let config = UIImage.SymbolConfiguration(pointSize: 23, weight: .semibold, scale: .medium)
        let backIcon = UIImage(systemName: "chevron.backward")?.withTintColor(Constants.secondaryColor, renderingMode: .alwaysOriginal).withConfiguration(config)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: backIcon,
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(didTapBackButton))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "dismiss",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(didTapDismissButton))
    }
    
    
    //@objc methods
    @objc private func didTapDismissButton() {
        let vc = HomeViewController()
        let navVc = UINavigationController(rootViewController: vc)
        navVc.modalPresentationStyle = .fullScreen
        present(navVc, animated: true, completion: nil)
        
    }
    
    @objc private func didTapBackButton() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func didTapRegisterButton() {
        print("register was tapped")
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        usernameField.resignFirstResponder()
        firstNameField.resignFirstResponder()
        lastNameField.resignFirstResponder()
        confirmPasswordField.resignFirstResponder()
      
        
        //get text
        guard let username = usernameField.text?.replacingOccurrences(of: " ", with: ""), !username.isEmpty,
              let email = emailField.text?.replacingOccurrences(of: " ", with: ""), !email.isEmpty,
              let first_name = firstNameField.text?.replacingOccurrences(of: " ", with: ""), !first_name.isEmpty,
              let last_name = lastNameField.text?.replacingOccurrences(of: " ", with: ""), !last_name.isEmpty,
              let password = passwordField.text?.replacingOccurrences(of: " ", with: ""), !password.isEmpty,
              let confirm_password = confirmPasswordField.text?.replacingOccurrences(of: " ", with: ""), !confirm_password.isEmpty else {
                  
                  AlertErrors.dismissError(vc: self,
                                           title: "Could not register user",
                                           message: "Please make sure all fields are filled")
                  
                  return
              }
        //some detail checks
        guard password == confirm_password else {
            AlertErrors.dismissError(vc: self, title: "Could not register user", message: "Password fields do not match")
            return
        }
        guard email.contains("@") && email.contains(".") else {
            AlertErrors.dismissError(vc: self, title: "Could not register user", message: "Please enter a valid email")
            return
        }
        
        //register user
        AuthManager.shared.registerUser(email: email, username: username, first_name: first_name, last_name: last_name, password: password) { result in
            switch result {
            case .success(let user_data):
                UserDefaults.standard.setValue(user_data.id, forKey: "user_id")
                UserDefaults.standard.setValue(user_data.email, forKey: "email")
                UserDefaults.standard.setValue(user_data.username, forKey: "username")
                UserDefaults.standard.setValue(user_data.first_name, forKey: "first_name")
                UserDefaults.standard.setValue(user_data.last_name, forKey: "last_name")
                UserDefaults.standard.setValue(user_data.access_token, forKey: "access_token")
                UserDefaults.standard.setValue(user_data.refresh_token, forKey: "refresh_token")
                DispatchQueue.main.async {
                    self.dismiss(animated: true) {
                        self.dismiss(animated: true, completion: nil)
                    }
                }
            case .failure(let err):
                switch err {
                case AuthError.account_exists:
                    DispatchQueue.main.async {
                        AlertErrors.dismissError(vc: self, title: "Could not register user", message: "Email is already associated with an account")
                    }
                case MiscError.task_failed:
                    DispatchQueue.main.async {
                        AlertErrors.dismissError(vc: self, title: "Something went wrong", message: "Could not register user")
                    }
                default:
                    break
                }
                
            }
        }
        
        
    }
    
    

}

extension RegistrationViewController: UITextFieldDelegate, UIScrollViewDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameField {
            emailField.becomeFirstResponder()
        } else if textField == emailField {
            firstNameField.becomeFirstResponder()
        } else if textField == firstNameField {
            lastNameField.becomeFirstResponder()
        } else if textField == lastNameField {
            passwordField.becomeFirstResponder()
        } else if textField == passwordField {
            confirmPasswordField.becomeFirstResponder()
        } else if textField == confirmPasswordField {
            didTapRegisterButton()
        }
        return true
    }
        
}
