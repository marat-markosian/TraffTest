//
//  SignUpVC.swift
//  Casino
//
//  Created by Марат Маркосян on 02.12.2022.
//

import UIKit
import FirebaseFirestore
import FirebaseAuth

class SignUpVC: UIViewController {

    private lazy var emailTxt = CustomTxtField()
    private lazy var passwordTxt = CustomTxtField()
    private lazy var signupBtn = UIButton()
    private lazy var nameTxt = CustomTxtField()
    private lazy var anonymBtn = UIButton()

    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpSubviews()
        setUpAutoLayout()
    }
    
    private func setUpSubviews() {
        view.backgroundColor = .white
        
        view.addSubview(emailTxt)
        view.addSubview(passwordTxt)
        view.addSubview(signupBtn)
        view.addSubview(nameTxt)
        view.addSubview(anonymBtn)
        
        emailTxt.translatesAutoresizingMaskIntoConstraints = false
        passwordTxt.translatesAutoresizingMaskIntoConstraints = false
        signupBtn.translatesAutoresizingMaskIntoConstraints = false
        nameTxt.translatesAutoresizingMaskIntoConstraints = false
        anonymBtn.translatesAutoresizingMaskIntoConstraints = false
                
        signupBtn.titleLabel?.font = UIFont(name: "Avenir-Heavy", size: 25)
        signupBtn.setTitleColor(.black, for: .normal)
        signupBtn.setTitle("Sign Up", for: .normal)
        signupBtn.addTarget(self, action: #selector(signUp), for: .touchUpInside)

        emailTxt.placeholder = "e-mail"
        passwordTxt.placeholder = "password"
        nameTxt.placeholder = "name"
        
        emailTxt.textContentType = .emailAddress
        passwordTxt.textContentType = .password
        emailTxt.keyboardType = .emailAddress
        passwordTxt.isSecureTextEntry = true
        
        anonymBtn.setTitle("Anonymous SignUp", for: .normal)
        anonymBtn.setTitleColor(.black, for: .normal)
        anonymBtn.titleLabel?.font = UIFont(name: "Avenir", size: 20)
        anonymBtn.addTarget(self, action: #selector(signAnonym), for: .touchUpInside)
    }
    
    private func setUpAutoLayout() {
        NSLayoutConstraint.activate([
            emailTxt.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            emailTxt.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            emailTxt.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            emailTxt.heightAnchor.constraint(equalToConstant: 40),
            
            passwordTxt.topAnchor.constraint(equalTo: emailTxt.bottomAnchor, constant: 30),
            passwordTxt.leadingAnchor.constraint(equalTo: emailTxt.leadingAnchor),
            passwordTxt.trailingAnchor.constraint(equalTo: emailTxt.trailingAnchor),
            passwordTxt.heightAnchor.constraint(equalToConstant: 40),
                        
            nameTxt.topAnchor.constraint(equalTo: passwordTxt.bottomAnchor, constant: 30),
            nameTxt.leadingAnchor.constraint(equalTo: passwordTxt.leadingAnchor),
            nameTxt.trailingAnchor.constraint(equalTo: passwordTxt.trailingAnchor),
            nameTxt.heightAnchor.constraint(equalToConstant: 40),
            
            signupBtn.topAnchor.constraint(equalTo: nameTxt.bottomAnchor, constant: 50),
            signupBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            anonymBtn.topAnchor.constraint(equalTo: signupBtn.bottomAnchor, constant: 20),
            anonymBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor)

        ])

    }
    
}

extension SignUpVC {
    
    func signUpToServer(email: String, password: String, name: String) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let result = authResult {
                
                let changeReq = Auth.auth().currentUser?.createProfileChangeRequest()
                changeReq?.displayName = name
                changeReq?.commitChanges() { error in
                    self.showError(descr: error?.localizedDescription ?? "Name was not saved")
                }
                self.setUserBalance(id: result.user.uid)
                UserDefaults.standard.set(true, forKey: "isSighedUp")
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
    
    @objc func signUp() {
        
        if let email = emailTxt.text, let password = passwordTxt.text, let name = nameTxt.text {
                if password.count > 8 {
                    signUpToServer(email: email, password: password, name: name)
                } else {
                    showError(descr: "Password should contain more then 8 characters")
                }
        }
        
    }
    
    @objc private func signAnonym() {
        Auth.auth().signInAnonymously { authResult, error in
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

        }
    }
    
    func setUserBalance(id: String) {
        db.collection("Balances").document(id).setData([
            "balance": 2000,
        ]) { err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
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
