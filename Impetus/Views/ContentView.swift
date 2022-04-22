//
//  ContentView.swift
//  Impetus
//
//  Created by Harshal Kulkarni on 21/04/22.
//

import SwiftUI
import FirebaseAuth
import AlertToast


class AppViewModel: ObservableObject {
    
    let auth = Auth.auth()
    
    @Published var signedIn = false
    @Published var wrongCredentialsToast = false
    @Published var authenticatedToast = false
    
    var isSignedIn: Bool {
        return auth.currentUser != nil
    }
    
    func signIn(email: String, password: String) {
        auth.signIn(withEmail: email, password: password) { [weak self] result, error in
            guard result != nil, error == nil else {
                self?.wrongCredentialsToast.toggle()
                return
            }
            
            //success
            self?.authenticatedToast = true
            DispatchQueue.main.async {
                self?.signedIn = true
            }
        }
    }
    
    
    func signUp(email: String, password: String) {
        auth.createUser(withEmail: email, password: password) { [weak self] result, error in
            guard result != nil, error == nil else {
                return
            }
            
            //success
            DispatchQueue.main.async {
                self?.signedIn = true
                self?.authenticatedToast = true
            }
        }
    }
    
    func logout() {
        do {
            try auth.signOut()
            
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
            return
        }
        
        DispatchQueue.main.async {
            self.signedIn = false
            self.authenticatedToast = false
        }
    }
    
}


struct ContentView: View {
    
    //    @State var products = [Product]()
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        NavigationView{
            if viewModel.signedIn {
                DashboardMainView()
                    .navigationBarHidden(true)
            } else {
                LoginView()
            }
        }
        .onAppear{
            viewModel.signedIn = viewModel.isSignedIn
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct AppBarView: View {
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        HStack{
            Button(action: {
                viewModel.logout()
            }) {
                Image("menu")
                    .padding()
                    .background(Color(.white))
                    .cornerRadius(10.0)
            }
            Spacer()
            
            Button(action: {}) {
                Image(uiImage: #imageLiteral(resourceName: "Profile.png"))
                    .resizable()
                    .frame(width: 42, height: 42)
                    .cornerRadius(10.0)
            }
        }
        .padding(.horizontal)
    }
}

struct TagLineView: View {
    var body: some View {
        Text("Best Products \nUnder ")
            .font(.custom("PlayfairDisplay-Regular", size: 28))
            .foregroundColor(Color("Primary"))
        + Text("One Roof!")
            .font(.custom("PlayfairDisplay-Bold", size: 28))
            .foregroundColor(Color("Primary"))
    }
}

struct SearchView: View {
    @State private var search: String = ""
    var body: some View {
        HStack {
            HStack {
                Image("Search")
                    .padding(.trailing, 8)
                TextField("Search for Products", text: $search)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10.0)
            .padding(.horizontal)
        }
    }
}

struct ThreeButtonView: View {
    var body: some View {
        HStack(spacing: 0.0) {
            Button(action: {}) {
                VStack {
                    Image("Edit_icon")
                        .resizable()
                        .frame(width: 30, height: 30)
                    
                    Text("Edit Records")
                        .font(.custom("PlayFairDisplay-Regular", size: 15))
                        .foregroundColor(Color("Primary"))
                }
                .frame(width: 110, height: 70)
                .background(Color(.white))
                .cornerRadius(15)
            }
            .frame(width: 110, height: 50)
            
            Spacer()
            
            Button(action: {}) {
                VStack {
                    Image("Edit_icon")
                        .resizable()
                        .frame(width: 30, height: 30)
                    
                    Text("Edit Records")
                        .font(.custom("PlayFairDisplay-Regular", size: 15))
                        .foregroundColor(Color("Primary"))
                }
                .frame(width: 110, height: 70)
                .background(Color(.white))
                .cornerRadius(15)
            }
            .frame(width: 110, height: 50)
            
            Spacer()
            
            Button(action: {}) {
                VStack {
                    Image("Edit_icon")
                        .resizable()
                        .frame(width: 30, height: 30)
                    
                    Text("Edit Records")
                        .font(.custom("PlayFairDisplay-Regular", size: 15))
                        .foregroundColor(Color("Primary"))
                }
                .frame(width: 110, height: 70)
                .background(Color(.white))
                .cornerRadius(15)
            }
            .frame(width: 110.0, height: 50)
            
        }
        .padding()
        .frame(alignment: .center)
    }
}


extension View {
    func Print(_ vars: Any...) -> some View {
        for v in vars { print(v) }
        return EmptyView()
    }
}

struct ListView_Products: View {
    var body: some View {
        NavigationView {
            List(products) { product in
                NavigationLink {
                    ProductDetail(product: product)
                } label: {
                    ProductRow(product: product)
                }
            }
            //            .ignoresSafeArea()
            //            .onAppear(perform: {
            //                UITableView.appearance().contentInset.top = -35})
            //            .navigationTitle("All Products")
            .navigationBarHidden(true)
        }
    }
}


struct DashboardMainView: View {
    
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
        ZStack{
            Color("Bg")
                .edgesIgnoringSafeArea(.all)

            VStack (alignment: .leading){
                AppBarView()
                
                TagLineView()
                    .padding(.leading)
                
                ListView_Products()
//                    .onAppear(){
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
//                            self.viewModel.authenticatedToast = false
//                        }
//
//                    }
//                    .toast(isPresenting: $viewModel.authenticatedToast){
//                        AlertToast(type: .regular, title: "Login Successful", subTitle: "Welcome \(viewModel.auth.currentUser?.displayName ?? "Back!")")
//                    }
            }
        }
    }
}


struct LoginView: View {
    @State var email = ""
    @State var password = ""
    @State private var alertWrongCredentials = false
    
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
                        return
                    }
                    
                    viewModel.signIn(email: email, password: password)
                }, label: { Text("Sign In")
                        .frame(width: 200, height: 50)
                        .background(Color.blue)
                        .cornerRadius(8)
                        .foregroundColor(Color.white)
                        .font(.system(size: 16, weight: .bold, design: .default))
                })
                .toast(isPresenting: $viewModel.wrongCredentialsToast){
                    AlertToast(type: .error(Color.black), title: "Try Again", subTitle: "Wrong Email/Password")
                }
                
                
                Spacer()
                    .frame(height: 100)
            }
        }
        .navigationTitle("Sign In")
        .padding()
    }
}
