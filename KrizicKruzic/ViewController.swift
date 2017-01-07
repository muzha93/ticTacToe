//
//  ViewController.swift
//  KrizicKruzic
//
//  Created by luka on 04/01/2017.
//  Copyright © 2017 luka. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    


    @IBOutlet var gameTiles: [UIButton]!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var restartButton: UIButton!
    @IBOutlet weak var playerXWinsLabel: UILabel!
    @IBOutlet weak var playerOWinsLabel: UILabel!
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    var game = Game()
    
    override func viewDidLoad() {
        updateStatusLabel()
    }
    func updateStatusLabel () {
        self.statusLabel.text = "Igrač \(game.currentPlayer) na potezu"
    }
    @IBAction func resetCounterTouched(_ sender: UIButton) {
        self.playerOWinsLabel.text = "0"
        self.playerXWinsLabel.text = "0"
    }
    
    @IBAction func titleButtonTapped(_ sender: UIButton) {
        let tag = sender.tag
        let row = tag / 10 - 1
        let col = tag % 10 - 1
        if game.currentPlayer == Player.O {
            let image = UIImage(named: "o.png")
            sender.setBackgroundImage(image, for: .normal)
            sender.isEnabled = false
        }else {
            let image = UIImage(named: "x.jpg")
            sender.setBackgroundImage(image, for: .normal)
            sender.isEnabled = false
        }
        game.nextMove(row: row, col: col)
        updateStatusLabel()
        gameFinished()
    }
    
    @IBAction func restartButtonTouched(_ sender: UIButton) {
        for tile in gameTiles {
            tile.isEnabled = true
            tile.setBackgroundImage(nil, for: .normal)
        }
        game.gameRestart()
        self.restartButton.setTitle("Reset", for: .normal)
        updateStatusLabel()

    }
    
    func gameFinished () {
        if let result = game.result {
            switch result { 
            case .tie:
                self.statusLabel.text = "Izjednačeno je"
            default:
                self.statusLabel.text = "Pobijedio je igrač \(game.currentPlayer)"
                switch game.currentPlayer {
                case .X:
                    self.playerXWinsLabel.text = String(Int(self.playerXWinsLabel.text!)!+1)
                case .O:
                    self.playerOWinsLabel.text = String(Int(self.playerOWinsLabel.text!)!+1)
                }
            }
            self.restartButton.setTitle("Nova igra", for: .normal)
        }
    }
    
}

