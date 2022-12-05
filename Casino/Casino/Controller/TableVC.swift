//
//  TableVC.swift
//  Casino
//
//  Created by Марат Маркосян on 05.12.2022.
//

import UIKit

class TableVC: UIViewController {
    
    private lazy var mainTable = UICollectionView(frame: view.frame, collectionViewLayout: UICollectionViewFlowLayout())
    private lazy var zero = UIButton()
    private lazy var firstDozen = UIButton()
    private lazy var secondDozen = UIButton()
    private lazy var thirdDozen = UIButton()
    private lazy var firstColumn = UIButton()
    private lazy var secondColumn = UIButton()
    private lazy var thirdColumn = UIButton()
    
    var sectorWidth: CGFloat = 0
    var sectorHeight: CGFloat = 0
    
    var delegate: GameDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpSubviews()
        setUpAutoLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        Game.instance.bet = -1
    }
    
    private func setUpSubviews() {
        view.backgroundColor = .white
        
        view.addSubview(mainTable)
        
        mainTable.delegate = self
        mainTable.dataSource = self
        
        mainTable.register(SectionCell.self, forCellWithReuseIdentifier: "Reuse")
        mainTable.translatesAutoresizingMaskIntoConstraints = false
        mainTable.showsVerticalScrollIndicator = false
        
        view.addSubview(zero)
        zero.setTitle("0", for: .normal)
        zero.backgroundColor = .green
        zero.setTitleColor(.white, for: .normal)
        zero.translatesAutoresizingMaskIntoConstraints = false
        zero.titleLabel?.font = UIFont(name: "Avenir-Heavy", size: 20)
        zero.layer.cornerRadius = 5
        
        view.addSubview(firstDozen)
        view.addSubview(secondDozen)
        view.addSubview(thirdDozen)
        
        firstDozen.translatesAutoresizingMaskIntoConstraints = false
        secondDozen.translatesAutoresizingMaskIntoConstraints = false
        thirdDozen.translatesAutoresizingMaskIntoConstraints = false

        firstDozen.setTitleColor(.white, for: .normal)
        secondDozen.setTitleColor(.white, for: .normal)
        thirdDozen.setTitleColor(.white, for: .normal)

        firstDozen.backgroundColor = .red
        secondDozen.backgroundColor = .red
        thirdDozen.backgroundColor = .red
        
        firstDozen.setTitle("1st", for: .normal)
        secondDozen.setTitle("2nd", for: .normal)
        thirdDozen.setTitle("3rd", for: .normal)

        firstDozen.layer.cornerRadius = 5
        secondDozen.layer.cornerRadius = 5
        thirdDozen.layer.cornerRadius = 5
        
        view.addSubview(firstColumn)
        view.addSubview(secondColumn)
        view.addSubview(thirdColumn)
        
        firstColumn.translatesAutoresizingMaskIntoConstraints = false
        secondColumn.translatesAutoresizingMaskIntoConstraints = false
        thirdColumn.translatesAutoresizingMaskIntoConstraints = false
        
        firstColumn.setTitleColor(.white, for: .normal)
        secondColumn.setTitleColor(.white, for: .normal)
        thirdColumn.setTitleColor(.white, for: .normal)

        firstColumn.backgroundColor = .red
        secondColumn.backgroundColor = .red
        thirdColumn.backgroundColor = .red

        firstColumn.layer.cornerRadius = 5
        secondColumn.layer.cornerRadius = 5
        thirdColumn.layer.cornerRadius = 5

        firstColumn.setTitle("2:1", for: .normal)
        secondColumn.setTitle("2:1", for: .normal)
        thirdColumn.setTitle("2:1", for: .normal)
        
        zero.tag = 0
        firstDozen.tag = 1
        secondDozen.tag = 2
        thirdDozen.tag = 3
        firstColumn.tag = 4
        secondColumn.tag = 5
        thirdColumn.tag = 6
        
        
        zero.addTarget(self, action: #selector(makeBet), for: .touchUpInside)
        firstColumn.addTarget(self, action: #selector(makeBet), for: .touchUpInside)
        firstDozen.addTarget(self, action: #selector(makeBet), for: .touchUpInside)
        secondColumn.addTarget(self, action: #selector(makeBet), for: .touchUpInside)
        secondDozen.addTarget(self, action: #selector(makeBet), for: .touchUpInside)
        thirdColumn.addTarget(self, action: #selector(makeBet), for: .touchUpInside)
        thirdDozen.addTarget(self, action: #selector(makeBet), for: .touchUpInside)
    }
    
    private func setUpAutoLayout() {
        NSLayoutConstraint.activate([
            mainTable.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            mainTable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            mainTable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100),
            mainTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -60),
            
            zero.bottomAnchor.constraint(equalTo: mainTable.topAnchor, constant: -5),
            zero.centerXAnchor.constraint(equalTo: mainTable.centerXAnchor),
            
            firstDozen.trailingAnchor.constraint(equalTo: mainTable.leadingAnchor, constant: -3),
            firstDozen.topAnchor.constraint(equalTo: mainTable.topAnchor),
            
            secondDozen.trailingAnchor.constraint(equalTo: firstDozen.trailingAnchor),
            thirdDozen.trailingAnchor.constraint(equalTo: firstDozen.trailingAnchor),
            
            firstColumn.leadingAnchor.constraint(equalTo: mainTable.leadingAnchor),
            secondColumn.centerXAnchor.constraint(equalTo: mainTable.centerXAnchor),
            thirdColumn.trailingAnchor.constraint(equalTo: mainTable.trailingAnchor)
        ])
    }
    
    @objc private func makeBet(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            Game.instance.bet = 0
        case 1:
            Game.instance.rangeBet = 1...12
        case 2:
            Game.instance.rangeBet = 13...24
        case 3:
            Game.instance.rangeBet = 25...36
        case 4:
            Game.instance.rangeBet = 1...4
        case 5:
            Game.instance.rangeBet = 2...5
        case 6:
            Game.instance.rangeBet = 3...6
        default:
            Game.instance.bet = -1
        }
        delegate?.updateBet()
        dismiss(animated: true)
    }

}

extension TableVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        Game.instance.sectors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = mainTable.dequeueReusableCell(withReuseIdentifier: "Reuse", for: indexPath) as? SectionCell {
            let sectorData = Game.instance.sectors[indexPath.row]
            cell.setName(data: sectorData)
            return cell
        }
        return SectionCell()

    }
    
    
    
}

extension TableVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sector = Game.instance.sectors[indexPath.row]
        Game.instance.bet = sector.number
        delegate?.updateBet()
        dismiss(animated: true)
    }
    
}

