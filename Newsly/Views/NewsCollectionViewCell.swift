//
//  NewsCollectionViewCell.swift
//  Newsly
//
//  Created by 0ofKim on 7/19/25.
//

import UIKit

class NewsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(with newsItem: NewsItem) {
        imageView.backgroundColor = .systemGray5
        imageView.image = UIImage(systemName: "newspaper")
        
        titleLabel.text = newsItem.title
        contentsLabel.text = newsItem.description
    }
}
