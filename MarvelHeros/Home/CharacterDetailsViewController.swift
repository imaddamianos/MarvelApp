//
//  CharacterDetailsViewController.swift
//  MarvelHeros
//
//  Created by iMad on 28/09/2023.
//

import UIKit

class CharacterDetailsViewController: UIViewController {
    @IBOutlet weak var characterImg: UIImageView!
    @IBOutlet weak var characterName: UILabel!
    @IBOutlet weak var seriesCollView: UICollectionView!
    @IBOutlet weak var comicsCollView: UICollectionView!
    let imageDownloader = ImageDownloader()
    var character: Character?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
    }
    
    func setupView(){
        seriesCollView.register(SeriesCollectionViewCell.nib, forCellWithReuseIdentifier: SeriesCollectionViewCell.identifier)
        comicsCollView.register(SeriesCollectionViewCell.nib, forCellWithReuseIdentifier: SeriesCollectionViewCell.identifier)
        if let character = character {
            if let seriesItems = character.series?.items {
                // Limit seriesArray to the first 3 items
                seriesArray = Array(seriesItems.prefix(3))
                self.seriesCollView.reloadData()
            }
            
            if let comicsItems = character.comics?.items {
                // Limit comicsArray to the first 3 items
                comicsArray = comicsItems // Assuming comicsArray is of type [ComicsSummary]
                self.comicsCollView.reloadData()
            }
            
            imageDownloader.downloadImage(from: (character.thumbnail?.url)!) { image in
                if let image = image {
                    // Handle the downloaded image
                    DispatchQueue.main.async {
                        self.characterImg.image = image
                        self.characterName.text = character.name
                    }
                } else {
                    // Handle the case where image download failed
                    print("Failed to download image.")
                }
            }
        }



        
            }
        }

// MARK: - UICollectionView

extension CharacterDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == seriesCollView{
            return seriesArray.count
        }else{
            return seriesArray.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SeriesCollectionViewCell.identifier, for: indexPath) as! SeriesCollectionViewCell
        if collectionView == seriesCollView{
            let series = seriesArray[indexPath.row]
        cell.seriesName.text = series.name
            return cell
        }else{
            let series = comicsArray[indexPath.row]
        cell.seriesName.text = series.name
            return cell
        }
    }
}
