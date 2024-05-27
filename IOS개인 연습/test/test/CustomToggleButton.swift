//
//  CustomToggleButton.swift
//  test
//
//  Created by 전성훈 on 2024/02/23.
//

import UIKit

final class CustomToggleButton: UIView {
    var isSelected: Bool = false {
        didSet {
            updateLayoutForState()
        }
    }
    
    var buttonColor: UIColor = .white {
        didSet { buttonSwitch.backgroundColor = buttonColor }
    }
    
    var selectedBackgroundColor: UIColor = .blue
    var deselectedBackgroundColor: UIColor = .darkGray

    var animationDuration: TimeInterval = 0.35
    
    var buttonInset: CGFloat = 4 {
        didSet {
            updateConstraintsForSize()
        }
    }
    
    var buttonSwitchSizeRatio: CGFloat = 0.8 {
        didSet {
            updateButtonSwitchSize()
        }
    }
    
    private lazy var title: UILabel = {
        let lbl = UILabel()
        
        lbl.text = "프랜차이즈"
        lbl.numberOfLines = 1
        lbl.textColor = .lightGray
        lbl.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        
        return lbl
    }()
    
    private lazy var buttonSwitch: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 26/2
        view.backgroundColor = .white
        
        return view
    }()
    
    private var switchLeadingConstraint: NSLayoutConstraint?
    private var switchTrailingConstraint: NSLayoutConstraint?
    
    private var titleLeadingConstraint: NSLayoutConstraint?
    private var titleTrailingConstarint: NSLayoutConstraint?
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setupLayout()
        setupAttribute()
        setupTapGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateButtonSwitchSize()
    }
    
    private func setupLayout() {
        [
            title,
            buttonSwitch
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview($0)
        }
        
        switchLeadingConstraint = buttonSwitch.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 4)
        switchLeadingConstraint?.isActive = true
        
        switchTrailingConstraint = buttonSwitch.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -4)
        switchTrailingConstraint?.isActive = false
        
        titleTrailingConstarint = title.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -9)
        titleTrailingConstarint?.isActive = true
        
        titleLeadingConstraint = title.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 9)
        titleLeadingConstraint?.isActive = false
        
        NSLayoutConstraint.activate([
            buttonSwitch.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            buttonSwitch.widthAnchor.constraint(equalToConstant: 26),
            buttonSwitch.heightAnchor.constraint(equalToConstant: 26),
            
            title.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        
        updateButtonSwitchSize()
    }
    
    private func setupAttribute() {
        self.backgroundColor = .darkGray
    }
    
    private func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(toggle))
        self.addGestureRecognizer(tapGesture)
    }
    
    @objc private func toggle() {
        isSelected.toggle()
    }
    
    private func updateConstraintsForSize() {
        switchLeadingConstraint?.constant = buttonInset
        switchTrailingConstraint?.constant = -buttonInset
        titleLeadingConstraint?.constant = buttonInset
        titleTrailingConstarint?.constant = -buttonInset
    }
    
    private func updateButtonSwitchSize() {
           // buttonSwitch의 크기를 CustomToggleButton의 높이에 대한 비율로 조정
           let switchSize = self.bounds.height * buttonSwitchSizeRatio
           buttonSwitch.layer.cornerRadius = switchSize / 2
           NSLayoutConstraint.activate([
               buttonSwitch.widthAnchor.constraint(equalToConstant: switchSize),
               buttonSwitch.heightAnchor.constraint(equalToConstant: switchSize)
           ])
       }
 
    private func updateLayoutForState() {
        UIView.animate(withDuration: 0.35) {
            if self.isSelected {
                self.switchLeadingConstraint?.isActive = false
  
                self.switchTrailingConstraint?.isActive = true

                self.titleTrailingConstarint?.isActive = false
                self.titleLeadingConstraint?.isActive = true
                
                self.title.textColor = .white
                self.backgroundColor = .blue
                
            } else {
                self.switchTrailingConstraint?.isActive = false
                self.switchLeadingConstraint?.isActive = true

                self.titleLeadingConstraint?.isActive = false
                self.titleTrailingConstarint?.isActive = true
                
                self.title.textColor = .lightGray
                self.backgroundColor = .darkGray
            }
            self.layoutIfNeeded()
        }
    }
}
