//
//  CheckBoxView.swift
//  Impetus
//
//  Created by Harshal Kulkarni on 23/04/22.
//

import SwiftUI

struct CheckBoxView: View {
    @Binding var checked: Bool
    @Binding var trimVal: CGFloat
    @Binding var prodID: Int
    
    var animatableData: CGFloat {
        get {trimVal}
        set {trimVal = newValue}
    }
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 6)
                .trim(from: 0, to: trimVal)
                .stroke(style: StrokeStyle(lineWidth: 2))
                .frame(width: 25, height: 25)
                .foregroundColor(self.checked ? Color.blue : Color.gray)
            RoundedRectangle(cornerRadius: 6)
                .trim(from: 0, to: 1)
                .fill(self.checked ? Color.blue : Color.gray.opacity(0.2))
                .frame(width: 20, height: 20)
            if checked {
                Image(systemName: "checkmark")
                    .foregroundColor(Color.white)
            }
        }
    }
}
