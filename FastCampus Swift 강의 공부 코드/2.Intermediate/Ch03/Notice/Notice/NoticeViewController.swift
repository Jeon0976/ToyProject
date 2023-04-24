//
//  NoticeViewController.swift
//  Notice
//
//  Created by 전성훈 on 2022/09/01.
//

import UIKit

class NoticeViewController: UIViewController {
    // 원격 구성을 기본 뷰 컨트롤러에서 받아올 예정 -> notice viewcontroller를 표시할지 안 할지도 원격으로 받아올예정이기 때문
    // 튜플 생성
    var noticeContents: (title:String,detail:String,date:String)?
    
    @IBOutlet weak var noticeView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        noticeView.layer.cornerRadius = 6
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        guard let noticeContents = noticeContents else {
            return
        }
        
        titleLabel.text = noticeContents.title
        detailLabel.text = noticeContents.detail
        dateLabel.text = noticeContents.date
    }
    @IBAction func doneButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true,completion: nil)
    }
    
}
