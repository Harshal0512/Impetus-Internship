//
//  ProductRow.swift
//  Impetus
//
//  Created by Harshal Kulkarni on 21/04/22.
//

import SwiftUI
import Kingfisher

struct ProductRow: View {
    @State var prodID: Int
    
    var product: Product
    
    var body: some View {
        HStack {
            KFImage(URL(string: product.image)!)
                .resizable()
                .frame(width: 50, height: 50)
            Text(product.title)
                .font(Font.system(size:15, design: .default))
            Spacer()
        }
    }
    
    init(product: Product){
        self.product = product
        _prodID = State(initialValue: product.id)
    }
}
