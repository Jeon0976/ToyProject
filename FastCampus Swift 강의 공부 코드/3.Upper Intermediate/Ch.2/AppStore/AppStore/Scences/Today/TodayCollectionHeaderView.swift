//
//  TodayCollectionHeaderView.swift
//  AppStore
//
//  Created by 전성훈 on 2022/09/09.
//

import UIKit
import SnapKit

final class TodayCollectionHeaderView: UICollectionReusableView {
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        // 현재시간
        let dateToString : DateFormatter = {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM월 dd일 EEEE"
            dateFormatter.locale = Locale(identifier: "ko_KR")
            return dateFormatter
        }()
        let nowDateString = dateToString.string(from: Date())
//        label.text = "9월9일 금요일"
        label.text = nowDateString
        label.font = .systemFont(ofSize: 14.0, weight: .semibold)
        label.textColor = .secondaryLabel
        
        return label
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "투데이"
        label.font = .systemFont(ofSize: 36.0, weight: .black)
        label.textColor = .label
        
        return label
    }()
    
    func setupViews() {
        [dateLabel, titleLabel].forEach { addSubview($0)}
        
        dateLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(18)
            make.trailing.equalToSuperview()
            make.top.equalToSuperview().inset(32)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(dateLabel)
            make.top.equalTo(dateLabel.snp.bottom).offset(8.0)            
        }
    }
}
