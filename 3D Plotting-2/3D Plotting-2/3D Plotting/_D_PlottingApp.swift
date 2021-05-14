//
//  _D_PlottingApp.swift
//  3D Plotting
//
//  Created by Derek Rhea on 5/4/21.
//

import SwiftUI

@main
struct _D_PlottingApp: App {
    var body: some Scene {
        WindowGroup {
            PlotView(pointCompiler: PointCompiler(), overlapIntegral: OverlapIntegral())
                .preferredColorScheme(.light)
        }
    }
}
