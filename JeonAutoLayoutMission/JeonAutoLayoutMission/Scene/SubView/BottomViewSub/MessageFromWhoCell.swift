//
//  MessageFromWhoCell.swift
//  JeonAutoLayoutMission
//
//  Created by 전성훈 on 2023/08/02.
//

import UIKit

enum MessageFromWhoSection {
    case main
}

final class MessageFromWhoCell: UITableViewCell {
    static let identifier = "MessageFromWhoCell"
    
    private lazy var icon: UIImageView = {
        let imageView = UIImageView()
        
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private var messageLabel: UILabel = {
       let label = UILabel()
        
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textColor = UIColor(named: "Color2")

        return label
    }()
    
    private var timeLabel: UILabel = {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 10, weight: .medium)
        label.textColor = .gray
        label.textAlignment = .right
        
        return label
    }()
    
    private var mainView: UIView = {
        let view = UIView()
        
        view.backgroundColor = UIColor(named: "Color1")
        view.layer.cornerRadius = 21
        
        return view
    }()
    
    private var bottomView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .clear
        
        return view
    }()
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        makeLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func makeLayout() {        
        [
            icon,
            messageLabel,
            timeLabel
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            mainView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            // icon
            icon.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 16),
            icon.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 8),
            icon.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -8),
            icon.widthAnchor.constraint(equalToConstant: 26),
            icon.heightAnchor.constraint(equalTo: icon.widthAnchor, multiplier: 1),
            
            // messageLabel
            messageLabel.leadingAnchor.constraint(equalTo: icon.trailingAnchor, constant: 16),
            messageLabel.topAnchor.constraint(equalTo: icon.topAnchor),
            messageLabel.bottomAnchor.constraint(equalTo: icon.bottomAnchor),
            
            // timeLabel
            timeLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -16),
            timeLabel.topAnchor.constraint(equalTo: icon.topAnchor),
            timeLabel.bottomAnchor.constraint(equalTo: icon.bottomAnchor)
        ])
        
        [
            mainView,
            bottomView
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            // main view
            mainView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            mainView.topAnchor.constraint(equalTo: contentView.topAnchor),
            
            // bottomview
            bottomView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            bottomView.topAnchor.constraint(equalTo: mainView.bottomAnchor),
            bottomView.widthAnchor.constraint(equalToConstant: 10)
        ])
    }
    
    func makeCellData(_ messageFromWhoModel: MessageFromWho) {
        self.icon.image = messageFromWhoModel.userIcon
        
        let message = "\(messageFromWhoModel.from)님의 메시지가 있습니다."
        self.messageLabel.text = message
        
        self.timeLabel.text = messageFromWhoModel.beforeTime
    }
}
