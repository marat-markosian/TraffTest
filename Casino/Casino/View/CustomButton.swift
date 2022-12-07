//
//  CustomButton.swift
//  Casino
//
//  Created by Марат Маркосян on 07.12.2022.
//

import UIKit

class CustomButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }

    private func setUpSubviews() {
        layer.borderColor = CGColor.init(red: 104/255, green: 240/255, blue: 135/255, alpha: 1)
        layer.borderWidth = 2
        layer.cornerRadius = 10
        
        titleLabel?.font = UIFont(name: "Avenir-Heavy", size: 25)
        setTitleColor(.black, for: .normal)
    }
}
