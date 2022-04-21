//
//  ContentView.swift
//  Impetus
//
//  Created by Harshal Kulkarni on 21/04/22.
//

import SwiftUI

struct ContentView: View {
    
//    @State var products = [Product]()
    
    var body: some View {
        ZStack{
            Color("Bg")
                .edgesIgnoringSafeArea(.all)
            
            VStack (alignment: .leading){
                AppBarView()
                
//                Spacer()
//                    .frame(height: 10.0)
                
                TagLineView()
                    .padding(.leading)
                
//                SearchView()
//
//                Spacer()
//                    .frame(height: 20.0)
//
//                ThreeButtonView()
                
//                Spacer()
//                    .frame(height: 550.0)
                    
                ListView_Products()
                
            }
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct AppBarView: View {
    var body: some View {
        HStack{
            Button(action: {}) {
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
                    ProductDetail()
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

