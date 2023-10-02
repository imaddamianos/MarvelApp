//
//  HomeViewController.swift
//  MarvelHeros
//
//  Created by iMad on 28/09/2023.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var charactersTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var activityLoader: UIActivityIndicatorView!
    let marvelAPI = MarvelAPI.shared
    var charInfo: [Character] = []
    var filteredCharacters: [Character] = []
    var searchText: String = ""
    let imageDownloader = ImageDownloader()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Register TableView Cell
        self.charactersTableView.register(ThumbCharacterTableViewCell.nib, forCellReuseIdentifier: ThumbCharacterTableViewCell.identifier)
        showloader()
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
                self.hideloader()
                self.charactersTableView.reloadData()
            }
        }
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Use the filtered characters count if there's a search query, otherwise use the original data count
        return searchText.isEmpty ? charInfo.count : filteredCharacters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ThumbCharacterTableViewCell.identifier, for: indexPath) as? ThumbCharacterTableViewCell else {
            fatalError("xib doesn't exist")
        }
        
        // Determine whether to use the original data or filtered data
        let character = searchText.isEmpty ? charInfo[indexPath.row] : filteredCharacters[indexPath.row]
        
        imageDownloader.downloadImage(from: (character.thumbnail?.url)!) { image in
            if let image = image {
                // Handle the downloaded image
                DispatchQueue.main.async {
                    // Update the UI with the downloaded image
                    cell.charImg.image = image
                    cell.charImg.layer.cornerRadius = cell.charImg.layer.frame.height / 2
                }
            } else {
                // Handle the case where image download failed
                print("Failed to download image.")
            }
        }
        cell.charNameLbl.text = character.name
        
        // Highlighted color
        let myCustomSelectionColorView = UIView()
        myCustomSelectionColorView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        cell.selectedBackgroundView = myCustomSelectionColorView
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCharacter = searchText.isEmpty ? charInfo[indexPath.row] : filteredCharacters[indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let characterDetailsVC = storyboard.instantiateViewController(withIdentifier: "CharacterDetailsViewController") as! CharacterDetailsViewController
        characterDetailsVC.character = selectedCharacter
        navigationController?.pushViewController(characterDetailsVC, animated: true)
    }
    
    func showloader(){
        activityLoader.startAnimating()
        activityLoader.isHidden = false
    }
    
    func hideloader(){
        activityLoader.stopAnimating()
        activityLoader.isHidden = true
    }

}

extension HomeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // Update the searchText property
        self.searchText = searchText
        
        // Filter the characters based on the search text
        filteredCharacters = charInfo.filter { character in
            return character.name!.lowercased().contains(searchText.lowercased())
        }
        charactersTableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        // Clear the search text and reload the table view with the original data
        searchText = ""
        charactersTableView.reloadData()
        searchBar.resignFirstResponder()
    }
}

