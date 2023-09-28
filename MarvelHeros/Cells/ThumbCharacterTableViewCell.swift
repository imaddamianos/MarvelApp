//
//  ThumbCharacterTableViewCell.swift
//  MarvelHeros
//
//  Created by iMad on 28/09/2023.
//

import UIKit

class ThumbCharacterTableViewCell: UITableViewCell {
    
    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
    
    @IBOutlet weak var charImg: UIImageView!
    @IBOutlet weak var charNameLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Background
        self.backgroundColor = .clear
        
        // Title
        self.charNameLbl.textColor = .black
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
