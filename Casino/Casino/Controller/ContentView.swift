//
//  ContentView.swift
//  Roulette
//
//  Created by Petros Demetrakopoulos on 12/2/21.
//

import SwiftUI

enum Color: String {
    case red = "RED"
    case black = "BLACK"
    case green = "ZERO"
    case empty
}
struct Sector: Equatable {
    let number: Int
    let color: Color
}
struct ContentView: View {
    @State private var showingAlert = false
    @State private var isAnimating = false
    @State private var spinDegrees = 0.0
    @State private var rand = 0.0
    @State private var newAngle = 0.0
    let halfSector = 360.0 / 37.0 / 2.0
    let sectors: [Sector] = [Sector(number: 32, color: .red),
                             Sector(number: 15, color: .black),
                             Sector(number: 19, color: .red),
                             Sector(number: 4, color: .black),
                             Sector(number: 21, color: .red),
                             Sector(number: 2, color: .black),
                             Sector(number: 25, color: .red),
                             Sector(number: 17, color: .black),
                             Sector(number: 34, color: .red),
                             Sector(number: 6, color: .black),
                             Sector(number: 27, color: .red),
                             Sector(number: 13, color: .black),
                             Sector(number: 36, color: .red),
                             Sector(number: 11, color: .black),
                             Sector(number: 30, color: .red),
                             Sector(number: 8, color: .black),
                             Sector(number: 23, color: .red),
                             Sector(number: 10, color: .black),
                             Sector(number: 5, color: .red),
                             Sector(number: 24, color: .black),
                             Sector(number: 16, color: .red),
                             Sector(number: 33, color: .black),
                             Sector(number: 1, color: .red),
                             Sector(number: 20, color: .black),
                             Sector(number: 14, color: .red),
                             Sector(number: 31, color: .black),
                             Sector(number: 9, color: .red),
                             Sector(number: 22, color: .black),
                             Sector(number: 18, color: .red),
                             Sector(number: 29, color: .black),
                             Sector(number: 7, color: .red),
                             Sector(number: 28, color: .black),
                             Sector(number: 12, color: .red),
                             Sector(number: 35, color: .black),
                             Sector(number: 3, color: .red),
                             Sector(number: 26, color: .black),
                             Sector(number: 0, color: .green)]
    var spinAnimation: Animation {
        Animation.easeOut(duration: 3.0)
            .repeatCount(1, autoreverses: false)
    }
    
    func getAngle(angle: Double) -> Double {
        let deg = 360 - angle.truncatingRemainder(dividingBy: 360)
        return deg
    }
    
