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
    private lazy var roulView = UIView()
    
    private lazy var nameLbl = UILabel()
    private lazy var tableBet = UIButton()
    
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
        
        view.addSubview(tableBet)
        tableBet.translatesAutoresizingMaskIntoConstraints = false
        tableBet.setTitleColor(.blue, for: .normal)
        tableBet.setTitle("Choose Sector", for: .normal)
        tableBet.titleLabel?.font = UIFont(name: "Avenir", size: 20)
        tableBet.addTarget(self, action: #selector(moveToTable), for: .touchUpInside)
    }

    private func setUpAutoLayout() {
        NSLayoutConstraint.activate([
            roulView.heightAnchor.constraint(equalToConstant: 500),
            roulView.widthAnchor.constraint(equalToConstant: 200),
            roulView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            roulView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            rouletteSpin.view.widthAnchor.constraint(equalToConstant: 200),
            rouletteSpin.view.heightAnchor.constraint(equalToConstant: 500),
            
            nameLbl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            nameLbl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            
            tableBet.topAnchor.constraint(equalTo: roulView.bottomAnchor),
            tableBet.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    @objc private func moveToTable() {
        let table = TableVC()
        table.delegate = self
        present(table, animated: true)
    }

}

extension RouletteVC: UserDelegate {
    func updateInfo() {
        DispatchQueue.main.async {
            self.nameLbl.text = "\(UserInfo.instance.userDisplayName) \(UserInfo.instance.userBalance)$"
        }

    }
}

extension RouletteVC: GameDelegate {
    func updateBet() {
        var newTitle = ""
        if Game.instance.bet == -1 {
            switch Game.instance.rangeBet {
            case 1...12:
                newTitle = "Bet on 1st Dozen"
            case 13...24:
                newTitle = "Bet on 2nd Dozen"
            case 25...36:
                newTitle = "Bet on 3rd Dozen"
            case 1...4:
                newTitle = "Bet on 1st Column"
            case 2...5:
                newTitle = "Bet on 2nd Column"
            case 3...6:
                newTitle = "Bet on 3rd Column"
            default:
                newTitle = "Choose Sector"
            }
        } else {
            newTitle = "Bet on \(Game.instance.bet)"
        }
        DispatchQueue.main.async {
            self.tableBet.setTitle(newTitle, for: .normal)
        }
    }
}
