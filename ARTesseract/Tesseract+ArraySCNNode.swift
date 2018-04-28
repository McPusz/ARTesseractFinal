//
//  Tesseract+ArraySCNNode.swift
//  ARTesseract
//
//  Created by Magdusz on 28.04.2018.
//  Copyright © 2018 com.McPusz.ARTesseract. All rights reserved.
//

import SceneKit

extension Array where Element: SCNNode {
    
    public func isTesseract() -> Bool {
        guard self.count == 8 else { return false }
        return self.nodesAreInCorrectShape()
    }
    
    private func nodesAreInCorrectShape() -> Bool {
        let addedNodesPositions = self.compactMap { $0.position }
        for tesseractNodePosition in tesseractNodes() {
            if !addedNodesPositions.contains(tesseractNodePosition) {
                return false
            }
        }
        return true
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
        let sortedVerticallyNodes = self.sorted { $0.position.y < $1.position.y }
        return sortedVerticallyNodes[0]
    }
}
