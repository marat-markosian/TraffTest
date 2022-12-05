//
//  ViewController.swift
//  Casino
//
//  Created by Марат Маркосян on 02.12.2022.
//

import UIKit
import FirebaseAuth
import SwiftUI

class RouletteVC: UIViewController {
    
    private lazy var rolSwiftUI = ContentView()
    private lazy var rouletteSpin = UIHostingController(rootView: rolSwiftUI)
    
    private lazy var nameLbl = UILabel()
    
    private lazy var roulView = UIView()
    
    override func loadView() {
        super.loadView()
        
        if Auth.auth().currentUser != nil {
            let user = Auth.auth().currentUser
            UserInfo.instance.userID = user?.uid ?? ""
            UserInfo.instance.userDisplayName = user?.displayName ?? "Anonymous"
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpSubviews()
        setUpAutoLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        UserInfo.instance.getUserBalance()
    }
        
    private func setUpSubviews() {
        view.backgroundColor = .white
        
        UserInfo.instance.delegate = self
        
        view.addSubview(roulView)
        roulView.translatesAutoresizingMaskIntoConstraints = false
        rouletteSpin.view.translatesAutoresizingMaskIntoConstraints = false
        addChild(rouletteSpin)
        rouletteSpin.view.frame = roulView.frame
        roulView.addSubview(rouletteSpin.view)
        rouletteSpin.didMove(toParent: self)
        
        view.addSubview(nameLbl)
        nameLbl.textColor = .green
        nameLbl.font = UIFont(name: "Avenir-Heavy", size: 20)
        nameLbl.translatesAutoresizingMaskIntoConstraints = false
    }

    private func setUpAutoLayout() {
        NSLayoutConstraint.activate([
            roulView.heightAnchor.constraint(equalToConstant: 200),
            roulView.widthAnchor.constraint(equalToConstant: 200),
            roulView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            roulView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            rouletteSpin.view.widthAnchor.constraint(equalToConstant: 200),
            rouletteSpin.view.heightAnchor.constraint(equalToConstant: 200),
            
            nameLbl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            nameLbl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10)
        ])
    }

}

extension RouletteVC: UserDelegate {
    func updateInfo() {
        DispatchQueue.main.async {
            self.nameLbl.text = "\(UserInfo.instance.userDisplayName) \(UserInfo.instance.userBalance)$"
        }

    }
    
    
}
