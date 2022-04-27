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
//            Button(action: {}) {
//                Image("menu")
//                    .padding()
//                    .background(Color(.white))
//                    .cornerRadius(10.0)
//            }
            TagLineView()
                .padding(.leading)
                .padding(.bottom)
            
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

//struct SearchView: View {
//    @State private var search: String = ""
//    var body: some View {
//        HStack {
//            HStack {
//                Image("Search")
//                    .padding(.trailing, 8)
//                TextField("Search for Products", text: $search)
//            }
//            .padding()
//            .background(Color.white)
//            .cornerRadius(10.0)
//            .padding(.horizontal)
//        }
//    }
//}

struct AddButton: View {
    @State private var showAddProductView = false
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        HStack(spacing: 0.0) {
            Spacer()
            
            Button(action: {
                showAddProductView.toggle()
            }) {
                    Label("Add Product", systemImage: "plus.app.fill")
            }
        }
        .padding()
        .frame(alignment: .center)
        .sheet(isPresented: $showAddProductView) {
            showAddProductView = false
            presentationMode.wrappedValue.dismiss()
        } content: {
            AddProductView()
        }
    }
}


extension View {
    func Print(_ vars: Any...) -> some View {
        for v in vars { print(v) }
        return EmptyView()
    }
}

struct ListView_Products: View {
    @State public var productDeleted = false
    @Environment(\.presentationMode) var presentationMode
    
    @State var data = products
    
    var body: some View {
        NavigationView {
            List {
                ForEach(data) { product in
                    NavigationLink {
                        ProductDetailView(product: product, productDeleted: self.$productDeleted)
                            .onDisappear() {
                                if productDeleted {
                                    productDeleted = false
                                    data.remove(at: data.firstIndex(of: product)!)
                                }
                            }
                    } label: {
                        ProductRow(product: product)
                    }
                }
                .onDelete { index in
                    index.forEach { i in
                        DispatchQueue.main.async {
                            if deleteProduct(prodIdParam: data[i].id) {
                                data.remove(at: i)
                            }
                        }
                    }
                    
                }
            }
            .navigationBarHidden(true)
            .toast(isPresenting: $productDeleted){
                AlertToast(type: .error(Color.black), title: "Product Deleted", subTitle: "")
            }
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
                
                ScrollView{
                    AppBarView()
                        .padding(.bottom, 15)
                    
                    AddButton()
                    ListView_Products()
                        .frame(height: 540)
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
}


struct LoginView: View {
    @State var email = ""
    @State var password = ""
    
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
                
                NavigationLink("Click here to Sign Up", destination: SignUpView())

            }
        }
        .navigationTitle("Sign In")
        .padding()
    }
}

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
