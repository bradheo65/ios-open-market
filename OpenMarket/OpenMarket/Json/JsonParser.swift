//
//  JsonParer.swift
//  OpenMarket
//
//  Created by BaekGom, Brad on 2022/07/12.
//

import Foundation

struct JsonParser {
    
    func fetch(by url: String) {
        guard let url = URL(string: url) else {
            return
        }
        
        var request = URLRequest.init(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data, error == nil else {
                return
            }
            
            var result: Page?
            
            do {
                result = try JSONDecoder().decode(Page.self, from: data)
            }
            catch {
                print("fail error: \(error)")
            }
            guard let json = result else {
                return
            }
            print(json)
        }
        task.resume()
    }
}
