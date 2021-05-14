//
//  SideMenu.swift
//  JobHub
//
//  Created by Derek Rhea on 5/14/21.
//

import SwiftUI

struct CustomPicker: View {
    @State var placeholder = ""
    @Binding var selected: Int
    var options: [String]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("\(placeholder)")
                .font(.system(size: 12, weight: .light))
                .padding([.leading, .trailing], 12)
            
            HStack {
                Spacer()
                ForEach(options.indices) { i in
                    Button(action: {
                        withAnimation {
                            self.selected = i
                        }

                    }, label: {
                        Text(options[i])
                            .font(.system(size: 14, weight: .light))
                            .padding(.horizontal, 10)
                            .foregroundColor(Color.black)
                            .background(self.selected == i ? Color.blue.opacity(0.4) : Color.white)
                            .cornerRadius(4)
                            .animation(.easeInOut(duration: 0.2))
                        
                    }).buttonStyle(PlainButtonStyle())

                    if i < options.count - 1 {
                        Divider()
                            .frame(width: nil, height: 25, alignment: .center)
                            .opacity(0.7)
                    }
                }
                Spacer()
            }
        }
    }
}
