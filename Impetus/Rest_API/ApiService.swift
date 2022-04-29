//
//  ApiService.swift
//  Impetus Internship App
//
//  Created by Harshal Kulkarni on 21/04/22.
//

import Foundation


var products: [Product] = getAllProducts()

func getAllProducts() -> [Product] {
    guard let url = URL(string: "https://fakestoreapi.com/products/")
            //  guard let url = URL(string: "https://fakestoreapi.com/products?limit=5")
            //  guard let url = URL(string: "https://fakestoreapi.com/products?sort=desc")
    else{
        fatalError("Invalid URL")   // will throw error if URL cannot be created
        
    }
    
    // move forward if URL is created
    
    var tasks: [Product] = []
    let task = URLSession.shared.dataTask(with: url)
    let decoder = JSONDecoder()
    let data: Data
    
    do {
        data = try Data(contentsOf: url)
    } catch {
        fatalError("Couldn't load ")
    }
    
    do{
        tasks = try decoder.decode([Product].self, from: data)
    }catch{
        print(error)
    }
    
    task.resume()
    return tasks
    
}


func addProduct(titleParam: String,
                priceParam: Double,
                descriptionParam: String,
                imageParam: String,
                categoryParam: String
) -> Bool {
    guard let url = URL(string: "https://fakestoreapi.com/products/") else {
        print("Error: cannot create URL")  // will throw error if URL cannot be created
        return false
    }
    
    // Add data to the model
    let uploadDataModel = outboundProduct(title: titleParam, price: priceParam, description: descriptionParam, image: imageParam, category: categoryParam)
    
    // Convert model to JSON data
    guard let jsonData = try? JSONEncoder().encode(uploadDataModel) else {
        print("Error: Trying to convert model to JSON data")
        return false
    }
    
    // Create the url request
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type") // the request is JSON
    request.setValue("application/json", forHTTPHeaderField: "Accept") // the response expected to be in JSON format
    request.httpBody = jsonData
    URLSession.shared.dataTask(with: request) { data, response, error in
        guard error == nil else {
            print("Error: error calling POST")
            print(error!)
            return
        }
        guard let data = data else {
            print("Error: Did not receive data")  // will throw error if no data received
            return
        }
        guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode
        else {
            print("Error: HTTP request failed")
            return
        }
        do {
            guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                print("Error: Cannot convert data to JSON object")
                return
            }
            guard let prettyJsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) else {
                print("Error: Cannot convert JSON object to Pretty JSON data")
                return
            }
            guard let prettyPrintedJson = String(data: prettyJsonData, encoding: .utf8) else {
                print("Error: Couldn't print JSON in String")
                return
            }
            
            print(prettyPrintedJson)
        } catch {
            print("Error: Trying to convert JSON data to string")
            return
        }
    }.resume()
    return true
}



func updateProduct(prodIdParam: Int,
                   titleParam: String,
                   priceParam: Double,
                   descriptionParam: String,
                   imageParam: String,
                   categoryParam: String
) -> Bool {
    let urlString = "https://fakestoreapi.com/products/\(prodIdParam)"
    guard let url = URL(string: urlString) else {
        print("Error: cannot create URL")  // will throw error if URL cannot be createds
        return false
    }
    
    // Add data to the model
    let uploadDataModel = outboundProduct(title: titleParam, price: priceParam, description: descriptionParam, image: imageParam, category: categoryParam)
    
    // Convert model to JSON data
    guard let jsonData = try? JSONEncoder().encode(uploadDataModel) else {
        print("Error: Trying to convert model to JSON data")
        return false
    }
    
    // Create the request
    var request = URLRequest(url: url)
    request.httpMethod = "PUT"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpBody = jsonData
    URLSession.shared.dataTask(with: request) { data, response, error in
        guard error == nil else {
            print("Error: error calling PUT")
            print(error!)
            return
        }
        guard let data = data else {
            print("Error: Did not receive data")
            return
        }
        guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
            print("Error: HTTP request failed")
            return
        }
        do {
            guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                print("Error: Cannot convert data to JSON object")
                return
            }
            guard let prettyJsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) else {
                print("Error: Cannot convert JSON object to Pretty JSON data")
                return
            }
            guard let prettyPrintedJson = String(data: prettyJsonData, encoding: .utf8) else {
                print("Error: Could print JSON in String")
                return
            }
            
            print(prettyPrintedJson)
        } catch {
            print("Error: Trying to convert JSON data to string")
            return
        }
    }.resume()
    return true
}



func deleteProduct(prodIdParam: Int) -> Bool {
    let urlString = "https://fakestoreapi.com/products/\(prodIdParam)"
    guard let url = URL(string: urlString) else {
        print("Error: cannot create URL")  // will throw error if URL cannot be createds
        return false
    }
    
    // Create the request
    var request = URLRequest(url: url)
    request.httpMethod = "DELETE"
    URLSession.shared.dataTask(with: request) { data, response, error in
        guard error == nil else {
            print("Error: error calling DELETE")
            print(error!)
            return
        }
        guard let data = data else {
            print("Error: Did not receive data")
            return
        }
        guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
            print("Error: HTTP request failed")
            return
        }
        do {
            guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                print("Error: Cannot convert data to JSON")
                return
            }
            guard let prettyJsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) else {
                print("Error: Cannot convert JSON object to Pretty JSON data")
                return
            }
            guard let prettyPrintedJson = String(data: prettyJsonData, encoding: .utf8) else {
                print("Error: Could print JSON in String")
                return
            }
            
            print(prettyPrintedJson)
        } catch {
            print("Error: Trying to convert JSON data to string")
            return
        }
    }.resume()
    return true
}
