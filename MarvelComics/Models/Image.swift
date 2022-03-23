//
//  Image.swift
//  MarvelComics
//
//  Created by Tarek El Ghoul on 22/03/2022.
//

import Foundation


struct Image: Decodable {
    
    let path: String?
    let ext:String?
    var stringPath: String? {
        if let path = path, let ext = ext {
            return "\(path).\(ext)"
        } else {
            return nil
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case path
        case ext = "extension"
    }
    
}
