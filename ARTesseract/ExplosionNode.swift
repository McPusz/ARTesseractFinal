//
//  ExplosionNode.swift
//  ARTesseract
//
//  Created by Magdusz on 08.05.2018.
//  Copyright © 2018 com.McPusz.ARTesseract. All rights reserved.
//

import Foundation
import SceneKit

class ExplosionNode: SCNNode {
    
    static let nodeName = "ExplosionNode"
    private let particleSystem = SCNParticleSystem(named: "Explosion.scnp", inDirectory: nil)
    
    init(at position: SCNVector3) {
        super.init()
        
        self.position = position
        if let particles = self.particleSystem {
            self.addParticleSystem(particles)
        }
        self.name = ExplosionNode.nodeName
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
