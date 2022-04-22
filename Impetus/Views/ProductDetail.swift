//
//  ProductDetail.swift
//  Impetus
//
//  Created by Harshal Kulkarni on 21/04/22.
//

import SwiftUI
import Kingfisher

struct ProductDetail: View {
    var product: Product
    
    var body: some View {
        VStack {
            ZStack {
                Color("Bg")
                    .edgesIgnoringSafeArea(.all)
                ScrollView{
                    VStack {
                        KFImage(URL(string: product.image)!)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
//                          .edgesIgnoringSafeArea(.top)
                    
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
                        
                            Text("Description")
                                .fontWeight(.medium)
                                .padding(.top, 8)
                                .padding(.bottom,4)
                        
                            Text(product.description)
                                .lineSpacing(8.0)
                                .opacity(0.6)
                        }
                        .padding()
                        .padding(.top)
                        .background(Color.white)
                    
                        HStack{
                            Text("$\(String(format: "%g", product.price))")
                                .font(Font.system(size:30))
                                .foregroundColor(Color.white)
                            
                            Spacer()
                            
                            Button (action: {},  label: {
                                Label("Edit Item", systemImage: "pencil")
                                    .padding()
                                    .padding(.horizontal)
                                    .background(Color.white)
                                    .cornerRadius(10.0)
                            })
                        }
                        .padding()
                        .background(Color("Primary"))
                        .frame(maxHeight: .infinity, alignment: .bottom)
                    }
                }
            }
        }
    }
}

struct ProductDetail_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetail(product: products[0])
    }
}
