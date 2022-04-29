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
    
    @State var deleteMultiple: [Product] = []
    
    @State public var productDeleted = false
    @State var multipleProductsDeleted = false
    @State var showingConfirmation = false
    @State var noItemSelected = false
    
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
                            ProductRow(product: product, deleteMultiple: $deleteMultiple)
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
                .toast(isPresenting: $multipleProductsDeleted){
                    AlertToast(type: .error(Color.black), title: "Selected Products Deleted", subTitle: "")
                }
                .toast(isPresenting: $noItemSelected){
                    AlertToast(type: .regular, title: "No Item Selected", subTitle: "Please select items through checkbox in order to delete them")
                }
                VStack { // using zstack for displaying edit button on top of content
                    Spacer()
                    HStack {
                        Spacer()
                        ZStack{
                            Button(action: {
                                if deleteMultiple.count < 1 {
                                    noItemSelected = true
                                } else {
                                    showingConfirmation = true
                                }
                            }, label: { // delete button
                                Label("", systemImage: "trash")
                                    .font(.system(.largeTitle))
                                    .frame(width: 55, height: 55)
                                    .foregroundColor(Color.white)
                                    .padding(.bottom, 7)
                                    .padding(.leading, 7)
                            })
                            
                            .background(Color.blue)
                            .cornerRadius(100)
                            .padding()
                            .shadow(color: Color.black.opacity(0.3),
                                    radius: 3,
                                    x: 3,
                                    y: 3)
                            .confirmationDialog("Delete Multiple Items", isPresented: $showingConfirmation) {
                                Button("Delete", role: .destructive) {
                                    DispatchQueue.main.async {
                                        for i in deleteMultiple.indices {
                                            let index = data.firstIndex(of: deleteMultiple[i])
                                            if  deleteProduct(prodIdParam: data[index!].id) {
                                                data.remove(at: index!)
                                            }
                                        }
                                        deleteMultiple.removeAll()
                                    }
                                    multipleProductsDeleted = true
                                }
                                
                                Button("Cancel", role: .cancel) { }
                            } message: {
                                Text("Are you sure you want to delete the selected items? This action cannot be undone.")
                            }
                        }
                    }
                }
            }
        }
    }
}
