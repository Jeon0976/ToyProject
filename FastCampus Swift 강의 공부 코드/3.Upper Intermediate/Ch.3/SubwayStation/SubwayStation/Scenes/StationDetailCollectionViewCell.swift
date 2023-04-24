//
//  StationDetailCollectionViewCell.swift
//  SubwayStation
//
//  Created by 전성훈 on 2022/09/13.
//

import UIKit
import SnapKit

final class StationDetailCollectionViewCell : UICollectionViewCell {
    private lazy var lineLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15.0, weight: .bold)
        
        return label
    }()
    
    private lazy var remainTimeLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15.0, weight: .medium)
        
        return label
    }()

    
    func setUp(with realTimeArrival : StationArrivalDataResponseModel.RealitimeArrival) {
        layer.cornerRadius = 12.0
        layer.shadowColor = UIColor.systemGray4.cgColor
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 10.0
        
        backgroundColor = .systemGray
        
        [lineLabel,remainTimeLabel].forEach { addSubview($0) }

        lineLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16.0)
            make.top.equalToSuperview().inset(16.0)
        }
        remainTimeLabel.snp.makeConstraints { make in
            make.leading.equalTo(lineLabel)
            make.top.equalTo(lineLabel.snp.bottom).offset(16.0)
            make.bottom.equalToSuperview().inset(16.0)
        }
        
        lineLabel.text = realTimeArrival.line
        remainTimeLabel.text = realTimeArrival.remainTime
    }
    
}
