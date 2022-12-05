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
    
    var bet: Sector?
    
}
