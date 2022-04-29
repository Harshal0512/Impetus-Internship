//
//  AddProductButton.swift
//  Impetus
//
//  Created by Harshal Kulkarni on 29/04/22.
//

import SwiftUI

struct AddProductButton: View {
    @State private var showAddProductView = false
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var data: [Product]
    
    var body: some View {
        HStack(spacing: 0.0) {
            Spacer()
            
            Button(action: {
                showAddProductView.toggle()
            }) {
                Label("Add Product", systemImage: "plus.app.fill")
            }
        }
        .padding()
        .frame(alignment: .center)
        .sheet(isPresented: $showAddProductView) {
            showAddProductView = false
            presentationMode.wrappedValue.dismiss()
        } content: {
            AddProductView(data: $data)
        }
    }
}
