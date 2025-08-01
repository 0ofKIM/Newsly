//
//  NewsCollectionViewCell.swift
//  Newsly
//
//  Created by 0ofKim on 7/19/25.
//

import UIKit

class NewsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(with newsItem: NewsItem) {        
        titleLabel.text = newsItem.title
        contentsLabel.text = newsItem.description
    }
}
