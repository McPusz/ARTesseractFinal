//
//  CubeNode.swift
//  ARTesseract
//
//  Created by Magdusz on 28.04.2018.
//  Copyright © 2018 com.McPusz.ARTesseract. All rights reserved.
//

import SceneKit

class CubeNode: SCNNode {
    
    private let edgeSize: CGFloat = 0.1
    
    override init() {
        super.init()
        let cubeGeometry = SCNBox(width: self.edgeSize, height: self.edgeSize, length: self.edgeSize, chamferRadius: 0)
        let boxMaterial = SCNMaterial()
        cubeGeometry.materials = [boxMaterial]
        cubeGeometry.materials.first?.diffuse.contents = Colors.randomColor
        let cubeNode = SCNNode(geometry: cubeGeometry)
        self.addChildNode(cubeNode)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
