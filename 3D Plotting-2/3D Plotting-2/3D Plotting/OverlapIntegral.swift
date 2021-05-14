//
//  OverlapIntegral.swift
//  Overlap Integral Wavefunction
//
//  Created by Derek Rhea on 3/29/21.
//

import Foundation
import SwiftUI

class OverlapIntegral: NSObject, ObservableObject {
    
//    @Published var distanceBetweenParticles = 1.0
    @Published var box = BoundingBox()
    @Published var randomPoints: [Point] = []

    
    @Published var interatomicSpacingString = "1.0"
    @Published var interatomicSpacingDouble = 1.0
    
    @Published var functions = Wavefunctions()
    @Published var estimateIntegralDouble = 0.0
    @Published var estimateIntegralString = "0.0"
    @Published var analyticIntegralDouble = 0.0
    
    // Distance along x axis from x = 0 to particle
    @Published var leftAtomCenterDistance: Double = -0.5
    @Published var rightAtomCenterDistance: Double = 0.5
    
    @Published var numberOfPointsInt = 1
    @Published var numberOfPointsString = "1"
    
    
    @Published var negative2px: [Point] = []
    @Published var positive2px: [Point] = []
    

    func randomizePoints(numberOfPoints: Int) {
        
        randomPoints = []
        
        interatomicSpacingDouble = Double(interatomicSpacingString)!
        numberOfPointsInt = numberOfPoints
        
        
        for _ in 1...numberOfPoints {
            let newX = Double.random(in: box.xMin...box.xMax)
            let newY = Double.random(in: box.yMin...box.yMax)
            let newZ = Double.random(in: box.zMin...box.zMax)
            
            let point = Point(xPoint: newX, yPoint: newY, zPoint: newZ)
            
            randomPoints.append(point)
        }
    }
    
    /// Function to determine if each point is outside both, in one, the other, or both (1s only, currently)
    
    func plot1sOrbital(numberOfPoints: Int) {
        
        positive2px = []
        negative2px = []
        
        leftAtomCenterDistance = 0.0
        rightAtomCenterDistance = 0.0
        
        var sumOfProducts = 0.0
        
        for pt in randomPoints {
        
            let point = pt
            
            let pointSphericalLeft = functions.xyzToRThetaPhi(xFinal: point.xPoint, yFinal: point.yPoint, zFinal: point.zPoint, xInit: leftAtomCenterDistance, yInit: 0.0, zInit: 0.0)
            let psiStar = functions.psi1S(radius: pointSphericalLeft.0)
            
            let pointSphericalRight = functions.xyzToRThetaPhi(xFinal: point.xPoint, yFinal: point.yPoint, zFinal: point.zPoint, xInit: rightAtomCenterDistance, yInit: 0.0, zInit: 0.0)
            let psi = functions.psi1S(radius: pointSphericalRight.0)
            
            let product = psiStar * psi
            
            if (product > 0.002 ){
                    
                    positive2px.append(point)
                    print("red", psi, point, pointSphericalRight)
                }
            
            sumOfProducts += product
            
        }
        
        /// Calculate integral estimate
        estimateIntegralDouble = (box.volume * sumOfProducts) / Double(numberOfPoints)
        analyticIntegralDouble = functions.analytic_1s_1s(interatomicRadius: interatomicSpacingDouble)
        estimateIntegralString = String(estimateIntegralDouble)
        
        

    }
    
    
    func overlapIntegral_1S_1S(numberOfPoints: Int) {

        positive2px = []
        negative2px = []
        
        let distanceToZero = 0.5 * interatomicSpacingDouble
        
        leftAtomCenterDistance = -distanceToZero
        rightAtomCenterDistance = distanceToZero
        
        var sumOfProducts = 0.0
        
        for pt in randomPoints {
        
            let point = pt
            
            let pointSphericalLeft = functions.xyzToRThetaPhi(xFinal: point.xPoint, yFinal: point.yPoint, zFinal: point.zPoint, xInit: leftAtomCenterDistance, yInit: 0.0, zInit: 0.0)
            let psiStar = functions.psi1S(radius: pointSphericalLeft.0)
            
            let pointSphericalRight = functions.xyzToRThetaPhi(xFinal: point.xPoint, yFinal: point.yPoint, zFinal: point.zPoint, xInit: rightAtomCenterDistance, yInit: 0.0, zInit: 0.0)
            let psi = functions.psi1S(radius: pointSphericalRight.0)
            
            let product = psiStar * psi
            
            if (product > 0.002 ){
                    
                    positive2px.append(point)
                    print("red", psi, point, pointSphericalRight)
                }
            
            sumOfProducts += product
            
        }
        
        /// Calculate integral estimate
        estimateIntegralDouble = (box.volume * sumOfProducts) / Double(numberOfPoints)
        analyticIntegralDouble = functions.analytic_1s_1s(interatomicRadius: interatomicSpacingDouble)
        estimateIntegralString = String(estimateIntegralDouble)
        
        

    }
    
    
    func plot2pxOrbital(numberOfPoints: Int) {

        positive2px = []
        negative2px = []
        
        leftAtomCenterDistance = 0.0
        rightAtomCenterDistance = 0.0
        
        var sumOfProducts = 0.0
        
        for pt in randomPoints {
        
            let point = pt
            
            let pointSphericalRight = functions.xyzToRThetaPhi(xFinal: point.xPoint, yFinal: point.yPoint, zFinal: point.zPoint, xInit: rightAtomCenterDistance, yInit: 0.0, zInit: 0.0)
            let psi = functions.psi2PX(radius: pointSphericalRight.0, theta: pointSphericalRight.1, phi: pointSphericalRight.2)
            
            
            let product = psi * psi
            
            if psi < 0.0 {
                
                if (product > 0.002 ){
                    
                    negative2px.append(point)
                }
                
            }
            
            else
            {
                
                if (product > 0.002 ){
                    
                    positive2px.append(point)

                }
                
                
            }
            
            
            sumOfProducts += product
            
        }
        
        /// Calculate integral estimate
        estimateIntegralDouble = (box.volume * sumOfProducts) / Double(numberOfPoints)
        
        estimateIntegralString = String(estimateIntegralDouble)
    }
    
