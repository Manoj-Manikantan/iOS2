//
//  ViewController.swift
//  SlotMachineApp
//
//  Created by Manoj on 2021-01-27.
//  Copyright © 2021 Manoj. All rights reserved.


import UIKit

class ViewController: UIViewController
{
    @IBOutlet weak var lblJackpot: UILabel!
    @IBOutlet weak var lblCreditsLeft: UILabel!
    @IBOutlet weak var lblCurrentBet: UILabel!
    @IBOutlet weak var imgSlot1: UIImageView!
    @IBOutlet weak var imgSlot2: UIImageView!
    @IBOutlet weak var imgSlot3: UIImageView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    var _grapes = 0
    var _bananas = 0
    var _oranges = 0
    var _cherries = 0
    var _bars = 0
    var _bells = 0
    var _sevens = 0
    var _blanks = 0
    var winnings = 0
    var playerBet = 10
    var playerMoney = 1000
    
    @IBAction func onButtonClick(_ sender: UIButton) {
        let betLine = spinReels()
        print(betLine)
        determineWinnings()
    }
    
    func determineWinnings() {
        if (_blanks == 0) {
            if (_grapes == 3) {
                winnings = playerBet * 10;
            }
            else if (_bananas == 3) {
                winnings = playerBet * 20;
            }
            else if (_oranges == 3) {
                winnings = playerBet * 30;
            }
            else if (_cherries == 3) {
                winnings = playerBet * 40;
            }
            else if (_bars == 3) {
                winnings = playerBet * 50;
            }
            else if (_bells == 3) {
                winnings = playerBet * 75;
            }
            else if (_sevens == 3) {
                winnings = playerBet * 100;
            }
            else if (_grapes == 2) {
                winnings = playerBet * 2;
            }
            else if (_bananas == 2) {
                winnings = playerBet * 2;
            }
            else if (_oranges == 2) {
                winnings = playerBet * 3;
            }
            else if (_cherries == 2) {
                winnings = playerBet * 4;
            }
            else if (_bars == 2) {
                winnings = playerBet * 5;
            }
            else if (_bells == 2) {
                winnings = playerBet * 10;
            }
            else if (_sevens == 2) {
                winnings = playerBet * 20;
            }
            else if (_sevens == 1) {
                winnings = playerBet * 5;
            }
            else {
                winnings = playerBet * 1;
            }
            playerMoney = playerMoney + winnings
            lblResult.text = "Win!"
            print("Win!")
        }
        else {
            playerMoney = playerMoney - playerBet
            lblResult.text = "Loss!"
            print("Loss!")
        }
        lblCredits.text = "Credits: $\(playerMoney)"
        print("Credits: $\(playerMoney)")
        resetCounters()
    }
    
    func resetCounters() {
        _grapes = 0
        _bananas = 0
        _oranges = 0
        _cherries = 0
        _bars = 0
        _bells = 0
        _sevens = 0
        _blanks = 0
    }
    
    func checkRange(_ value:Int,_ lowerBounds:Int,_ upperBounds:Int) -> Int {
        return (value >= lowerBounds && value <= upperBounds) ? value : -1
    }
    
    func spinReels() -> [String] {
        var betLine = [" ", " ", " "]
        var outCome = [0, 0, 0]
        
        for spin in 0..<3 {
            outCome[spin] = Int(floor(Double((Float.random(in: 0..<1) * 65) + 1)))
            switch outCome[spin] {
            case checkRange(outCome[spin],1,27):
                betLine[spin] = "Blank"
                _blanks = _blanks + 1
                break
            case checkRange(outCome[spin],28,37):
                betLine[spin] = "Grapes"
                _grapes = _grapes + 1
                break
            case checkRange(outCome[spin],38,46):
                betLine[spin] = "Banana"
                _bananas = _bananas + 1
                break
            case checkRange(outCome[spin],47,54):
                betLine[spin] = "Orange"
                _oranges = _oranges + 1
                break
            case checkRange(outCome[spin],55,59):
                betLine[spin] = "Cherry"
                _cherries = _cherries + 1
                break
            case checkRange(outCome[spin],60,62):
                betLine[spin] = "Bar"
                _bars = _bars + 1
                break
            case checkRange(outCome[spin],63,64):
                betLine[spin] = "Bell"
                _bells = _bells + 1
                break
            case checkRange(outCome[spin],65,65):
                betLine[spin] = "Seven"
                _sevens = _sevens + 1
                break
            default:
                break
            }
        }
        return betLine
    }
    
}

