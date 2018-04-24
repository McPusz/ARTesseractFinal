//
//  Localize+String.swift
//  ARTesseract
//
//  Created by Magdusz on 24.04.2018.
//  Copyright © 2018 com.McPusz.ARTesseract. All rights reserved.
//

import Foundation

extension String {
    public func localize() -> String {
        return NSLocalizedString(self, comment: "")
    }
}
