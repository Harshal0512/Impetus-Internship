//
//  Model.swift
//  Impetus Internship App
//
//  Created by Harshal Kulkarni on 21/04/22.
//

import Foundation
import SwiftUI

struct Product: Hashable, Codable, Identifiable {  // this is the general model for a product used in this app
    
    var id: Int
    var title: String
    var price: Double
    var description: String
    var category: String
    var image: String
}

struct outboundProduct: Codable {  // this model is used in API of Add & Edit Product
    let title: String
    let price: Double
    let description: String
    let image: String
    let category: String
}
