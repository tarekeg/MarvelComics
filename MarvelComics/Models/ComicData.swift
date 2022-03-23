//
//  ComicData.swift
//  MarvelComics
//
//  Created by Tarek El Ghoul on 23/03/2022.
//

import Foundation


struct ComicData: Decodable {
    
    let code: Int?
    let status: String?
    let data: ComicResult?
    
}
