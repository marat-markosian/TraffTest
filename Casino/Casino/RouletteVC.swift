//
//  ViewController.swift
//  Casino
//
//  Created by Марат Маркосян on 02.12.2022.
//

import UIKit
import SimpleRoulette
import SwiftUI

class RouletteVC: UIViewController {
    
    private lazy var rolSwiftUI = ContentView()
    private lazy var rouletteSpin = UIHostingController(rootView: rolSwiftUI)
    
    private lazy var roulView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpSubviews()
        setUpAutoLayout()
    }
    
    private func setUpSubviews() {
        view.backgroundColor = .white
        
        view.addSubview(roulView)
        roulView.translatesAutoresizingMaskIntoConstraints = false
        rouletteSpin.view.translatesAutoresizingMaskIntoConstraints = false
        addChild(rouletteSpin)
        rouletteSpin.view.frame = roulView.frame
        roulView.addSubview(rouletteSpin.view)
        rouletteSpin.didMove(toParent: self)
        
    }

    private func setUpAutoLayout() {
        NSLayoutConstraint.activate([
            roulView.heightAnchor.constraint(equalToConstant: 200),
            roulView.widthAnchor.constraint(equalToConstant: 200),
            roulView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            roulView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            rouletteSpin.view.widthAnchor.constraint(equalToConstant: 200),
            rouletteSpin.view.heightAnchor.constraint(equalToConstant: 200)
        ])
    }

}

