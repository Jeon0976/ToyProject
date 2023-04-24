//
//  beerListCell.swift
//  Brewery
//
//  Created by 전성훈 on 2022/09/05.
//

import UIKit
import SnapKit
import Kingfisher

class BeerListCell : UITableViewCell {
    let beerImageView = UIImageView()
    let nameLabel = UILabel()
    let taglineLabel = UILabel()
    let numberLabel = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        [beerImageView, nameLabel, taglineLabel, numberLabel].forEach {
            contentView.addSubview($0)
        }
        
        beerImageView.contentMode = .scaleAspectFit
        
        nameLabel.font = .systemFont(ofSize: 18, weight : .bold)
        nameLabel.numberOfLines = 0
        
        taglineLabel.font = .systemFont(ofSize: 14, weight: .light)
        taglineLabel.textColor = .systemBlue
        taglineLabel.numberOfLines = 0
        
        numberLabel.font = .systemFont(ofSize: 18, weight: .bold)
        
        beerImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.top.bottom.equalToSuperview().inset(20)
            $0.width.equalTo(80)
            $0.height.equalTo(120)
        }
        
        nameLabel.snp.makeConstraints {
            $0.leading.equalTo(beerImageView.snp.trailing).offset(5)
            $0.bottom.equalTo(beerImageView.snp.centerY)
            $0.trailing.equalToSuperview().inset(20)
        }
        
        taglineLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(nameLabel)
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
        }
        
        numberLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(nameLabel)
            make.bottom.equalTo(nameLabel.snp.top).offset(0)
        }
    }
    
    func configure(with beer: Beer) {
        let imageURL = URL(string: beer.imageURL ?? "")
        
        // URL 유효하지 않거나 실패 시 기본이미지 -> placeholder
        beerImageView.kf.setImage(with: imageURL, placeholder: #imageLiteral(resourceName: "beer_icon"))
        nameLabel.text = beer.name ?? "이름 없는 맥주"
        taglineLabel.text = beer.tagLine
        numberLabel.text = String(beer.id ?? 0)
        
        // 셀 우측에 꺽세 모양 자동 추가
        accessoryType = .disclosureIndicator
        selectionStyle = .none
    }
}