extension TableVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let widthPerItem = mainTable.bounds.width / 3
        guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else { return CGSize(width: widthPerItem, height: widthPerItem) }
        let numbersOfCellsPerRow: CGFloat = 3
        let offset = flowLayout.sectionInset.right
            + flowLayout.sectionInset.left
            + (flowLayout.minimumInteritemSpacing * (numbersOfCellsPerRow - 1))
        
        let width = (collectionView.bounds.width - offset) / numbersOfCellsPerRow
        sectorWidth = width
        sectorHeight = width / 2
        zero.widthAnchor.constraint(equalToConstant: sectorWidth * 3).isActive = true
        zero.heightAnchor.constraint(equalToConstant: sectorHeight).isActive = true
        
        firstDozen.widthAnchor.constraint(equalToConstant: sectorWidth / 2).isActive = true
        firstDozen.heightAnchor.constraint(equalToConstant: mainTable.frame.height / 3 - offset / 2).isActive = true
        
        secondDozen.topAnchor.constraint(equalTo: firstDozen.bottomAnchor, constant: offset / 2).isActive = true
        secondDozen.heightAnchor.constraint(equalToConstant: mainTable.frame.height / 3 - offset / 2).isActive = true
        secondDozen.widthAnchor.constraint(equalToConstant: sectorWidth / 2).isActive = true
        
        thirdDozen.topAnchor.constraint(equalTo: secondDozen.bottomAnchor, constant: offset / 2).isActive = true
        thirdDozen.heightAnchor.constraint(equalToConstant: mainTable.frame.height / 3 - offset / 2).isActive = true
        thirdDozen.widthAnchor.constraint(equalToConstant: sectorWidth / 2).isActive = true
        
        firstColumn.topAnchor.constraint(equalTo: mainTable.bottomAnchor).isActive = true
        firstColumn.widthAnchor.constraint(equalToConstant: sectorWidth).isActive = true
        firstColumn.heightAnchor.constraint(equalToConstant: sectorHeight).isActive = true
        
        secondColumn.topAnchor.constraint(equalTo: mainTable.bottomAnchor).isActive = true
        secondColumn.widthAnchor.constraint(equalToConstant: sectorWidth).isActive = true
        secondColumn.heightAnchor.constraint(equalToConstant: sectorHeight).isActive = true

        thirdColumn.topAnchor.constraint(equalTo: mainTable.bottomAnchor).isActive = true
        thirdColumn.widthAnchor.constraint(equalToConstant: sectorWidth).isActive = true
        thirdColumn.heightAnchor.constraint(equalToConstant: sectorHeight).isActive = true

        
        return CGSize(width: width, height: width / 2)
      }
}

