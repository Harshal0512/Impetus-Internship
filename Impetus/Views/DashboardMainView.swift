//
//  DashboardMainView.swift
//  Impetus
//
//  Created by Harshal Kulkarni on 29/04/22.
//

import SwiftUI
import AlertToast

struct DashboardMainView: View {
    @EnvironmentObject var viewModel: AppViewModel
    
    @State var data = products
    
    var body: some View {
        ZStack{
            Color("Bg")
                .edgesIgnoringSafeArea(.all)
            
            VStack (alignment: .leading){
                
                HStack {
                    Spacer()
                    Button {
                        viewModel.logout()
                    } label: {
                        Label("Logout", systemImage: "x.square.fill")
                    }
                    .padding(.horizontal)
                    
                }
                .padding(.vertical, 15)
                
                AppBarView()
                    .padding(.bottom, 15)
                
                ListView_Products(data: $data)
                    .frame(height: 600)
                    .onAppear(){
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                            self.viewModel.authenticatedToast = false
                        }
                        
                    }
                    .toast(isPresenting: $viewModel.authenticatedToast){
                        AlertToast(type: .regular, title: "Login Successful", subTitle: "Welcome \(viewModel.auth.currentUser?.displayName ?? "Back!")")
                    }
                
                
            }
        }
    }
}
