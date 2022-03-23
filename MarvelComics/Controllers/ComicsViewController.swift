//
//  ComicsViewController.swift
//  MarvelComics
//
//  Created by Tarek El Ghoul on 22/03/2022.
//

import UIKit

class ComicsViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let cellIdentifier = "ComicCollectionViewCell"
    private var comicListVM: ComicListViewModel!
    
    var comics : [Comic] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup () {
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        let url = Webservices().generateURL()
        
        Webservices().getComics(url: url) { comicData in
            if let comics = comicData?.data?.results {
                self.comicListVM = ComicListViewModel(comics)
            }
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        
    }
    
}




extension ComicsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.comicListVM == nil ? 0 : self.comicListVM.numberOfSection
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return comicListVM.numberOfRowsInSection(section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? ComicCollectionViewCell else {
            fatalError("ArticleTableViewCell not found")
        }
        
        let articleVM = self.comicListVM.comicAtIndex(index: indexPath.row)
        
        cell.comicImageView?.imageFromServerURL(urlString: articleVM.image, PlaceHolderImage: UIImage(systemName: "person")!)
        
        
        return cell
        
    }
    
}

