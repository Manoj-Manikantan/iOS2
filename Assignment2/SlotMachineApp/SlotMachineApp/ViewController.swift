//  ViewController.swift
//  SlotMachineApp
//  Created by Manoj on 2021-01-27.
//  Copyright © 2021 Manoj. All rights reserved.

import UIKit
import SwiftConfettiView
import AVFoundation

class ViewController: UIViewController
{
    @IBOutlet weak var lblJackpot: UILabel!
    @IBOutlet weak var lblCreditsLeft: UILabel!
    @IBOutlet weak var lblCurrentBet: UILabel!
    @IBOutlet weak var imgSlot1: UIImageView!
    @IBOutlet weak var imgSlot2: UIImageView!
    @IBOutlet weak var imgSlot3: UIImageView!
    @IBOutlet weak var stprUserBet: UIStepper!
    @IBOutlet weak var lblUserSelectedBet: UILabel!
    @IBOutlet weak var lblResults: UILabel!
    
    var confettiView: SwiftConfettiView!
    
    var _apple = 0
    var _bananas = 0
    var _cherries = 0
    var _grapes = 0
    var _kiwi = 0
    var _oranges = 0
    var _lemon = 0
    var _strawberry = 0
    var _pear = 0
    
    var winnings = 0
    var playerBet = 0
    var playerMoney = 1000
    var stepperPrevValue = 0
    var audioPlayer: AVAudioPlayer?

