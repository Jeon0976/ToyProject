//
//  AppViewController.swift
//  AppStore
//
//  Created by 전성훈 on 2022/09/12.
//

import UIKit
import SnapKit

final class AppViewController : UIViewController {
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    
    private lazy var stackView :UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 0.0
        stackView.backgroundColor = .systemBackground
        let featureSectionView = FeatureSectionView(frame: .zero)
        let rankingFeatureSectionView = RankingFeatureSectionView(frame: .zero)
        let excahgeCodeButtonView = ExchangeCodeButtonView(frame: .zero)
        
        
//        featureSectionView.backgroundColor = .gray
//        rankingFeatureSectionView.backgroundColor = .white
//        excahgeCodeButtonView.backgroundColor = .black
        
        let spacingView = UIView()
        spacingView.snp.makeConstraints { make in
            make.height.equalTo(100.0)
        }
        
        [featureSectionView, rankingFeatureSectionView, excahgeCodeButtonView, spacingView].forEach {
            stackView.addArrangedSubview($0)
        }
        
        return stackView
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNav()
        setUpLayout()
    }
    
}

private extension AppViewController {
    func setNav() {
//        let barApperance = UINavigationBarAppearance()

//        self.navigationItem.scrollEdgeAppearance = barApperance
//        self.navigationItem.standardAppearance = barApperance
        navigationItem.title = "앱"
    
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        
    }
    
    func setUpLayout() {
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
//            make.top.equalToSuperview()
            make.bottom.leading.trailing.equalToSuperview()
        }
        
//        scrollView.addSubview(stackView)
//        stackView.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
//            make.width.equalToSuperview()
//        }
        
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }

        contentView.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
