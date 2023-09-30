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
    @IBOutlet weak var eventsCollView: UICollectionView!
    @IBOutlet weak var storiesCollView: UICollectionView!
    let imageDownloader = ImageDownloader()
    var character: Character?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
    }
    
    func setupView(){
        seriesCollView.register(SeriesCollectionViewCell.nib, forCellWithReuseIdentifier: SeriesCollectionViewCell.identifier)
        comicsCollView.register(SeriesCollectionViewCell.nib, forCellWithReuseIdentifier: SeriesCollectionViewCell.identifier)
        eventsCollView.register(SeriesCollectionViewCell.nib, forCellWithReuseIdentifier: SeriesCollectionViewCell.identifier)
        storiesCollView.register(SeriesCollectionViewCell.nib, forCellWithReuseIdentifier: SeriesCollectionViewCell.identifier)
        if let character = character {
            if let seriesItems = character.series?.items {
                seriesArray = Array(seriesItems.prefix(3))
                self.seriesCollView.reloadData()
            }
            
            if let comicsItems = character.comics?.items {
                comicsArray = Array(comicsItems.prefix(3))
                self.comicsCollView.reloadData()
            }
            
            if let eventsItems = character.events?.items {
                eventsArray = Array(eventsItems.prefix(3))
                self.eventsCollView.reloadData()
            }
            
            if let storiesItems = character.stories?.items {
                storiesArray = Array(storiesItems.prefix(3))
                self.storiesCollView.reloadData()
            }
            
            imageDownloader.downloadImage(from: (character.thumbnail?.url)!) { image in
                if let image = image {
                    // Handle the downloaded image
                    DispatchQueue.main.async {
                        self.characterImg.image = image
                        self.characterName.text = "Name: \(String(describing: character.name!)), id: \(String(describing: character.id!))"
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
        }else if collectionView == eventsCollView{
            return eventsArray.count
        }else if collectionView == comicsCollView{
            return comicsArray.count
        }else{
            return storiesArray.count
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
        }else if collectionView == eventsCollView{
            let events = eventsArray[indexPath.row]
        cell.seriesName.text = events.name
            return cell
        }else if collectionView == comicsCollView{
            let comics = comicsArray[indexPath.row]
        cell.seriesName.text = comics.name
            return cell
        }else if collectionView == storiesCollView{
            let stories = comicsArray[indexPath.row]
        cell.seriesName.text = stories.name
            return cell
        }
        return UICollectionViewCell()
    }
}
