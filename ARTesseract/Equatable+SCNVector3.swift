//
//  Equatable+SCNVector3.swift
//  ARTesseract
//
//  Created by Magdusz on 28.04.2018.
//  Copyright © 2018 com.McPusz.ARTesseract. All rights reserved.
//

import SceneKit

extension SCNVector3: Equatable {
    public static func ==(lhs: SCNVector3, rhs: SCNVector3) -> Bool {
        return (lhs.x == rhs.x) && (lhs.y == rhs.y) && (lhs.z == rhs.z)
    }
}
