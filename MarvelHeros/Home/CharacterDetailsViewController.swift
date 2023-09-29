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
    let imageDownloader = ImageDownloader()
    var character: Character?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
    }
    
    func setupView(){
        seriesCollView.delegate = self
        seriesCollView.dataSource = self
        seriesCollView.register(SeriesCollectionViewCell.nib, forCellWithReuseIdentifier: SeriesCollectionViewCell.identifier)
        if let character = character {
            if let seriesItems = character.series?.items {
                // Limit seriesArray to the first 3 items
                seriesArray = Array(seriesItems.prefix(3))
                self.seriesCollView.reloadData()
                
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
        }

// MARK: - UICollectionView

extension CharacterDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return seriesArray.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        if collectionView == seriesCollView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SeriesCollectionViewCell.identifier, for: indexPath) as! SeriesCollectionViewCell
            let series = seriesArray[indexPath.row]
        cell.seriesName.text = series.name
            return cell
//        }
//        return UICollectionViewCell()
        
    }
    
    
}
