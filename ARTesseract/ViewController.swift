//
//  ViewController.swift
//  ARTesseract
//
//  Created by Magdusz on 24.04.2018.
//  Copyright © 2018 com.McPusz.ARTesseract. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {
    
    @IBOutlet var sceneView: ARSCNView!
    // Stack view buttons
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var infoButton: UIButton!
    @IBOutlet weak var removeButton: UIButton!
    // Input View
    @IBOutlet weak var xTextField: UITextField!
    @IBOutlet weak var yTextField: UITextField!
    @IBOutlet weak var zTextField: UITextField!
    // Challenge info view
    @IBOutlet weak var infoView: UIView!
    
    //showing/hiding challengeView
    private var infoVisible: Bool = false {
        didSet {
            let buttonImage = infoVisible ? #imageLiteral(resourceName: "cancel_button") : #imageLiteral(resourceName: "bulb_icon")
            self.infoButton.setImage(buttonImage, for: .normal)
            self.infoView.isHidden = !infoVisible
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerForKeyboardNotifications()
    }
    
    deinit {
        self.removeKeyboardObservers()
    }
    
    @IBAction func showChallengeInfo(_ sender: UIButton) {
        self.infoVisible = !self.infoVisible
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}
