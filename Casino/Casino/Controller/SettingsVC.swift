//
//  SettingsVC.swift
//  Casino
//
//  Created by Марат Маркосян on 04.12.2022.
//

import UIKit
import FirebaseAuth
import StoreKit

class SettingsVC: UIViewController {
    
    private lazy var logoutBtn = CustomButton()
    private lazy var deleteBtn = CustomButton()
    private lazy var rateBtn = CustomButton()
    private lazy var shareBtn = CustomButton()

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpSubviews()
        setUpAutoLayout()
    }
    
    private func setUpSubviews() {
        view.backgroundColor = .white
        
        view.addSubview(logoutBtn)
        view.addSubview(deleteBtn)
        view.addSubview(rateBtn)
        view.addSubview(shareBtn)
        
        logoutBtn.setTitle("Log Out", for: .normal)
        deleteBtn.setTitle("Delete Account", for: .normal)
        rateBtn.setTitle("Rate App", for: .normal)
        shareBtn.setTitle("Share", for: .normal)
        
        logoutBtn.tag = 1
        deleteBtn.tag = 2
        rateBtn.tag = 3
        shareBtn.tag = 4
        
        logoutBtn.translatesAutoresizingMaskIntoConstraints = false
        deleteBtn.translatesAutoresizingMaskIntoConstraints = false
        rateBtn.translatesAutoresizingMaskIntoConstraints = false
        shareBtn.translatesAutoresizingMaskIntoConstraints = false
        
        logoutBtn.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        deleteBtn.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        rateBtn.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        shareBtn.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)

    }
    
    private func setUpAutoLayout() {
        NSLayoutConstraint.activate([
            logoutBtn.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            logoutBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoutBtn.widthAnchor.constraint(equalToConstant: 200),
            
            deleteBtn.topAnchor.constraint(equalTo: logoutBtn.bottomAnchor, constant: 20),
            deleteBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            deleteBtn.widthAnchor.constraint(equalToConstant: 200),
            
            rateBtn.topAnchor.constraint(equalTo: deleteBtn.bottomAnchor, constant: 20),
            rateBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            rateBtn.widthAnchor.constraint(equalToConstant: 200),
            
            shareBtn.topAnchor.constraint(equalTo: rateBtn.bottomAnchor, constant: 20),
            shareBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            shareBtn.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    func showError(descr: String) {
        let alert = UIAlertController(title: "Error", message: descr, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .cancel) { (action) in
        }
        
        alert.addAction(alertAction)
        present(alert, animated: true)
        
    }

    @objc private func buttonPressed(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            let firebaseAuth = Auth.auth()
            do {
                try firebaseAuth.signOut()
                UserDefaults.standard.set(false, forKey: "isLogedIn")
            } catch let signOutError as NSError {
                self.showError(descr: signOutError.localizedDescription)
            }
        case 2:
            let user = Auth.auth().currentUser
            user?.delete { error in
              if let error = error {
                  self.showError(descr: error.localizedDescription)
              } else {
                  UserDefaults.standard.set(false, forKey: "isSighedUp")
                  UserDefaults.standard.set(false, forKey: "isLogedIn")
                  UserInfo.instance.deleteUserDoc()
              }
            }
        case 3:
            SKStoreReviewController.requestReview()
        case 4:
            let items = [URL(string: "https://djinni.co/jobs/494918-junior-ios-developer-ionic-/")!]
            let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
            present(ac, animated: true)
        default:
            break
        }
    }
}
