//
//  TextFieldWithTitle.swift
//  3D Plotting
//
//  Created by Derek Rhea on 5/4/21.
//

import Foundation
import SwiftUI

struct CustomTitle: View {
    @State var placeholder = ""
    
    var body: some View {
        
        Text("\(placeholder)")
            .font(.system(size: 36, weight: .bold))
            .padding([.leading, .trailing], 12)
            .foregroundColor(Color.black)
        Text("DEREK RHEA • 2021")
            .font(.system(size: 10, weight: .light))
            .padding(.bottom, 12)
        
        
    }
}

struct TextFieldWithTitle: View {
    @State var placeholder = ""
    @Binding var value: Double
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("\(placeholder)")
                .font(.system(size: 12, weight: .light))
                .padding([.leading, .trailing], 12)
            
        
            TextField("", value: $value, formatter: formatter)
                .font(.system(size: 18, weight: .regular))
                .padding([.leading, .trailing], 12)
                .foregroundColor(Color.black)
                .cornerRadius(4)
        }
    }
}

// Text with non-editable Double text field
struct TextWithTitle: View {
    @State var placeholder = ""
    @Binding var value: Double
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("\(placeholder)")
                .font(.system(size: 12, weight: .light))
                .padding([.leading, .trailing], 12)
            
        
            TextField("", value: $value, formatter: formatter)
                .font(.system(size: 18, weight: .regular))
                .padding([.leading, .trailing], 12)
                .foregroundColor(Color.black)
                .cornerRadius(4)
                .disabled(true)
        }
    }
}

// Text with non-editable Int text field
struct IntTextWithTitle: View {
    @State var placeholder = ""
    @Binding var value: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("\(placeholder)")
                .font(.system(size: 12, weight: .light))
                .padding([.leading, .trailing], 12)
            
            TextField("", value: $value, formatter: NumberFormatter())
                .font(.system(size: 18, weight: .regular))
                .padding([.leading, .trailing], 12)
                .foregroundColor(Color.black)
                .cornerRadius(4)
//                .disabled(true)
        }
    }
}
