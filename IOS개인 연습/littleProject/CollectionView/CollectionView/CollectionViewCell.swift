//
//  CollectionViewCell.swift
//  CollectionView
//
//  Created by 전성훈 on 2023/05/16.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    static let identifier = "Cell"
    
    var textLabel = UILabel()
    
    func makeCell(_ label: String) {
        layoutCell()
        
        textLabel.text = label
        textLabel.textAlignment = .center
    }
    
    private func layoutCell() {
        contentView.addSubview(textLabel)
        contentView.backgroundColor = .darkGray
        contentView.layer.cornerRadius = 8
        
        
        textLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            textLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            textLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            textLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            textLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
}
