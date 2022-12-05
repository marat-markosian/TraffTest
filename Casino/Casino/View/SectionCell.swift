//
//  SectionCell.swift
//  Casino
//
//  Created by Марат Маркосян on 05.12.2022.
//

import UIKit

class SectionCell: UICollectionViewCell {
    
    private lazy var name = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }

    
    private func setUpSubviews() {
        layer.cornerRadius = 5
        backgroundColor = .green
        
        addSubview(name)
        
        name.translatesAutoresizingMaskIntoConstraints = false
        name.text = "N"
        name.font = UIFont(name: "Avenir-Heavy", size: 15)
        name.textColor = .white
        
        NSLayoutConstraint.activate([
            name.centerXAnchor.constraint(equalTo: centerXAnchor),
            name.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    func setName(data: Sector) {
        name.text = "\(data.number)"
        if data.color.rawValue == "BLACK" {
            backgroundColor = .black
        } else if data.color.rawValue == "RED" {
            backgroundColor = .red
        } 
    }

    
}
