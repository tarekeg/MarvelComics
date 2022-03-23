//
//  Constant.swift
//  MarvelComics
//
//  Created by Tarek El Ghoul on 22/03/2022.
//

import Foundation


struct CONSTANT {
    
    // MARK: Path
    struct PATH {
        static let baseURL = "https://gateway.marvel.com:443"
        static let allComics = "/v1/public/comics"
    }
    // MARK: Keys
    struct KEY {
        static let PUBLICKEY = "d7377136ac7e5d3e12e325b01e03f1c7"
        static let PRIVATEKEY = "092338bf3d182359cf940735903ede3ea64978eb"
    }
    
}
