//
//  EditProductView.swift
//  Impetus
//
//  Created by Harshal Kulkarni on 27/04/22.
//

import SwiftUI
import AlertToast

struct EditProductView: View {
    var product: Product
    
    @State var productId = ""
    @State var productName = ""
    @State var productPrice = ""
    @State var productCategory = ""
    @State var productDescription = ""
    
    @State private var alertWrongInfo = false
    @State private var productUpdated = false
    
    @Environment(\.presentationMode) var presentationMode
    
    
    init(product: Product){
        self.product = product
        _productId = State(initialValue: String(product.id))
        _productName = State(initialValue: product.title)
        _productPrice = State(initialValue: String(product.price))
        _productCategory = State(initialValue: product.category)
        _productDescription = State(initialValue: product.description)
    }
    
    var body: some View {
        NavigationView {
            Form {
                VStack {
                    HStack {
                        Text("Product ID")
                            .fixedSize(horizontal: false, vertical: true)
                            .font(.callout)
                            .frame(width: 130, height: 50, alignment: .leading)
                        
                        //                    Spacer()
                        //                        .frame(width: 25)
                        
                        TextField("", text: $productId)
                            .font(.callout)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                            .padding(15)
                            .background(Color(.secondarySystemBackground))
                            .padding(.bottom, 5)
                            .disabled(true)
                    }
                    
                    HStack {
                        Text("Product Name")
                            .fixedSize(horizontal: false, vertical: true)
                            .font(.callout)
                            .frame(width: 130, height: 50, alignment: .leading)
                        
                        //                    Spacer()
                        //                        .frame(width: 25)
                        
                        TextField("", text: $productName)
                            .font(.callout)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                            .padding(15)
                            .background(Color(.secondarySystemBackground))
                            .padding(.bottom, 5)
                    }
                    
                    HStack {
                        Text("Product Price")
                            .fixedSize(horizontal: false, vertical: true)
                            .font(.callout)
                            .frame(width: 130, height: 50, alignment: .leading)
                        
                        //                        Spacer()
                        //                            .frame(width: 25)
                        
                        TextField("", text: $productPrice)
                            .font(.callout)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                            .padding(15)
                            .background(Color(.secondarySystemBackground))
                            .padding(.bottom, 5)
                    }
                    
                    HStack {
                        Text("Product Category")
                            .fixedSize(horizontal: false, vertical: true)
                            .font(.callout)
                            .frame(width: 130, height: 50, alignment: .leading)
                        
                        //                        Spacer()
                        //                            .frame(width: 25)
                        
                        TextField("", text: $productCategory)
                            .font(.callout)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                            .padding(15)
                            .background(Color(.secondarySystemBackground))
                            .padding(.bottom, 5)
                    }
                    
                    HStack {
                        Text("Product Description")
                            .fixedSize(horizontal: false, vertical: true)
                            .font(.callout)
                            .frame(width: 113, height: 50, alignment: .leading)
                        
                        Spacer()
                            .frame(width: 25)
                        
                        TextEditor(text: $productDescription)
                            .font(.callout)
                            .disableAutocorrection(true)
                            .autocapitalization(.none)
                            .padding(15)
                            .background(Color(.secondarySystemBackground))
                            .padding(.bottom, 5)
                            .lineLimit(4)
                    }
                    
                    Button(action: {
                        guard !productName.isEmpty, !productPrice.isEmpty, !productCategory.isEmpty else {
                            alertWrongInfo = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                                alertWrongInfo = false
                            }
                            return
                        }
                        
                        let id = Int(productId)
                        let price = Double(productPrice)
                        
                        if updateProduct(prodIdParam: id!, titleParam: productName, priceParam: price!, descriptionParam: productDescription, imageParam: "https://i.pravatar.cc", categoryParam: productCategory) {
                            productUpdated = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                                alertWrongInfo = false
                                productUpdated = false
                                presentationMode.wrappedValue.dismiss()
                            }
                        }
                        
                    }, label: { Text("Confirm Edit")
                            .frame(width: 200, height: 50)
                            .background(Color.green)
                            .cornerRadius(8)
                            .foregroundColor(Color.white)
                            .font(.system(size: 16, weight: .bold, design: .default))
                    })
                    
                }
                .padding(.vertical, 20)
            }
            .navigationTitle("Edit Product")
            .toast(isPresenting: $alertWrongInfo){
                AlertToast(type: .error(Color.black), title: "Incomplete", subTitle: "Please fill all Fields")
            }
            .toast(isPresenting: $productUpdated){
                AlertToast(type: .complete(Color.green), title: "Product Info Updated", subTitle: "")
            }
        }
    }
}