    func overlapIntegral_1S_2Px(numberOfPoints: Int) {
        
        positive2px = []
        negative2px = []
        
        let distanceToZero = 0.5 * interatomicSpacingDouble
        
        leftAtomCenterDistance = -distanceToZero
        rightAtomCenterDistance = distanceToZero
        
        var sumOfProducts = 0.0
        
        for pt in randomPoints {
        
            let point = pt
                        
            let pointSphericalLeft = functions.xyzToRThetaPhi(xFinal: point.xPoint, yFinal: point.yPoint, zFinal: point.zPoint, xInit: leftAtomCenterDistance, yInit: 0.0, zInit: 0.0)
            let psiStar = functions.psi1S(radius: pointSphericalLeft.0)
            
            let pointSphericalRight = functions.xyzToRThetaPhi(xFinal: point.xPoint, yFinal: point.yPoint, zFinal: point.zPoint, xInit: rightAtomCenterDistance, yInit: 0.0, zInit: 0.0)
            let psi = functions.psi2PX(radius: pointSphericalRight.0, theta: pointSphericalRight.1, phi: pointSphericalRight.2)
            
            
            let product = psiStar * psi
            
            if product < 0.0 {
                
                if (abs(product) > 0.002 ){
                    
                    negative2px.append(point)

                }
                
            }
            
            else
            {
                
                if (product > 0.002 ){
                    
                    positive2px.append(point)

                }
                
                
            }         
            
            sumOfProducts += product
            
        }
        
        /// Calculate integral estimate
        estimateIntegralDouble = (box.volume * sumOfProducts) / Double(numberOfPoints)
        
        estimateIntegralString = String(estimateIntegralDouble)
    }
    
    
    
    
    func in1S(electronLocation: Point, leftOrRight: String) -> Bool {
        var inOrbital = false
        
        var waveFunctionTest = 0.0
        
        
        var pointSpherical: (Double, Double, Double)
        
        
        switch leftOrRight {
        case "left":
            pointSpherical = functions.xyzToRThetaPhi(xFinal: electronLocation.xPoint, yFinal: electronLocation.yPoint, zFinal: electronLocation.zPoint, xInit: leftAtomCenterDistance, yInit: 0.0, zInit: 0.0)
            waveFunctionTest = functions.psi1S(radius: pointSpherical.0)
        default:
            pointSpherical = functions.xyzToRThetaPhi(xFinal: electronLocation.xPoint, yFinal: electronLocation.yPoint, zFinal: electronLocation.zPoint, xInit: rightAtomCenterDistance, yInit: 0.0, zInit: 0.0)
            waveFunctionTest = functions.psi1S(radius: pointSpherical.0)
            
        }
        
        if waveFunctionTest > 0.90 {
            inOrbital = true
            
        }


        return inOrbital
    }
    
    func in2px(electronLocation: Point, leftOrRight: String) -> Bool {
        
        var inOrbital = false
        
        var waveFunctionTest: Double
        var pointSpherical: (Double, Double, Double)
        
        switch leftOrRight {
        case "left":
            pointSpherical = functions.xyzToRThetaPhi(xFinal: electronLocation.xPoint, yFinal: electronLocation.yPoint, zFinal: electronLocation.zPoint, xInit: leftAtomCenterDistance, yInit: 0.0, zInit: 0.0)
            waveFunctionTest = functions.psi1S(radius: pointSpherical.0)
        default:
            pointSpherical = functions.xyzToRThetaPhi(xFinal: electronLocation.xPoint, yFinal: electronLocation.yPoint, zFinal: electronLocation.zPoint, xInit: rightAtomCenterDistance, yInit: 0.0, zInit: 0.0)
            waveFunctionTest = functions.psi2PX(radius: pointSpherical.0, theta: pointSpherical.1, phi: pointSpherical.2)
            
        }
        
        if waveFunctionTest > 0.90 {
            inOrbital = true
            
        }
        
        
        
        return inOrbital
    }
    
    
    
    
    
}
