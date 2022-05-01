//
//  LoginView.swift
//  Impetus
//
//  Created by Harshal Kulkarni on 29/04/22.
//

import SwiftUI
import AlertToast
import LoadingButton

struct LoginView: View {
    @State var email = ""
    @State var password = ""
    @State var isLoading: Bool = false
    
    var style = LoadingButtonStyle(width: 200,
                                  height: 50,
                                  cornerRadius: 8,
                                  backgroundColor: .blue,
                                  loadingColor: Color.blue.opacity(0.5),
                                  strokeWidth: 5,
                                  strokeColor: .white)
    
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
                
                LoadingButton(action: {
                    guard !email.isEmpty, !password.isEmpty else {
                        DispatchQueue.main.async {
                            isLoading = false
                        }
                        return
                    }
                    
                    viewModel.signIn(email: email, password: password)
                }, isLoading: $isLoading, style: style) {
                    Text("Sign In")
                        .frame(width: 200, height: 50)
                        .background(Color.blue)
                        .cornerRadius(8)
                        .foregroundColor(Color.white)
                        .font(.system(size: 16, weight: .bold, design: .default))
                }
                .toast(isPresenting: $viewModel.wrongCredentialsToast){
                    AlertToast(type: .error(Color.black), title: "Try Again", subTitle: "Wrong Email/Password")
                }
                
                Spacer()
                    .frame(height: 100)
                
                LabelledDivider(label: "or")
                
                NavigationLink("Click here to Sign Up", destination: SignUpView())
                
            }
        }
        .navigationTitle("Sign In")
        .padding()
    }
}
