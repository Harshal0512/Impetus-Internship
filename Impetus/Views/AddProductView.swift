//
//  AddProductView.swift
//  Impetus
//
//  Created by Harshal Kulkarni on 27/04/22.
//

import SwiftUI
import AlertToast

struct AddProductView: View {
    
    @State var productName = ""
    @State var productPrice = ""
    @State var productCategory = ""
    @State var productDescription = ""
    
    @State private var alertWrongInfo = false
    @State private var productAdded = false
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            Form {
                VStack {
                    HStack {
                        Text("Product Name")
                            .fixedSize(horizontal: false, vertical: true)
                            .font(.callout)
                            .frame(width: 130, height: 50, alignment: .leading)
                        
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
                            .frame(width: 130, height: 50, alignment: .leading)
                        
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

                        let price = Double(productPrice)
                        
                        if addProduct(titleParam: productName, priceParam: price!, descriptionParam: productDescription, imageParam: "https://i.pravatar.cc", categoryParam: productCategory) {
                            productAdded = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                                alertWrongInfo = false
                                productAdded = false
                                presentationMode.wrappedValue.dismiss()
                            }
                        }
                        
                    }, label: { Text("Add Product")
                            .frame(width: 200, height: 50)
                            .background(Color.green)
                            .cornerRadius(8)
                            .foregroundColor(Color.white)
                            .font(.system(size: 16, weight: .bold, design: .default))
                    })
                    
                }
                .padding(.vertical, 20)
            }
            .navigationTitle("Add Product")
            .toast(isPresenting: $alertWrongInfo){
                AlertToast(type: .error(Color.black), title: "Incomplete", subTitle: "Please fill all Fields")
            }
            .toast(isPresenting: $productAdded){
                AlertToast(type: .complete(Color.green), title: "New Product Added", subTitle: "")
            }
        }
    }
}
