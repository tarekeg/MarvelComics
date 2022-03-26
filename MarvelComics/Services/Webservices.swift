//
//  Webservices.swift
//  MarvelComics
//
//  Created by Tarek El Ghoul on 21/03/2022.
//

import Foundation


class Webservices {
    
    private let limit = 20
    
    func generateURL(at page: Int) -> URL {
        
        let timestamp = "\(Date().timeIntervalSince1970)"
        let hash = "\(timestamp)\(CONSTANT.KEY.PRIVATEKEY)\(CONSTANT.KEY.PUBLICKEY)".md5()
        let baseURL = URL(string: CONSTANT.PATH.baseURL)
        
        var components = URLComponents(url: baseURL!.appendingPathComponent(CONSTANT.PATH.allComics), resolvingAgainstBaseURL: true)
        
        var pageQueryItems = [URLQueryItem]()
        
        if page > 0 {
            pageQueryItems.append(URLQueryItem(name: "offset", value: "\(page * limit)"))
        }
        
        
        let commonQueryItems = [
            URLQueryItem(name: "ts", value: timestamp),
            URLQueryItem(name: "hash", value: hash),
            URLQueryItem(name: "apikey", value: CONSTANT.KEY.PUBLICKEY)
        ]
        
        components?.queryItems = commonQueryItems + pageQueryItems
        
        return (components?.url)!
    }
    
    func getComics(url : URL, completion: @escaping(ComicData?) -> ()) {
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
            } else if let data = data {
                
                let data = try? JSONDecoder().decode(ComicData.self, from: data)
                
                if let data = data {
                    completion(data)
                }
            }
            
        }.resume()
        
    }
    
    
    
}
