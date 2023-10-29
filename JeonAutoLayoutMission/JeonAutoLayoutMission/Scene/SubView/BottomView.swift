//
//  BottomView.swift
//  JeonAutoLayoutMission
//
//  Created by 전성훈 on 2023/08/01.
//

import UIKit

final class BottomView: UIView {
    private lazy var title: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.numberOfLines = 2
        label.textColor = .black
        
        return label
    }()
    
    private lazy var subTitle: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.numberOfLines = 2
        label.textColor = .darkGray
        
        return label
    }()
    
    private lazy var numberOfParticipants: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .lightGray
        
        return label
    }()
    
    private lazy var labelStackView: UIStackView = {
        let stackView = UIStackView()
       
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .leading
        stackView.distribution = .equalSpacing
        
        return stackView
    }()
    
    private lazy var userImage: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private lazy var starImage: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        
        imageView.image = UIImage(named: "ic_star")
        
        return imageView
    }()
    
    private lazy var messageTableView: UITableView = {
        let tableView = UITableView()
        
        tableView.separatorStyle = .none
        tableView.register(MessageFromWhoCell.self, forCellReuseIdentifier: MessageFromWhoCell.identifier)
        tableView.rowHeight = UITableView.automaticDimension

        return tableView
    }()
        
    var dataSource: UITableViewDiffableDataSource<MessageFromWhoSection, MessageFromWho>!

    var snapshot: NSDiffableDataSourceSnapshot<MessageFromWhoSection, MessageFromWho>!
    
    var messageFromWhoArray: [MessageFromWho]!
    
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
        self.layer.cornerRadius = 12
        self.layer.shadowOpacity = 0.2
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowRadius = 12.5
        
        viewHeightConstraint = self.heightAnchor.constraint(equalToConstant: 150)
        viewHeightConstraint?.isActive = true
        
        [
            title,
            subTitle,
            numberOfParticipants
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            labelStackView.addArrangedSubview($0)
        }
        
        
        [
            labelStackView,
            userImage,
            starImage,
            messageTableView
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            // userImage
            userImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            userImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            userImage.widthAnchor.constraint(equalToConstant: 80),
            userImage.heightAnchor.constraint(equalToConstant: 80),
            
            // labelStackView
            labelStackView.leadingAnchor.constraint(equalTo: userImage.trailingAnchor, constant: 12),
            labelStackView.topAnchor.constraint(equalTo: userImage.topAnchor),
            labelStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            
            // staImage
            starImage.bottomAnchor.constraint(equalTo: userImage.bottomAnchor),
            starImage.trailingAnchor.constraint(equalTo: userImage.trailingAnchor),
            starImage.widthAnchor.constraint(equalToConstant: 20),
            starImage.heightAnchor.constraint(equalToConstant: 20),
            
            // messgaeTableView
            messageTableView.topAnchor.constraint(equalTo: userImage.bottomAnchor, constant: 14),
            messageTableView.leadingAnchor.constraint(equalTo: userImage.leadingAnchor),
            messageTableView.trailingAnchor.constraint(equalTo: labelStackView.trailingAnchor),
            messageTableView.heightAnchor.constraint(equalToConstant: 96)
        ])
        
        starImage.isHidden = true
    }
    
    private func configureViewSize() {
        let userImageViewHeight = userImage.frame.height
        let tableViewHeight = messageTableView.frame.height
        // 18 + 14
        let padding: CGFloat = 32
        
        viewHeightConstraint?.constant = tableViewHeight + userImageViewHeight + padding
    }
    
    func setData(_ bottomModel: BottomModel) {
        self.title.text = bottomModel.title
        self.subTitle.text = bottomModel.subTitle
        
        let activeMembers = bottomModel.numberOfParticipants.split(separator: "/").first
        
        if let activeMembers {
            self.numberOfParticipants.attributedText = bottomModel.numberOfParticipants.changeColor(changedText: String(activeMembers))
        }
        
        self.userImage.image = bottomModel.image
        self.starImage.isHidden = !bottomModel.isStar
        self.messageTableView.isHidden = !bottomModel.isMessagePresent
        self.messageFromWhoArray = bottomModel.messageFromWho
        
        if bottomModel.isMessagePresent {
            makeTableViewCell()
        }
    }
    
    private func makeTableViewCell() {
        dataSource = UITableViewDiffableDataSource<MessageFromWhoSection, MessageFromWho>(tableView: messageTableView, cellProvider: { (tableView, indexPath, identifier) -> UITableViewCell? in

            let cell = tableView.dequeueReusableCell(withIdentifier: MessageFromWhoCell.identifier, for: indexPath) as? MessageFromWhoCell
            
            cell?.makeCellData(identifier)
            cell?.selectionStyle = .none

            return cell
        })

        snapshot = NSDiffableDataSourceSnapshot<MessageFromWhoSection, MessageFromWho>()

        snapshot.appendSections([.main])

        snapshot.appendItems(messageFromWhoArray, toSection: .main)

        dataSource.apply(snapshot)
    }
    
    func updateShapshot(_ items: MessageFromWho) {
        messageFromWhoArray.append(items)
        
        snapshot.deleteAllItems()
        snapshot.appendSections([.main])
        snapshot.appendItems(messageFromWhoArray)
        
        dataSource.apply(snapshot)
    }
}
