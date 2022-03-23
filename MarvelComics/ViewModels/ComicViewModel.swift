//
//  ComicViewModel.swift
//  MarvelComics
//
//  Created by Tarek El Ghoul on 23/03/2022.
//

import Foundation

struct ComicViewModel {
    
    private let comic: Comic
    
    
    init(_ comic: Comic) {
        self.comic = comic
    }
    
    var title : String {
        return self.comic.title
    }
    
    var description: String {
        return self.comic.description
    }
    var image: String {
        if let comicImage = comic.thumbnail.stringPath {
            return comicImage
        } else {
            return ""
        }
        
    }

}
