//
//  SignUpView.swift
//  Impetus
//
//  Created by Harshal Kulkarni on 29/04/22.
//

import SwiftUI
import AlertToast
import LoadingButton

struct SignUpView: View {
    @State var email = ""
    @State var password = ""
    @State private var alertWrongInfo = false
    @State var isLoading: Bool = false
    
    var style = LoadingButtonStyle(width: 200,
                                  height: 50,
                                  cornerRadius: 8,
                                  backgroundColor: .green,
                                  loadingColor: Color.green.opacity(0.5),
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
                    guard !email.isEmpty, !password.isEmpty, isValidEmail(email) else {
                        DispatchQueue.main.async {
                            alertWrongInfo = true
                            isLoading = false
                        }
                        return
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
                        alertWrongInfo = true
                        isLoading = false
                        return
                    }
                    
                    viewModel.signUp(email: email, password: password) {
                        (isSuccess) in
                        if !isSuccess {
                            DispatchQueue.main.async {
                                isLoading = false
                            }
                        }
                    }
                    
                }, isLoading: $isLoading, style: style) {
                    Text("Sign Up")
                        .frame(width: 200, height: 50)
                        .background(Color.green)
                        .cornerRadius(8)
                        .foregroundColor(Color.white)
                        .font(.system(size: 16, weight: .bold, design: .default))
                }
                .toast(isPresenting: $alertWrongInfo){
                    AlertToast(type: .error(Color.black), title: "Invalid", subTitle: "Fill all Details Correctly")
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        alertWrongInfo = false
                        isLoading = false
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
