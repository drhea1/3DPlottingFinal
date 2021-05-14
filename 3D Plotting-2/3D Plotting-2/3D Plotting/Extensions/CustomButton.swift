//
//  CustomButton.swift
//  3D Plotting
//
//  Created by Jason Yeoh on 5/4/21.
//

import SwiftUI

struct CustomButton: View {
    @State var placeholder: String = ""
    @State var action: () -> Void
    @Binding var isDone: Bool
    
    var body: some View {
        
        Button(action: {
            self.action()
        }, label: {
            Text("\(placeholder)")
                .font(.system(size: 24, weight: .light))
                .padding(.horizontal, 10)
                .foregroundColor(Color.black)
                .background(self.isDone ? Color.blue.opacity(0.4) : Color.white)
                .cornerRadius(4)
                .animation(.easeInOut(duration: 0.2))

        }).buttonStyle(PlainButtonStyle())
    }
}

