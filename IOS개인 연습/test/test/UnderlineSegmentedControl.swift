//
//  UnderlineSegmentedControl.swift
//  test
//
//  Created by 전성훈 on 2023/08/10.
//

import UIKit

final class UnderlineSegmentedControl: UISegmentedControl {

    private lazy var highlightlineView: UIView = {
      let width = self.bounds.size.width / CGFloat(self.numberOfSegments)
      let height = 2.0
      let xPosition = CGFloat(self.selectedSegmentIndex * Int(width))
      let yPosition = self.bounds.size.height - height
      let frame = CGRect(x: xPosition, y: yPosition, width: width, height: height)
      let view = UIView(frame: frame)
      view.backgroundColor = .black
      self.addSubview(view)
      return view
    }()
    
    private lazy var underlineView: UIView = {
        let width = self.bounds.size.width
        let height = 1.0
        let yPosition = self.bounds.size.height - height

        let frame = CGRect(x: 0, y: yPosition, width: width, height: height)
        
        let view = UIView(frame: frame)
        view.backgroundColor = .darkGray
        self.addSubview(view)
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
      
        removeBackgroundAndDivider()
    }
    
    override init(items: [Any]?) {
        super.init(items: items)
        removeBackgroundAndDivider()
        
        setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.gray], for: .normal)
        setTitleTextAttributes(
            [
                NSAttributedString.Key.foregroundColor: UIColor.green,
                .font: UIFont.systemFont(ofSize: 13, weight: .semibold)
            ],
            for: .selected)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.underlineView.frame.origin.x = 0
                
        let highlightlineFinalXPosition = (self.bounds.width / CGFloat(self.numberOfSegments)) * CGFloat(self.selectedSegmentIndex)
        
        UIView.animate(withDuration: 0.2) {
                self.highlightlineView.frame.origin.x = highlightlineFinalXPosition
            }
    }
    
    private func removeBackgroundAndDivider() {
        let image = UIImage()
        self.setBackgroundImage(image, for: .normal, barMetrics: .default)
        self.setBackgroundImage(image, for: .selected, barMetrics: .default)
        self.setBackgroundImage(image, for: .highlighted, barMetrics: .default)
        
        self.setDividerImage(image, forLeftSegmentState: .selected, rightSegmentState: .normal, barMetrics: .default)
    }
}
