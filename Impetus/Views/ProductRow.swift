//
//  ProductRow.swift
//  Impetus
//
//  Created by Harshal Kulkarni on 21/04/22.
//

import SwiftUI
import Kingfisher

struct ProductRow: View {
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
}

struct ProductRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ProductRow(product: products[0])
            ProductRow(product: products[1])
        }
        .previewLayout(.fixed(width: 300, height: 70))
    }
}
