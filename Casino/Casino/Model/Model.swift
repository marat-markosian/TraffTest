//
//  Model.swift
//  Casino
//
//  Created by Марат Маркосян on 04.12.2022.
//

import Foundation
import FirebaseFirestore

protocol UserDelegate {
    
    func updateInfo()
    
}

protocol GameDelegate {
    
    func updateBet()
    
}

struct UserInfo {
    
    static var instance = UserInfo()
    
    let data = Firestore.firestore()
    var delegate: UserDelegate?
    
    var userDisplayName = ""
    var userID = ""
    var userBalance = 0

    var newBalances: [[String : Any]] = []
    var balancesID: [String] = []
        
    func getUserBalance() {
        let docRef = data.collection("Balances").document(UserInfo.instance.userID)

        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let balanceInt = document.data()?["balance"] as! Int
                UserInfo.instance.userBalance = balanceInt
                delegate?.updateInfo()
            } else {
                print("Document does not exist")
            }
        }
    }

}

struct Game {
    
    static var instance = Game()
    
    var bet: Int = -1
    var rangeBet: ClosedRange = -1 ... -1
    var resultSect: Sector = Sector(number: -1, color: .empty)
    
    let sectors: [Sector] = [
                             Sector(number: 1, color: .red),
                             Sector(number: 2, color: .black),
                             Sector(number: 3, color: .red),
                             Sector(number: 4, color: .black),
                             Sector(number: 5, color: .red),
                             Sector(number: 6, color: .black),
                             Sector(number: 7, color: .red),
                             Sector(number: 8, color: .black),
                             Sector(number: 9, color: .red),
                             Sector(number: 10, color: .black),
                             Sector(number: 11, color: .black),
                             Sector(number: 12, color: .red),
                             Sector(number: 13, color: .black),
                             Sector(number: 14, color: .red),
                             Sector(number: 15, color: .black),
                             Sector(number: 16, color: .red),
                             Sector(number: 17, color: .black),
                             Sector(number: 18, color: .red),
                             Sector(number: 19, color: .red),
                             Sector(number: 20, color: .black),
                             Sector(number: 21, color: .red),
                             Sector(number: 22, color: .black),
                             Sector(number: 23, color: .red),
                             Sector(number: 24, color: .black),
                             Sector(number: 25, color: .red),
                             Sector(number: 26, color: .black),
                             Sector(number: 27, color: .red),
                             Sector(number: 28, color: .black),
                             Sector(number: 29, color: .black),
                             Sector(number: 30, color: .red),
                             Sector(number: 31, color: .black),
                             Sector(number: 32, color: .red),
                             Sector(number: 33, color: .black),
                             Sector(number: 34, color: .red),
                             Sector(number: 35, color: .black),
                             Sector(number: 36, color: .red)                             
    ]

}
