//
//  Model.swift
//  Impetus Internship App
//
//  Created by Harshal Kulkarni on 21/04/22.
//

import Foundation
import SwiftUI

struct Product: Hashable, Codable, Identifiable {
    
    var id: Int
    var title: String
    var price: Double
    var description: String
    var category: String
    var image: String
}

struct outboundProduct: Codable {
    let title: String
    let price: Double
    let description: String
    let image: String
    let category: String
}

//
//struct Product: Codable, Identifiable {
//    let id = UUID()
//    var prod_id: Int
//    var title: String
//    var price: Double
//    var description: String
//    var category: String
//    var image: String
//    var rating: Int
//    var rate_count: Int
//}
////https://fakestoreapi.com/products/1
///


