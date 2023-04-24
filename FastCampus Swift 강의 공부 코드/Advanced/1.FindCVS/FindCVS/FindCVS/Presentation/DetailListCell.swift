//
//  DetailListCell.swift
//  FindCVS
//
//  Created by 전성훈 on 2022/11/14.
//

import UIKit

class DetailListCell: UITableViewCell {
    let placeNameLabel = UILabel()
    let addressLabel = UILabel()
    let distanceLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        attribute()
        layout()
    }
    
    func setData(_ data: DetailListCellData) {
        placeNameLabel.text = data.placeName
        addressLabel.text = data.address
        distanceLabel.text = data.distance
    }
    
    private func attribute() {
        backgroundColor = .systemBackground
        placeNameLabel.font = .systemFont(ofSize: 16, weight: .bold)
        
        addressLabel.font = .systemFont(ofSize: 14)
        addressLabel.textColor = .gray
        
        distanceLabel.font = .systemFont(ofSize: 12, weight: .light)
        distanceLabel.textColor = .darkGray
    }
    
    private func layout() {
        [placeNameLabel, addressLabel, distanceLabel].forEach {
            contentView.addSubview($0)
        }
        
        placeNameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(12)
            $0.leading.equalToSuperview().offset(12)
        }
        
        addressLabel.snp.makeConstraints {
            $0.top.equalTo(placeNameLabel.snp.bottom).offset(3)
            $0.leading.equalTo(placeNameLabel)
            $0.bottom.equalToSuperview().inset(12)
        }
        
        distanceLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(20)
        }
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
