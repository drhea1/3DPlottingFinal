//
//  ContentView.swift
//  3D Plotting
//
//  Created by Derek Rhea on 5/4/21.
//

import SwiftUI
import SceneKit

struct PlotView: View {
    let scene: SCNScene = SCNScene(named: "plot-landscape.scn")!
    var cameraNode: SCNNode? {
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(x: -1.5, y: 1.5, z: 1.5)
        cameraNode.eulerAngles = SCNVector3(x: (-30.0 * CGFloat.pi/180.0), y: (-45.0 * CGFloat.pi/180.0), z: 0.0)
        scene.rootNode.addChildNode(cameraNode)
        return cameraNode
    }
    
    
    
    
    @ObservedObject var pointCompiler: PointCompiler
    @ObservedObject var overlapIntegral: OverlapIntegral
    
    @State var radius: Double = 0.2
    @State var numPoints: Int = 15765
    @State var estIntegral: Double = 0.0
    @State var actIntegral: Double = 0.0
    @State var percentWithin: Double = 0.90
    
    @State var integralSelection: Int = 0
    @State var willCalculate: Bool = false
    

    private let integralOptions = ["1S Orbital", "2px Orbital", "1S-1S Integral", "1S-2px Integral"]
    
    var body: some View {
        GeometryReader { geometry in
            HStack {
                VStack {
                    CustomTitle(placeholder: "3D Plotting")
                    TextFieldWithTitle(placeholder: "Radius", value: $radius)
                    IntTextWithTitle(placeholder: "Number of Points", value: $numPoints)
                    TextWithTitle(placeholder: "Estimate Integral", value: $estIntegral)
                    TextWithTitle(placeholder: "Actual Integral", value: $actIntegral)
                    CustomPicker(placeholder: "Select Integral",
                                 selected: $integralSelection,
                                 options: integralOptions)
                    
                    Spacer()

                    CustomButton(placeholder: "Calculate",
                                 action: {calculate()},
                                 isDone: $willCalculate)
                        .padding(.bottom, 15)
                }
                

                
                SceneView( scene: scene,
                           pointOfView: cameraNode,
                           options: [.allowsCameraControl, .autoenablesDefaultLighting, .temporalAntialiasingEnabled]
                )
                .frame(width: geometry.size.width * (2/3))
            }
            .padding(.all, 5)
            .onAppear {
                // Load all points after initializing the plot view
//                scene.background.contents = nil
//                addPointToScene(points: pointCompiler.arrayOfPoints, radius: $radius)
            }
        }
        
    }

    
    func calculate() {
        
        
        
        print("numPoints = " + String(numPoints))
        print("radius = " + String(radius))
        print("integralSelection = " + String(integralSelection))
        
        overlapIntegral.randomizePoints(numberOfPoints: numPoints)
        
        overlapIntegral.interatomicSpacingDouble = radius
        
        scene.rootNode.enumerateChildNodes { (node, stop) in
            if node.geometry?.className == "SCNSphere" {
                node.removeFromParentNode()
            }
        }
        
        var pointsInLeft: [Point] = []
        var pointsInRight: [Point] = []

        
        
        ///Resizes and orients points to SCNView appropriate metrics
        pointCompiler.defineBox()
        
        switch integralSelection {
        case 0:
            overlapIntegral.plot1sOrbital(numberOfPoints: overlapIntegral.numberOfPointsInt)
            pointsInRight = pointCompiler.scalePoints(inputPoints: overlapIntegral.positive2px)
            radius = 0.0
        case 1:
            overlapIntegral.plot2pxOrbital(numberOfPoints: overlapIntegral.numberOfPointsInt)
            pointsInLeft = pointCompiler.scalePoints(inputPoints: overlapIntegral.negative2px)
            pointsInRight = pointCompiler.scalePoints(inputPoints: overlapIntegral.positive2px)
            radius = 0.0
        case 2:
            overlapIntegral.overlapIntegral_1S_1S(numberOfPoints: overlapIntegral.numberOfPointsInt)
            pointsInRight = pointCompiler.scalePoints(inputPoints: overlapIntegral.positive2px)
        case 3:
            overlapIntegral.overlapIntegral_1S_2Px(numberOfPoints: overlapIntegral.numberOfPointsInt)
            pointsInLeft = pointCompiler.scalePoints(inputPoints: overlapIntegral.negative2px)
            pointsInRight = pointCompiler.scalePoints(inputPoints: overlapIntegral.positive2px)
        default:
            print("Error - case must be 0 or 1")
        }
        
        /// Saves estimated and actual integral to UI
        estIntegral = overlapIntegral.estimateIntegralDouble
        
        if integralSelection == 2 || integralSelection == 0 {
            
            actIntegral = overlapIntegral.analyticIntegralDouble
            
        } else {
            actIntegral = 0.0
        }
        

        

        

        
        ///Plots points from chosen overlap
        addPointToScene(points: pointsInLeft, color: .blue)
        addPointToScene(points: pointsInRight, color: .red)
//        addPointToScene(points: pointsInOverlap, color: .green)
        
    }
    
    // Takes an array of points and adds it to scene
    func addPointToScene(points: [Point], color: NSColor) {
        
        // Populate the scene with 3D points
        for i in 0..<points.count {
            let object = SCNNode(geometry: SCNSphere(radius: 0.05))
            object.position = SCNVector3(x: CGFloat(points[i].xPoint),
                                         y: CGFloat(points[i].yPoint),
                                         z: CGFloat(points[i].zPoint))
            
            object.geometry?.firstMaterial?.diffuse.contents = color
            self.scene.rootNode.addChildNode(object)
        }
    }
    
}

struct PlotView_Previews: PreviewProvider {
    static var previews: some View {
        PlotView(pointCompiler: PointCompiler(), overlapIntegral: OverlapIntegral())
    }
}
