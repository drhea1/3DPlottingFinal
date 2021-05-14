//
//  BoundingBox.swift
//  Overlap Integral Wavefunction
//
//  Created by Derek Rhea on 3/29/21.
//

import Foundation
import SwiftUI

class BoundingBox: NSObject, ObservableObject {
    @Published var xMin = -5.0
    @Published var xMax = 5.0
    @Published var yMin = -5.0
    @Published var yMax = 5.0
    @Published var zMin = -5.0
    @Published var zMax = 5.0
    @Published var volume = 1000.0
    @Published var surfaceArea = 600.0
    
    func areaAndVolume(dimensions: Int) {
        switch dimensions {
        case 2:
            zMin = 0.0
            zMax = 0.0
            surfaceArea = (xMax-xMin)*(yMax-yMin)
            volume = 0.0
        case 3:
            surfaceArea = 2.0*(xMax-xMin)+2.0*(yMax-yMin)+2.0*(zMax-zMin)
            volume = (xMax-xMin)*(yMax-yMin)*(zMax-zMin)
        default:
            print("Error: Dimension must be 2 or 3")
        }
    }
    
}