    func sectorFromAngle(angle: Double) -> String {
        var i = 0
        var sector: Sector = Sector(number: -1, color: .empty)
        
        while sector == Sector(number: -1, color: .empty) && i < sectors.count {
            let start: Double = halfSector * Double((i * 2 + 1)) - halfSector
            let end: Double = halfSector * Double((i * 2 + 3))
            
            if(angle >= start && angle < end) {
                sector = sectors[i]
            }
            i += 1
        }
        Game.instance.resultSect = sector
        if Game.instance.bet != -1 {
            if Game.instance.bet == sector.number {
                let newBalance = (Game.instance.betValue * 35) + UserInfo.instance.userBalance
                UserInfo.instance.updateBalance(newBalance: newBalance)
                UserInfo.instance.getUserBalance()
                UserInfo.instance.delegate?.updateInfo()
            } else {
                let newBalance = UserInfo.instance.userBalance - Game.instance.betValue
                UserInfo.instance.updateBalance(newBalance: newBalance)
                UserInfo.instance.getUserBalance()
                UserInfo.instance.delegate?.updateInfo()
            }
        } else {
            switch Game.instance.rangeBet {
            case 1...4:
                var num = 1
                for _ in 1...12 {
                    if num == sector.number {
                        let newBalance = (Game.instance.betValue * 2) + UserInfo.instance.userBalance
                        UserInfo.instance.updateBalance(newBalance: newBalance)
                        UserInfo.instance.getUserBalance()
                        UserInfo.instance.delegate?.updateInfo()
                        break
                    }
                    num += 3
                }
                let newBalance = UserInfo.instance.userBalance - Game.instance.betValue
                UserInfo.instance.updateBalance(newBalance: newBalance)
                UserInfo.instance.getUserBalance()
                UserInfo.instance.delegate?.updateInfo()
            case 2...5:
                var num = 2
                for _ in 1...12 {
                    if num == sector.number {
                        let newBalance = (Game.instance.betValue * 2) + UserInfo.instance.userBalance
                        UserInfo.instance.updateBalance(newBalance: newBalance)
                        UserInfo.instance.getUserBalance()
                        UserInfo.instance.delegate?.updateInfo()
                        break
                    }
                    num += 3
                }
                let newBalance = UserInfo.instance.userBalance - Game.instance.betValue
                UserInfo.instance.updateBalance(newBalance: newBalance)
                UserInfo.instance.getUserBalance()
                UserInfo.instance.delegate?.updateInfo()
            case 3...6:
                var num = 3
                for _ in 1...12 {
                    if num == sector.number {
                        let newBalance = (Game.instance.betValue * 2) + UserInfo.instance.userBalance
                        UserInfo.instance.updateBalance(newBalance: newBalance)
                        UserInfo.instance.getUserBalance()
                        UserInfo.instance.delegate?.updateInfo()
                        break
                    }
                    num += 3
                }
                let newBalance = UserInfo.instance.userBalance - Game.instance.betValue
                UserInfo.instance.updateBalance(newBalance: newBalance)
                UserInfo.instance.getUserBalance()
                UserInfo.instance.delegate?.updateInfo()
            case 1...12:
                if Game.instance.rangeBet.contains(sector.number) {
                    let newBalance = (Game.instance.betValue * 2) + UserInfo.instance.userBalance
                    UserInfo.instance.updateBalance(newBalance: newBalance)
                    UserInfo.instance.getUserBalance()
                    UserInfo.instance.delegate?.updateInfo()
                } else {
                    let newBalance = UserInfo.instance.userBalance - Game.instance.betValue
                    UserInfo.instance.updateBalance(newBalance: newBalance)
                    UserInfo.instance.getUserBalance()
                    UserInfo.instance.delegate?.updateInfo()
                }
            case 13...24:
                if Game.instance.rangeBet.contains(sector.number) {
                    let newBalance = (Game.instance.betValue * 2) + UserInfo.instance.userBalance
                    UserInfo.instance.updateBalance(newBalance: newBalance)
                    UserInfo.instance.getUserBalance()
                    UserInfo.instance.delegate?.updateInfo()
                } else {
                    let newBalance = UserInfo.instance.userBalance - Game.instance.betValue
                    UserInfo.instance.updateBalance(newBalance: newBalance)
                    UserInfo.instance.getUserBalance()
                    UserInfo.instance.delegate?.updateInfo()
                }
            case 25...36:
                if Game.instance.rangeBet.contains(sector.number) {
                    let newBalance = (Game.instance.betValue * 2) + UserInfo.instance.userBalance
                    UserInfo.instance.updateBalance(newBalance: newBalance)
                    UserInfo.instance.getUserBalance()
                    UserInfo.instance.delegate?.updateInfo()
                } else {
                    let newBalance = UserInfo.instance.userBalance - Game.instance.betValue
                    UserInfo.instance.updateBalance(newBalance: newBalance)
                    UserInfo.instance.getUserBalance()
                    UserInfo.instance.delegate?.updateInfo()
                }
            default:
                break
            }
        }
        return "Sector\n\(sector.number) \(sector.color.rawValue)"
    }
    
    var body: some View {
        VStack {
            Text(self.isAnimating ? "Spining\n..." : sectorFromAngle(angle : newAngle))
                .multilineTextAlignment(.center)
            Image("Arrow")
                .resizable()
                .scaledToFit()
                .frame(width: 15, height: 15, alignment: .center)
            Image("roulette")
                .resizable()
                .scaledToFit()
                .rotationEffect(Angle(degrees: spinDegrees))
                .frame(width: 180, height: 180, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .animation(spinAnimation)
            Button("PLAY") {
                if Game.instance.rangeBet == 0...0 && Game.instance.bet == -1 {
                    showingAlert = true
                } else {
                    isAnimating = true
                    rand = Double.random(in: 1...360)
                    spinDegrees += 720.0 + rand
                    newAngle = getAngle(angle: spinDegrees)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.9) {
                        isAnimating = false
                    }
                }
            }
            .alert("Choose Sector", isPresented: $showingAlert) {
                Button("OK", role: .cancel) { }
            }
            .padding(40)
            .disabled(isAnimating == true)
            .font(.custom("Avenir-Heavy", size: 25))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }

}
