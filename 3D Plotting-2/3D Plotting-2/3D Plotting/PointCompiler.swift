//
//  PointCompiler.swift
//  3DPlotting iOS
//
//  Created by Derek Rhea on 4/28/21.
//

import Foundation
import SwiftUI

class PointCompiler: NSObject, ObservableObject {
//    @Published var arrayOfPoints: [Point] = []
    @Published var numPoints: Int = 0
    @Published var box = BoundingBox()
    
    
    
//    func addPoint(x: Double, y: Double, z: Double) {
//        let newPt = Point(xPoint: x, yPoint: y, zPoint: z)
//        arrayOfPoints.append(newPt)
//        numPoints += 1
//    }
    
    
    func defineBox() {
        box.xMin = -5.0
        box.xMax = 5.0
        box.yMin = -5.0
        box.yMax = 5.0
        box.zMin = -5.0
        box.zMax = 5.0
    }
    
    func scalePoints(inputPoints: [Point]) -> [Point] {
//        defineBox()
        
        
        var newPoints: [Point] = []
        var maxFound = 0.0
        
        // Iterate over all points
        for pt in inputPoints {
            // Compare a point to overall max value
            if(pt.max() > maxFound) {
                maxFound = pt.max()
            }
        }
        
        let scaleFactor = 1.0 / maxFound

        for pt in inputPoints {
            
            var point = pt
            
            point.scale(scaleFactor: scaleFactor)
            newPoints.append(point)
        }
        
        let convertedPoints = convertPoints(inputPoints: newPoints)
        
        return convertedPoints
        
    }
    
    /// Function to convert points from the input axis to the SceneKit axis
    /// x -> z , y -> y, z -> -x
    func convertPoints(inputPoints: [Point]) -> [Point] {
        
        var plotReadyPoints: [Point] = []
        
        for pt in inputPoints {
            
            let newPoint = Point(xPoint: pt.zPoint, yPoint: pt.yPoint, zPoint: pt.xPoint)
            
            plotReadyPoints.append(newPoint)
            
        }
        
        return plotReadyPoints
    }
    
}
