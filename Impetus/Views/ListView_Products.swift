//
//  ListView_Products.swift
//  Impetus
//
//  Created by Harshal Kulkarni on 29/04/22.
//

import SwiftUI
import AlertToast

struct ListView_Products: View {
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var data: [Product]
    
    @State public var productDeleted = false
    @State var showingConfirmation = false
    @State private var showAddProductView = false
    
    var body: some View {
        NavigationView {
            ZStack{
                List {
                    ForEach(data) { product in
                        NavigationLink {
                            ProductDetailView(product: product, productDeleted: self.$productDeleted, data: $data)
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
                    .onMove { (indexSet, index) in
                        data.move(fromOffsets: indexSet, toOffset: index)
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
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        EditButton()
                    }
                }
                .navigationTitle("")
                .navigationBarTitleDisplayMode(NavigationBarItem.TitleDisplayMode.inline)
                .padding(.top, 10)
                .edgesIgnoringSafeArea(.top)
                .toast(isPresenting: $productDeleted){
                    AlertToast(type: .error(Color.black), title: "Product Deleted", subTitle: "")
                }
                VStack { // using zstack for displaying edit button on top of content
                    Spacer()
                    HStack {
                        Spacer()
                        ZStack{
                            Button(action: {
                                showAddProductView.toggle()
                            }, label: { // delete button
                                Label("Add Product", systemImage: "plus.app.fill")
                                    .font(.system(.headline))
                                    .foregroundColor(Color.white)
                                    .padding(.horizontal, 14)
                                    .padding(.vertical, 10)
                            })
                            .sheet(isPresented: $showAddProductView) {
                                showAddProductView = false
                                presentationMode.wrappedValue.dismiss()
                            } content: {
                                AddProductView(data: $data)
                            }
                            .background(Color.blue)
                            .cornerRadius(13)
                            .padding()
                            .shadow(color: Color.black.opacity(0.3),
                                    radius: 3,
                                    x: 3,
                                    y: 3)
                        }
                    }
                }
            }
        }
    }
}
