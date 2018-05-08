//
//  EndGameAlert+UIViewController.swift
//  ARTesseract
//
//  Created by Magdusz on 24.04.2018.
//  Copyright © 2018 com.McPusz.ARTesseract. All rights reserved.
//

import UIKit

extension UIViewController {
    func presentAlertWith(gameResult: GameResult) {
        guard self.presentedViewController == nil else { return }
        guard let endGameAlert = UIStoryboard(name: "EndGameAlertStoryboard", bundle: nil).instantiateInitialViewController() as? EndGameAlertViewController else { return }
        endGameAlert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        self.present(endGameAlert, animated: true, completion: nil)
        endGameAlert.setState(state: gameResult)
    }
}
