//
//  ComicResult.swift
//  MarvelComics
//
//  Created by Tarek El Ghoul on 23/03/2022.
//

import Foundation

struct ComicResult: Decodable {
    
    let offset: Int?
    let limit: Int?
    let total: Int?
    let count: Int?
    let results: [Comic]?
    
}
