//
//  HomeViewController.swift
//  MarvelHeros
//
//  Created by iMad on 28/09/2023.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var charactersTableView: UITableView!
    let marvelAPI = MarvelAPI.shared
    var charInfo: [Character] = []
    let imageDownloader = ImageDownloader()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register TableView Cell
        self.charactersTableView.register(ThumbCharacterTableViewCell.nib, forCellReuseIdentifier: ThumbCharacterTableViewCell.identifier)

        marvelAPI.characterService.getAllCharacters { characters, error in
            if let characters = characters {
                // Handle the retrieved characters
                print(characters)
                self.charInfo = characters
            } else if let error = error {
                // Handle the error
                print("Error retrieving characters: \(error)")
            }
            DispatchQueue.main.async {
//                // Update TableView with the data
                self.charactersTableView.reloadData()
            }
        }
        
    }


}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.charInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ThumbCharacterTableViewCell.identifier, for: indexPath) as? ThumbCharacterTableViewCell else { fatalError("xib doesn't exist") }
        
        imageDownloader.downloadImage(from: (charInfo[indexPath.row].thumbnail?.url)!) { image in
            if let image = image {
                // Handle the downloaded image
                DispatchQueue.main.async {
                    // Update the UI with the downloaded image
                    cell.charImg.image = image
                }
            } else {
                // Handle the case where image download failed
                print("Failed to download image.")
            }
        }
            cell.charNameLbl.text = charInfo[indexPath.row].name

        // Highlighted color
        let myCustomSelectionColorView = UIView()
        myCustomSelectionColorView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        cell.selectedBackgroundView = myCustomSelectionColorView
        return cell

    }
    
    
}
