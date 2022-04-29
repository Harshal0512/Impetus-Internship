//
//  ProductDetail.swift
//  Impetus
//
//  Created by Harshal Kulkarni on 21/04/22.
//

import SwiftUI
import Kingfisher
import AlertToast

struct ProductDetailView: View {
    var product: Product
    
    @Environment(\.presentationMode) var presentationMode
    @Binding var productDeleted: Bool
    @State var isEditing = false
    @State private var showingConfirmation = false
    
    @Binding var data: [Product]
    
    var body: some View {
        VStack {
            ZStack {  // for background image
                Color("Bg")
                    .edgesIgnoringSafeArea(.all)  // stretching background to the
                ScrollView{
                    VStack {
                        KFImage(URL(string: product.image)!)  // Kingfisher library for asynchronously caching images
                            .resizable()
                            .aspectRatio(contentMode: .fit)  // to fit image on screen
                            .offset(y: -50)
                        
                        Divider()
                        
                        VStack(alignment: .leading) {
                            Text(product.title)
                                .font(.title)
                                .fontWeight(.bold)
                            
                            HStack {
                                Text("Category: \(product.category.capitalized)")
                                    .opacity(0.5)
                                Spacer()
                            }
                            .padding(.bottom)
                            
                            Text("Price: $\(String(format: "%g", product.price))")  // remove trailing zeroes from price
                                .fontWeight(.medium)
                                .font(Font.system(size:20))
                                .padding(.bottom,4)
                            
                            Text("Description")
                                .fontWeight(.medium)
                                .padding(.top, 8)
                                .padding(.bottom,4)
                            
                            Text(product.description)
                                .lineSpacing(8.0)
                                .opacity(0.6)
                                .padding(.bottom)
                        }
                        .padding(.horizontal)
                    }
                }
                .background(Color.white)
                
                VStack { // using zstack for displaying edit button on top of content
                    Spacer()
                    HStack {
                        Spacer()
                        ZStack{
                            Button(action: {
                                showingConfirmation = true
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
                            .offset(y: -78)
                            .confirmationDialog("Delete Item", isPresented: $showingConfirmation) {
                                Button("Delete", role: .destructive) {
                                    DispatchQueue.main.async {
                                        if  deleteProduct(prodIdParam: product.id) {
                                            productDeleted = true
                                            presentationMode.wrappedValue.dismiss()
                                        }
                                    }
                                }
                                
                                Button("Cancel", role: .cancel) { }
                            } message: {
                                Text("Are you sure you want to delete this item? This action cannot be undone.")
                            }
                            
                            
                            Button(action: {
                                isEditing = true
                            }, label: { // edit button
                                Label("", systemImage: "pencil")
                                    .font(.system(.largeTitle))
                                    .frame(width: 60, height: 60)
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
                            .sheet(isPresented: $isEditing) {
                                isEditing = false
                            } content: {
                                EditProductView(product: product, data: $data)
                            }
                        }
                    }
                }
            }
        }
    }
}
