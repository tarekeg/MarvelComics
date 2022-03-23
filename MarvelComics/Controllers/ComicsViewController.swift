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
    
    var comics : [Comic] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup () {
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        let url = Webservices().generateURL()
        
        Webservices().getComics(url: url) { comicData in
            print(comicData?.data?.results)
            if let comicData = comicData {
                self.comics = (comicData.data?.results)!
            }
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        
    }
    
}

extension ComicsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return comics.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! ComicCollectionViewCell
        
        let comic = comics[indexPath.row]
        
        cell.comicImageView?.imageFromServerURL(urlString: (comic.thumbnail?.stringPath)!, PlaceHolderImage: UIImage(systemName: "person")!)
        
        
        return cell
        
    }
    
}

extension UIImageView {
    
    public func imageFromServerURL(urlString: String, PlaceHolderImage:UIImage) {
        
        if self.image == nil{
            self.image = PlaceHolderImage
        }
        
        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                print(error ?? "No Error")
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                self.image = image
            })
            
        }).resume()
    }
    
}

