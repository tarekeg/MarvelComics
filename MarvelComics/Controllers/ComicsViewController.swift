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
    
    var page = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup () {
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        getData(at: page)
    }
    
    func getData(at page: Int) {
        
        let url = Webservices().generateURL(at: page)
        
        Webservices().getComics(url: url) { comicData in
            if let comicsFromApi = comicData?.data?.results {
                self.comics.append(contentsOf: comicsFromApi)
                self.comicListVM = ComicListViewModel(self.comics)
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

extension ComicsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let noOfCellsInRow = 2

        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout

        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(noOfCellsInRow - 1))

        let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(noOfCellsInRow))

        return CGSize(width: size, height: size)
    }
    
}

extension ComicsViewController: UIScrollViewDelegate {
func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let height = scrollView.frame.height
    let contentSizeHeight = scrollView.contentSize.height
    let offset = scrollView.contentOffset.y
    let reachedBottom = (offset + height == contentSizeHeight)

    if reachedBottom {
        scrollViewDidReachBottom(scrollView)
    }
}

func scrollViewDidReachBottom(_ scrollView: UIScrollView) {
    page += 1
    getData(at: page)
}
}


