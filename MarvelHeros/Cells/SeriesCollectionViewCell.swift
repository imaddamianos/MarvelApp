//
//  SeriesCollectionViewCell.swift
//  MarvelHeros
//
//  Created by iMad on 29/09/2023.
//

import UIKit

class SeriesCollectionViewCell: UICollectionViewCell {
    
    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
    
    @IBOutlet weak var seriesName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 15
    }

}
