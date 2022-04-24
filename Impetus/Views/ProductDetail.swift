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
            ZStack {  // for background image
                Color("Bg")
                    .edgesIgnoringSafeArea(.all)  // stretching background to the 
                ScrollView{
                    VStack {
                        KFImage(URL(string: product.image)!)  // Kingfisher library for asynchronously caching images
                            .resizable()
                            .aspectRatio(contentMode: .fit)  // to fit image on screen
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
                        }
                        .padding()
                        .padding(.top)
                        .background(Color.white)
                    }
                }
                VStack { // using zstack for displaying edit button on top of content
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {}, label: { // edit button
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

//                    HStack{
//                        Text("$\(String(format: "%g", product.price))")
//                            .font(Font.system(size:30))
//                            .foregroundColor(Color.white)
//
//                        Spacer()
//
//                        Button (action: {},  label: {
//                            Label("Edit Item", systemImage: "square.and.pencil")
//                                .padding()
//                                .padding(.horizontal)
//                                .background(Color.white)
//                                .cornerRadius(10.0)
//                        })
//                    }
//                    .padding()
//                    .background(Color("Primary"))
//                    .frame(maxHeight: .infinity, alignment: .bottom)
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
