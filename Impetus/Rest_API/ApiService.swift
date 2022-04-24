//
//  ApiService.swift
//  Impetus Internship App
//
//  Created by Harshal Kulkarni on 21/04/22.
//

import Foundation


//var products: [Product] = load("products.json")
var products: [Product] = decodeAPI()

//func load<T: Decodable>(_ filename: String) -> T {
//    let data: Data
//
//    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
//    else {
//        fatalError("Couldn't find \(filename) in main bundle.")
//    }
//
//    do {
//        data = try Data(contentsOf: file)
//    } catch {
//        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
//    }
//
//    do {
//        let decoder = JSONDecoder()
//        return try decoder.decode(T.self, from: data)
//    } catch {
//        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
//    }
//}

func decodeAPI() -> [Product] {
    guard let url = URL(string: "https://fakestoreapi.com/products/")
//  guard let url = URL(string: "https://fakestoreapi.com/products?limit=5")
//  guard let url = URL(string: "https://fakestoreapi.com/products?sort=desc")
    else{
        fatalError("Invalid URL")
        
    }

    var tasks: [Product] = []
    let task = URLSession.shared.dataTask(with: url)
    let decoder = JSONDecoder()
    let data: Data
    
    do {
        data = try Data(contentsOf: url)
    } catch {
        fatalError("Couldn't load Data")
    }
    
    do{
        tasks = try decoder.decode([Product].self, from: data)
    }catch{
        print(error)
    }
    
    task.resume()
    return tasks

}
