//
//  TableViewCell.swift
//  PhotoKit
//
//  Created by 전성훈 on 2023/05/15.
//

import UIKit

final class TableViewCell: UITableViewCell {
    static let identifier = "Cell"
    
    var image = UIImageView()
    
    func makeCell(_ image: UIImage) {
        self.image.image = image
        
        makeLayout()
    }
    
    private func makeLayout() {
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        
        contentView.addSubview(image)
        
        image.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 2),
            image.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -2),
            image.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            image.widthAnchor.constraint(equalToConstant: 30),
             image.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
}
