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
    
    private var cubeNodes: [SCNNode] {
        return self.sceneView.scene.rootNode.childNodes.filter { $0 is CubeNode }
    }
    
    private var gameResult: GameResult {
        return self.gameIsWon() ? .won : .lost
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerForKeyboardNotifications()
        self.setupARScene()
        self.setupARSession()
    }
    
    deinit {
        self.removeKeyboardObservers()
    }
    
    @IBAction func showChallengeInfo(_ sender: UIButton) {
        self.infoVisible = !self.infoVisible
    }
    
    @IBAction func addNodeTapped(_ sender: UIButton) {
        self.addCube()
        self.checkWinningConditions()
        self.clearInput()
    }
    
    @IBAction func removeButtonTapped(_ sender: UIButton) {
        self.removeAllNodes()
        
    }
    
    
    private func checkWinningConditions() {
        if self.enoughCubesAdded() {
            self.presentAlertWith(gameResult: self.gameResult)
        }
    }
    
}

//MARK: Textfields
extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    private func getInputPosition() -> SCNVector3? {
        guard let xPosString = self.xTextField.text,
            let yPosString = self.yTextField.text,
            let zPosString = zTextField.text,
            let xPosFloat = Float(xPosString),
            let yPosFloat = Float(yPosString),
            let zPosFloat = Float(zPosString) else {
                print("Wrong input")
                return nil
        }
        return SCNVector3Make(xPosFloat, yPosFloat, zPosFloat)
    }
    
    private func clearInput() {
        [self.xTextField,
         self.yTextField,
         self.zTextField].forEach{ $0?.text = nil }
    }
}

//MARK: ARKit
extension ViewController {
    
    private func setupARScene() {
        self.sceneView.delegate = self
        self.sceneView.debugOptions = [ARSCNDebugOptions.showWorldOrigin, ARSCNDebugOptions.showFeaturePoints]
        self.sceneView.scene = SCNScene()
    }
    
    private func setupARSession() {
        let configuration = ARWorldTrackingConfiguration()
        self.sceneView.session.run(configuration)
    }
    
    private func addCube() {
        guard let inputPosition = self.getInputPosition() else { return }
        self.insertNodeAt(position: inputPosition)
    }
    
    private func insertNodeAt(position: SCNVector3) {
        let cubeNode = CubeNode()
        cubeNode.position = position
        self.sceneView.scene.rootNode.addChildNode(cubeNode)
    }
    
    private func removeAllNodes() {
        self.sceneView.scene.rootNode
            .childNodes.forEach { $0.removeFromParentNode() }
    }
    
    
}

// Game events
extension ViewController {
    private func enoughCubesAdded() -> Bool {
        return self.cubeNodes.count >= 8
    }
    
    private func tooMuchCubesAdded() -> Bool {
        return self.cubeNodes.count > 8
    }
    
    
    private func tesseractNodes() -> [SCNVector3] {
        return self.getVerticalTesseractShape() + self.getHorizontalTesseractShape()
    }
    
    private func getVerticalTesseractShape() -> [SCNVector3] {
        let topNode = self.getTopNode()
        let cubeSize = CubeNode.edgeSize
        var verticalCubesPositions = [SCNVector3]()
        
        for i in 0..<4 {
            let xPos = topNode.position.x
            let zPos = topNode.position.z
            let distanceFromTopBox = Float(i) * Float(cubeSize)
            let yPos = topNode.position.y + distanceFromTopBox
            
            let position = SCNVector3Make(xPos, yPos, zPos)
            verticalCubesPositions.append(position)
        }
        return verticalCubesPositions
    }
    
    private func getHorizontalTesseractShape() -> [SCNVector3] {
        let topNode = self.getTopNode()
        let cubeSize = CubeNode.edgeSize
        var horizontalCubesPositions = [SCNVector3]()
        
        let midNode = SCNNode()
        let midPosX = topNode.position.x
        let midPosY = topNode.position.y - Float(cubeSize)
        let midPosZ = topNode.position.z
        midNode.position = SCNVector3Make(midPosX, midPosY, midPosZ)
        
        for i in [-1, 1] {
        
            let zPosVaried = midPosZ + (Float(i) * Float(cubeSize))
            let xPosVaried = midPosX + (Float(i) * Float(cubeSize))
            
            let zNodePosition = SCNVector3Make(midPosX, midPosY, zPosVaried)
            let xNodePosition = SCNVector3Make(xPosVaried, midPosY, midPosZ)
            
            horizontalCubesPositions.append(contentsOf: [zNodePosition, xNodePosition])
        }
        
        return horizontalCubesPositions
    }
    
    private func getTopNode() -> SCNNode {
        let sortedVerticallyNodes = self.cubeNodes.sorted { $0.position.y < $1.position.y }
        return sortedVerticallyNodes[0]
    }
    
    private func nodesAreInCorrectShape() -> Bool {
        let addedNodesPositions = cubeNodes.compactMap { $0.position }
        for tesseractNodePosition in tesseractNodes() {
            if !addedNodesPositions.contains(tesseractNodePosition) {
                return false
            }
        }
        return true
    }
    
    private func gameIsWon() -> Bool {
        guard !tooMuchCubesAdded() else { return false }
        return self.nodesAreInCorrectShape()
    }
}

//extension Array where Element: SCNNode {
//    func isTesseract() -> Bool {
//        return true
//    }
//}
