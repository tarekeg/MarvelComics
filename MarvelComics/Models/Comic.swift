//
//  Comic.swift
//  MarvelComics
//
//  Created by Tarek El Ghoul on 21/03/2022.
//

import Foundation

struct Comic: Decodable {
    
    let id: Int
    let title: String
    let description: String
    let thumbnail: Image
    
}

