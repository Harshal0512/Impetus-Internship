//
//  AppBarView.swift
//  Impetus
//
//  Created by Harshal Kulkarni on 29/04/22.
//

import SwiftUI

struct AppBarView: View {
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        HStack{
            TagLineView()
                .padding(.leading)
                .padding(.bottom)
                .frame(width: 250, height: 100)
            
            Spacer()
            
            Button(action: {}) {
                Image(uiImage: #imageLiteral(resourceName: "Profile.png"))
                    .resizable()
                    .frame(width: 42, height: 42)
                    .cornerRadius(10.0)
            }
        }
        .padding(.trailing)
    }
}
