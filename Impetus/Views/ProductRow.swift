//
//  ProductRow.swift
//  Impetus
//
//  Created by Harshal Kulkarni on 21/04/22.
//

import SwiftUI
import Kingfisher

struct ProductRow: View {
    @State var checked: Bool = false
    @State var trimVal: CGFloat = 0
    @State var prodID: Int
    
    var product: Product
    
    var body: some View {
        HStack {
//            CheckBoxView(checked: $checked, trimVal: $trimVal, prodID: $prodID)
//                .onTapGesture {
//                    if !self.checked {
//                        withAnimation(Animation.easeInOut(duration: 0.5)) {
//                            self.trimVal = 1
//                            self.checked.toggle()
//                        }
//                    } else {
//                        withAnimation {
//                            self.trimVal = 0
//                            self.checked.toggle()
//                        }
//                    }
//                }
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

//struct ProductRow_Previews: PreviewProvider {
//    static var previews: some View {
//        Group {
//            ProductRow(product: products[0])
//            ProductRow(product: products[1])
//        }
//        .previewLayout(.fixed(width: 300, height: 70))
//    }
//}
