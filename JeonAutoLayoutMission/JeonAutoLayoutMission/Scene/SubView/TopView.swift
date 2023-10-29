//
//  TopView.swift
//  JeonAutoLayoutMission
//
//  Created by 전성훈 on 2023/08/01.
//

import UIKit

final class TopView: UIView {
    lazy var title: UILabel = {
        let label = UILabel()

        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.numberOfLines = 0
        label.textColor = .black
        
        return label
    }()
    
    lazy var subTitle: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.numberOfLines = 0
        label.textColor = .black
        
        return label
    }()
    
    lazy var mainImage: UIImageView = {
        let imageView = UIImageView()

        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    var viewHeightConstraint: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        makeLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        configureViewSize()
    }
    
    private func makeLayout() {
        viewHeightConstraint = self.heightAnchor.constraint(equalToConstant: 0)
        viewHeightConstraint?.isActive = true
        
        [
            title,
            mainImage,
            subTitle
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            // title
            title.topAnchor.constraint(equalTo: self.topAnchor,constant: 10),
            title.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            title.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            // mainImage
            mainImage.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 20),
            mainImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            mainImage.widthAnchor.constraint(equalToConstant: 150),
            mainImage.heightAnchor.constraint(equalToConstant: 150),
            
            // subTitle
            subTitle.topAnchor.constraint(equalTo: mainImage.bottomAnchor, constant: 20),
            subTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            subTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    private func configureViewSize() {
        let titleHeight = title.frame.height
        let subTitleHeight = subTitle.frame.height
        let mainImageHeight = mainImage.frame.height
        // 10 + 20 + 20
        let padding: CGFloat = 50
        
        let viewHeight = titleHeight + subTitleHeight + mainImageHeight + padding
        viewHeightConstraint?.constant = viewHeight
    }
    
    func setData(_ topModel: TopModel) {
        self.title.attributedText = topModel.title.setLineSpacing(5)
        self.subTitle.attributedText = topModel.subTitle.setLineSpacing(5)

        self.mainImage.image = topModel.image
    }
    
}


w
