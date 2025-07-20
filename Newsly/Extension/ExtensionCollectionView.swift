//
//  ExtensionCollectionView.swift
//  Newsly
//
//  Created by 0ofKim on 7/20/25.
//
import UIKit

extension UICollectionView {
    func registerCell(cell: UICollectionViewCell.Type) {
        let identifier = String(describing: cell)
        let nib = UINib(nibName: identifier, bundle: nil)
        self.register(nib, forCellWithReuseIdentifier: identifier)
    }
}
