//
//  LoginViewController.swift
//  notesApp
//
//  Created by Arkash Vijayakumar on 17/12/2021.
//



import UIKit
import SafariServices

class LoginViewController: UIViewController {
    
    private let logoView: UIImageView = {
        let logoView = UIImageView()
        let config = UIImage.SymbolConfiguration(pointSize: 45, weight: .regular, scale: .default)
        let logoImage = UIImage(systemName: "books.vertical.fill")?.withTintColor(Constants.secondaryColor, renderingMode: .alwaysOriginal).withConfiguration(config)
        logoView.image = logoImage
        return logoView
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
    
    private let passwordField: UnderlinedTextField = {
        let passwordField = UnderlinedTextField()
        passwordField.placeholder = "Enter Password..."
        passwordField.textColor = .label
        passwordField.autocorrectionType = .no
        passwordField.autocapitalizationType = .none
        passwordField.returnKeyType = .done
        passwordField.isSecureTextEntry = true
        passwordField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        passwordField.leftViewMode = .always
        return passwordField
    }()
    
    private let createAccountButton: UIButton = {
        let createAccountButton = UIButton()
        createAccountButton.setTitle("New User? Click here to create an account", for: .normal)
        createAccountButton.setTitleColor(.label, for: .normal)
        createAccountButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .regular)
        return createAccountButton
    }()
    
    
    private let loginButton: UIButton = {
        let loginButton = UIButton()
        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(.label, for: .normal)
        loginButton.backgroundColor = Constants.secondaryColor
        loginButton.layer.cornerRadius = Constants.cornerRadius
        loginButton.layer.borderWidth = 1.0
        loginButton.layer.borderColor = loginButton.backgroundColor?.cgColor
        return loginButton
    }()
    
    private let termsButton: UIButton = {
        let termsButton = UIButton()
        termsButton.setTitle("Terms Of Service", for: .normal)
        termsButton.setTitleColor(.label, for: .normal)
        termsButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .regular)
        return termsButton
    }()
    
    private let privacyButton: UIButton = {
        let privacyButton = UIButton()
        privacyButton.setTitle("Privacy Policies", for: .normal)
        privacyButton.setTitleColor(.label, for: .normal)
        privacyButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .regular)
        return privacyButton
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.backgroundColor
        addSubviewsAndDelegates()
        addTargets()
        
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let logoSize = view.width/2
        let loginSize = view.width/3
        let otherSize = view.width/2
        
        logoView.frame = CGRect(x: view.frame.midX - logoSize/2,
                                y: view.safeAreaInsets.top + 100,
                                width: logoSize,
                                height: 100)
        
        emailField.frame = CGRect(x: 25,
                                  y: logoView.frame.maxY + 100,
                                  width: view.width-50,
                                  height: 52)
        
        passwordField.frame = CGRect(x: 25,
                                     y: emailField.frame.maxY + 10,
                                     width: view.width-50,
                                     height: 52)

        createAccountButton.frame = CGRect(x: 15,
                                           y: passwordField.frame.maxY + 5,
                                           width: view.width - 30,
                                           height: 45)
        
        loginButton.frame = CGRect(x: view.frame.midX - loginSize/2,
                                   y: createAccountButton.frame.maxY+20,
                                   width: loginSize,
                                   height: 45)
        
        termsButton.frame = CGRect(x: view.frame.midX-otherSize/2,
                                   y: view.height - 140,
                                   width: otherSize,
                                   height: 40)
        
        privacyButton.frame = CGRect(x: view.frame.midX-otherSize/2,
                                     y: view.height - 100,
                                     width: otherSize,
                                     height: 40)
        
        
    }
    
    private func addSubviewsAndDelegates() {
        view.addSubview(logoView)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(createAccountButton)
        view.addSubview(loginButton)
        view.addSubview(termsButton)
        view.addSubview(privacyButton)
        emailField.delegate = self
        passwordField.delegate = self
    }
    
    private func addTargets() {
        createAccountButton.addTarget(self, action: #selector(didTapCreateAccountButton), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        termsButton.addTarget(self, action: #selector(didTapTermsButton), for: .touchUpInside)
        privacyButton.addTarget(self, action: #selector(didTapPrivacyButton), for: .touchUpInside)

    }
    
    //@objc methods

    @objc private func didTapTermsButton() {
        guard let url = URL(string: "https://help.instagram.com/581066165581870") else {
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true, completion: nil)
    }
    
    @objc private func didTapPrivacyButton() {
        guard let url = URL(string: "https://help.instagram.com/811572406418223/?helpref=hc_fnav") else {
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true, completion: nil)
    }
    
    
    @objc private func didTapCreateAccountButton() {
        let vc = RegistrationViewController()
        vc.modalPresentationStyle = .fullScreen
        let navVc = UINavigationController(rootViewController: vc)
        navVc.modalPresentationStyle = .fullScreen
        present(navVc, animated: true, completion: nil)
    }

    
    
    @objc private func didTapLoginButton() {
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        
        guard let email = emailField.text?.replacingOccurrences(of: " ", with: ""), !email.isEmpty,
              let password = passwordField.text?.replacingOccurrences(of: " ", with: ""), !password.isEmpty else {
                  AlertErrors.dismissError(vc: self,
                                           title: "Could not sign in user",
                                           message: "Please fill in all fields")
                  return
              }
        
        AuthManager.shared.loginUser(email: email, password: password) { result in
            switch result {
            case .success(let model):
                UserDefaults.standard.setValue(model.id, forKey: "user_id")
                UserDefaults.standard.setValue(model.email, forKey: "email")
                UserDefaults.standard.setValue(model.username, forKey: "username")
                UserDefaults.standard.setValue(model.first_name, forKey: "first_name")
                UserDefaults.standard.setValue(model.last_name, forKey: "last_name")
                UserDefaults.standard.setValue(model.access_token, forKey: "access_token")
                UserDefaults.standard.setValue(model.refresh_token, forKey: "refresh_token")
                
                DispatchQueue.main.async {
                    self.dismiss(animated: true, completion: nil)
                }
            case .failure(let err):
                switch err {
                case AuthError.user_not_exist:
                    DispatchQueue.main.async {
                        AlertErrors.dismissError(vc: self, title: "Could not Login User", message: "Email provided is not associated with any user")
                    }
                    
                case AuthError.incorrect_password:
                    DispatchQueue.main.async {
                        AlertErrors.dismissError(vc: self, title: "Could not Login User", message: "Password is incorrect")
                    }
                default:
                    DispatchQueue.main.async {
                        AlertErrors.dismissError(vc: self, title: "Could not Login User", message: "Something went wrong")
                    }
                    print(err)
                }
            }
        }
        
    }
    
    
    
    
    
}


extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailField {
            passwordField.becomeFirstResponder()
        } else if textField == passwordField {
            didTapLoginButton()
        }
        return true
    }
}











