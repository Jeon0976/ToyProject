//
//  RankingFeatureSectionView.swift
//  AppStore
//
//  Created by 전성훈 on 2022/09/12.
//

import UIKit
import SnapKit

final class RankingFeatureSectionView : UIView {
    private var rankingFeatureList : [RankingFeature] = []
    
    private lazy var titleLbel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18.0, weight: .black)
        label.text = "iPone이 처음이라면"
        label.textColor = .label
        return label
    }()
    
    private lazy var showAllAppsButton : UIButton = {
        let button = UIButton()
        button.setTitle("모두 보기", for: .normal)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14.0, weight: .semibold)
        
        return button
    }()
    
    private lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 32.0
        layout.minimumInteritemSpacing = 0.0
        layout.sectionInset = UIEdgeInsets(top: 0.0, left: 16.0, bottom: 0.0, right: 16.0)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = .systemBackground
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.register(RankingFeatureCollectionViewCell.self, forCellWithReuseIdentifier: "RankingFeatureCollectionViewCell")
        
        return collectionView
    }()
    
    private let separatorView = Separator(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        fetchData()
        collectionView.reloadData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RankingFeatureSectionView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return rankingFeatureList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RankingFeatureCollectionViewCell", for: indexPath) as? RankingFeatureCollectionViewCell else { return UICollectionViewCell() }
        
//        cell.backgroundColor = .lightGray
//        cell.layer.borderColor = UIColor.black.cgColor
//        cell.layer.borderWidth = 0.5
                
        let rankingFeature = rankingFeatureList[indexPath.item]
        cell.setup(ranking: rankingFeature)
        
        return cell
    }
    
    
}

extension RankingFeatureSectionView : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width - 32.0, height: RankingFeatureCollectionViewCell.cellHegiht)
    }
}


//MARK: Private method
private extension RankingFeatureSectionView {
    func setupViews() {
        [titleLbel, showAllAppsButton, collectionView, separatorView].forEach { addSubview($0) }
        
        titleLbel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16.0)
            make.top.equalToSuperview().inset(16.0)
            make.trailing.equalTo(showAllAppsButton.snp.leading).offset(8.0)
        }
        
        showAllAppsButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16.0)
            make.top.equalTo(titleLbel.snp.top)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLbel.snp.bottom).offset(16.0)
            make.height.equalTo(RankingFeatureCollectionViewCell.cellHegiht * 3)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        separatorView.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(16.0)
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
    
    func fetchData() {
        guard let url = Bundle.main.url(forResource: "RankingFeature", withExtension: "plist") else {return}
        
        do {
            let data = try Data(contentsOf: url)
            let result = try PropertyListDecoder().decode([RankingFeature].self, from: data)
            rankingFeatureList = result
        } catch {
            print("ERROR : URL Error \(error.localizedDescription)")
        }
    }
}
