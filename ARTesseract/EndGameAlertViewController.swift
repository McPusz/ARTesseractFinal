//
//  EndGameAlertViewController.swift
//  ARTesseract
//
//  Created by Magdusz on 24.04.2018.
//  Copyright © 2018 com.McPusz.ARTesseract. All rights reserved.
//

import UIKit

enum GameResult {
    case won
    case lost
}

class EndGameAlertViewController: UIViewController {
    
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var midLabel: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!
    
    private var gameState: GameResult = .lost {
        didSet {
            let gameWon = gameState == .won
            self.topLabel.text =  gameWon ? "gameWonTopText".localize() : "gameLostTopText".localize()
            self.midLabel.text = gameWon ? "gameWonMidText".localize() : "gameLostMidText".localize()
            self.bottomLabel.text = "gameResultBottomText".localize()
        }
    }
    
    @IBAction func closeButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setState(state: GameResult) {
        self.gameState = state
    }
}