    @IBAction func onQuitClick(_ sender: UIButton) {
        let alert = UIAlertController(title: "Quit App", message: "Are you sure you want to quit the app?", preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: {
            action in
            exit(0);
        }))
        alert.addAction(UIAlertAction(title: "No", style: UIAlertAction.Style.cancel, handler: {
            action in
            // Do nothing
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func onHelpClick(_ sender: UIButton) {
        self.alertMessage(title: "Help", message: "Rules to be displayed in the next assignment here.")
    }
    
    @IBAction func onResetClick(_ sender: UIButton) {
        initUI()
        resetCounters()
    }
    
    func initUI() {
        lblResults.isHidden = true
        lblCreditsLeft.text = "1000"
        lblCurrentBet.text = "0"
        lblUserSelectedBet.text = "0"
        stprUserBet.value = 0.0
        stprUserBet.maximumValue = 1000.0
        winnings = 0
        playerBet = 0
        playerMoney = 1000
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        initUI()
        self.confettiView = SwiftConfettiView(frame: self.view.bounds)
    }
    
    @IBAction func onButtonClick(_ sender: UIButton) {
        playerMoney = Int(lblCreditsLeft.text!)!
        playerBet = Int(lblUserSelectedBet.text!)!
        if playerMoney > 0 && playerMoney >= playerBet{
            if playerBet > 0 {
                lblCurrentBet.text = String(playerBet)
                let betLine = spinReels()
                changeSlotImages(betLine)
                determineWinnings()
                stprUserBet.maximumValue = Double(playerMoney)
                stprUserBet.value = 0.0
                lblUserSelectedBet.text = "0"
                if playerMoney <= 0 {
                    lblResults.isHidden = true
                    self.alertMessage(title: "Game over!", message: "Please click the reset button to start again.")
                }
            }
            else {
                self.alertMessage(title: "Input error", message: "Please place your bet to spin.")
            }
        }else{
            stprUserBet.value = Double(playerMoney)
            lblUserSelectedBet.text = String(playerMoney)
            self.alertMessage(title: "Zero credits left", message: "Please click the reset button to start again.")
        }
    }
    
    func changeSlotImages(_ betLine: [String] ) {
        imgSlot1.image = UIImage(named: betLine[0])
        imgSlot2.image = UIImage(named: betLine[1])
        imgSlot3.image = UIImage(named: betLine[2])
    }
    
    @IBAction func onStepperClicked(_ sender: UIStepper) {
        playerBet = Int(sender.value)
        
        if stepperPrevValue < playerBet {
            // On Increasing
            if playerMoney >= playerBet{
                lblUserSelectedBet.text = String(playerBet)
            }else{
                print("No money left to bet")
                stprUserBet.value = stprUserBet.value - Double(playerBet)
            }
        }else{
            // On Decreasing
            lblUserSelectedBet.text = String(playerBet)
        }
        stepperPrevValue = playerBet
    }
    
    func determineWinnings() {
        var isJackpot = false
        if (_grapes == 3) {
            winnings = playerBet * 10;
        } else if (_bananas == 3) {
            winnings = playerBet * 20;
        } else if (_oranges == 3) {
            winnings = playerBet * 30;
        } else if (_cherries == 3) {
            winnings = playerBet * 40;
        } else if (_pear == 3) {
            winnings = playerBet * 50;
        } else if (_kiwi == 3) {
            winnings = playerBet * 60;
        } else if (_lemon == 3) {
            winnings = playerBet * 75;
        } else if (_strawberry == 3) {
            winnings = playerBet * 100;
        } else if (_apple == 3) {
            winnings = playerBet * 150;
            isJackpot = true
        } else if (_grapes == 2) {
            winnings = playerBet * 2;
        } else if (_pear == 2) {
            winnings = playerBet * 2;
        } else if (_bananas == 2) {
            winnings = playerBet * 2;
        } else if (_oranges == 2) {
            winnings = playerBet * 3;
        } else if (_cherries == 2) {
            winnings = playerBet * 4;
        } else if (_kiwi == 2) {
            winnings = playerBet * 5;
        } else if (_lemon == 2) {
            winnings = playerBet * 10;
        } else if (_strawberry == 2) {
            winnings = playerBet * 20;
        } else if (_apple == 2) {
            winnings = playerBet * 25;
        } else if (_apple == 1) {
            winnings = playerBet * 5;
        } else {
            winnings = 0;
        }
        if winnings > 0 {
            playerMoney = playerMoney + winnings
            lblResults.textColor = UIColor(red: 1.0, green: 0.843, blue: 0.0, alpha: 1.0)
            lblResults.text = "That's a WIN!"
            lblResults.isHidden = false
            if isJackpot && !self.confettiView.isActive() {
                lblResults.text = "That's a Jackpot!"
                runJackpotView()
            }
        } else {
            playerMoney = playerMoney - playerBet
            lblResults.textColor = UIColor.white
            lblResults.text = "Not so lucky. Try again."
            lblResults.isHidden = false
        }
        lblCreditsLeft.text = "\(playerMoney)"
        resetCounters()
    }
    
    func runJackpotView() {
        self.view.addSubview(self.confettiView)
        self.confettiView.type = .confetti
        self.confettiView.startConfetti()
        Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { timer in
            self.initUI()
            self.resetCounters()
            self.confettiView.stopConfetti()
            self.confettiView.removeFromSuperview()
        }
    }
    
    func resetCounters() {
        _apple = 0
        _grapes = 0
        _bananas = 0
        _oranges = 0
        _cherries = 0
        _kiwi = 0
        _lemon = 0
        _strawberry = 0
        _pear = 0
        stprUserBet.maximumValue = Double(playerMoney)
    }
    
    func checkRange(_ value:Int,_ lowerBounds:Int,_ upperBounds:Int) -> Int {
        return (value >= lowerBounds && value <= upperBounds) ? value : -1
    }
    
    func spinReels() -> [String] {
        var betLine = [" ", " ", " "]
        var outCome = [0, 0, 0]
        
        for spin in 0..<3 {
            outCome[spin] = Int(floor(Double((Float.random(in: 0..<1) * 66) + 1)))
            switch outCome[spin] {
            case checkRange(outCome[spin],1,27):
                betLine[spin] = "Pear"
                _pear = _pear + 1
                break
            case checkRange(outCome[spin],28,37):
                betLine[spin] = "Grape"
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
                betLine[spin] = "Kiwi"
                _kiwi = _kiwi + 1
                break
            case checkRange(outCome[spin],63,64):
                betLine[spin] = "Lemon"
                _lemon = _lemon + 1
                break
            case checkRange(outCome[spin],65,66):
                betLine[spin] = "Strawberry"
                _strawberry = _strawberry + 1
                break
            case checkRange(outCome[spin],66,66):
                betLine[spin] = "Apple"
                _apple = _apple + 1
                break
            default:
                break
            }
        }
        return betLine
    }
    
    func alertMessage(title: String ,message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {
            action in
            //Do something
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
}

