//
//  LogInVC.swift
//  Casino
//
//  Created by Марат Маркосян on 02.12.2022.
//

import UIKit
import FirebaseAuth
import GoogleSignIn

class LogInVC: UIViewController {

    private lazy var emailTxt = CustomTxtField()
    private lazy var passwordTxt = CustomTxtField()
    private lazy var loginBtn = UIButton()
    
    override func loadView() {
        super.loadView()
        
        setUpSubviews()
        setUpAutoLayout()
    }
    
    private func setUpSubviews() {
        view.backgroundColor = .white
        
        view.addSubview(emailTxt)
        view.addSubview(passwordTxt)
        view.addSubview(loginBtn)
        
        emailTxt.translatesAutoresizingMaskIntoConstraints = false
        passwordTxt.translatesAutoresizingMaskIntoConstraints = false
        loginBtn.translatesAutoresizingMaskIntoConstraints = false
                
        loginBtn.titleLabel?.font = UIFont(name: "Avenir-Heavy", size: 25)
        loginBtn.setTitleColor(.black, for: .normal)
        loginBtn.setTitle("Log In", for: .normal)
        loginBtn.addTarget(self, action: #selector(logIn), for: .touchUpInside)

        emailTxt.placeholder = "e-mail"
        passwordTxt.placeholder = "password"
        
        emailTxt.textContentType = .emailAddress
        passwordTxt.textContentType = .password
        emailTxt.keyboardType = .emailAddress
        passwordTxt.isSecureTextEntry = true
        
    }
    
    
    private func setUpAutoLayout() {
        NSLayoutConstraint.activate([
            emailTxt.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            emailTxt.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant:  10),
            emailTxt.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            emailTxt.heightAnchor.constraint(equalToConstant: 40),
            
            passwordTxt.topAnchor.constraint(equalTo: emailTxt.bottomAnchor, constant: 30),
            passwordTxt.leadingAnchor.constraint(equalTo: emailTxt.leadingAnchor),
            passwordTxt.trailingAnchor.constraint(equalTo: emailTxt.trailingAnchor),
            passwordTxt.heightAnchor.constraint(equalToConstant: 40),
            
            loginBtn.topAnchor.constraint(equalTo: passwordTxt.bottomAnchor, constant: 50),
            loginBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            
        ])
    }

}

extension LogInVC {
    
    func login(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [self] authResult, error in
            if authResult != nil {
                UserDefaults.standard.set(true, forKey: "isLogedIn")
                guard let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate,
                      let window = sceneDelegate.window else { return }
                let gameView = RouletteVC()
                gameView.tabBarItem = UITabBarItem(title: "Game", image: UIImage(systemName: "gamecontroller"), selectedImage: UIImage(systemName: "gamecontroller.fill"))
                
                let settingsView = SettingsVC()
                settingsView.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gearshape"), selectedImage: UIImage(systemName: "gearshape.fill"))
                
                let nextNavigationController = UINavigationController(rootViewController: gameView)
                let tabBarController = UITabBarController()
                tabBarController.setViewControllers([gameView, settingsView], animated: false)
                window.rootViewController = tabBarController
            } else if let error = error {
                self.showError(descr: error.localizedDescription)
            }
        }
    }
    
    
    @objc func logIn() {
        if let email = emailTxt.text, let password = passwordTxt.text {
            if password.count > 8 {
                login(email: email, password: password)
            } else {
                showError(descr: "Password should contain more then 8 characters")
            }
        }

    }
    
    func showError(descr: String) {
        let alert = UIAlertController(title: "Error", message: descr, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .cancel) { (action) in
        }
        
        alert.addAction(alertAction)
        present(alert, animated: true)
        
    }
    
}
