//
//  SignUpView.swift
//  Impetus
//
//  Created by Harshal Kulkarni on 29/04/22.
//

import SwiftUI
import AlertToast

struct SignUpView: View {
    @State var email = ""
    @State var password = ""
    @State private var alertWrongInfo = false
    
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Email Address", text: $email)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .padding(15)
                    .background(Color(.secondarySystemBackground))
                    .padding(.bottom, 5)
                
                SecureField("Password", text: $password)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .padding(15)
                    .background(Color(.secondarySystemBackground))
                    .padding(.bottom, 15)
                
                Button(action: {
                    guard !email.isEmpty, !password.isEmpty else {
                        alertWrongInfo = true
                        return
                    }
                    
                    viewModel.signUp(email: email, password: password)
                    
                }, label: { Text("Sign Up")
                        .frame(width: 200, height: 50)
                        .background(Color.green)
                        .cornerRadius(8)
                        .foregroundColor(Color.white)
                        .font(.system(size: 16, weight: .bold, design: .default))
                })
                .toast(isPresenting: $alertWrongInfo){
                    AlertToast(type: .error(Color.black), title: "Incomplete", subTitle: "Please fill all Fields")
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        alertWrongInfo = false
                    }
                }
                
                Spacer()
                    .frame(height: 100)
            }
        }
        .navigationTitle("Sign Up")
        .padding()
    }
}
