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
    
    @Binding var deleteMultiple: [Product]
    
    var product: Product
    
    var body: some View {
        HStack {
            CheckBoxView(checked: $checked, trimVal: $trimVal, prodID: $prodID)
                .onAppear() {
                    checkBoxRefreshSelected()
                }
                .onTapGesture {
                    if !self.checked {
                        withAnimation(Animation.easeInOut(duration: 0.5)) {
                            self.trimVal = 1
                            self.checked.toggle()
                        }
                        deleteMultiple.append(product)
                    } else {
                        withAnimation {
                            self.trimVal = 0
                            self.checked.toggle()
                        }
                        deleteMultiple.remove(at: deleteMultiple.firstIndex(of: product)!)
                    }
                }
            KFImage(URL(string: product.image)!)
                .resizable()
            .frame(width: 50, height: 50)
            Text(product.title)
                .font(Font.system(size:15, design: .default))
            Spacer()
        }
    }
    
    init(product: Product, deleteMultiple: Binding<[Product]>){
        self.product = product
        _deleteMultiple = deleteMultiple
        _prodID = State(initialValue: product.id)
    }
    
    func checkBoxRefreshSelected() -> Void {
        if deleteMultiple.firstIndex(of: product) != nil {
            checked = true
        }
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
