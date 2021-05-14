//
//  Wavefunctions.swift
//  Overlap Integral Wavefunction
//
//  Created by Derek Rhea on 3/29/21.
//

import Foundation
import SwiftUI

// Fix the radius! The radius 

class Wavefunctions: NSObject, ObservableObject {
    
    ///Bohr radius is in angstroms
    @Published var bohrRadius = 0.529177210903
    @Published var rad = 1.0
    
    func radius(xFinal: Double, yFinal: Double, zFinal: Double, xInit: Double, yInit: Double, zInit: Double) -> Double {
        
        return sqrt(Double(pow(xFinal-xInit,2)) + Double(pow(yFinal-yInit,2)) + Double(pow(zFinal-zInit,2)))
        
    }
    
    ///Function to convert x, y, z points to r, theta, phi points
    
    func xyzToRThetaPhi(xFinal: Double, yFinal: Double, zFinal: Double, xInit: Double, yInit: Double, zInit: Double) -> (Double, Double, Double) {
        
        let radius = radius(xFinal: xFinal, yFinal: yFinal, zFinal: zFinal, xInit: xInit, yInit: yInit, zInit: zInit)
        
        let x = xFinal - xInit
        let y = yFinal - yInit
        let z = zFinal - zInit
        
        let phiNumerator = sqrt(Double(pow(x,2))+Double(pow(y,2)))
        
        let phi = atan2(y,x)
        let theta = atan2(phiNumerator,z)
        
        return (radius, theta, phi)
        
        
    }

    
//      1              - r / a0
//  ----------------- e
//    ____   3 / 2
//  |/ pi  a0

    
    func psi1S(radius: Double) -> Double {
        	
//        let radius = self.radius(xFinal: xElectron, yFinal: yElectron, zFinal: zElectron, xInit: xCenter, yInit: yCenter, zInit: zCenter)
        
        return (1.0/(sqrt(Double.pi)*Double(pow(bohrRadius,3.0/2.0))))*exp(-radius/bohrRadius)
        
    }
    
//            1                       r    - r / 2a0
//   ----------------------------- * -- * e          * sin(theta) * cos(phi)
//            __________   3 / 2     a0
//      4.0 |/ 2.0 * pi  a0


    func psi2PX(radius: Double, theta: Double, phi: Double) -> Double {
        
      
        return (1.0/(4.0*sqrt(2.0*Double.pi)*Double(pow(bohrRadius,3.0/2.0))))*(radius/bohrRadius)*exp(-radius/(2.0*bohrRadius))*sin(theta)*cos(phi)
    }
    
    
    
    
    func analytic_1s_1s(interatomicRadius: Double) -> Double {
        
        let exponent = exp(-interatomicRadius/bohrRadius)
        
        let diviser = interatomicRadius/bohrRadius
        
        let numerator = Double(pow(interatomicRadius, 2))
        
        let denominator = 3.0*Double(pow(bohrRadius,2))
        
        return exponent*(1.0 + diviser + ((numerator)/(denominator)))
    }
    
    
    
    
    
}
