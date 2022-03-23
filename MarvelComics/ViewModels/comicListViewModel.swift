//
//  comicListViewModel.swift
//  MarvelComics
//
//  Created by Tarek El Ghoul on 23/03/2022.
//

import Foundation


struct comicListViewModel {
    private let comics : [Comic]
    
    var numberOfSection: Int {
        return 1
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return self.comics.count
    }
    
    func comicAtIndex(index : Int) -> ComicViewModel {
        let comic = comics[index]
        return ComicViewModel(comic)
    }
}
