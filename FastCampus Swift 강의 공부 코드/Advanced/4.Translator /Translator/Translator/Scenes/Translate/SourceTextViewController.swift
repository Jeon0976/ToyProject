//
//  SourceTextViewController.swift
//  Translator
//
//  Created by 전성훈 on 2022/12/13.
//

import UIKit
import SnapKit

protocol SourceTextViewControllerDelegate:AnyObject {
    func didEnterText(_ sourceText: String)
}

final class SourceTextViewController : UIViewController {
    private let placeholderText = NSLocalizedString("Enter_Text", comment: "텍스트 입력")
    
    private weak var delegate: SourceTextViewControllerDelegate?
    
    private lazy var textView: UITextView = {
       let textView = UITextView()
    
        textView.text = placeholderText
        textView.textColor = .secondaryLabel
        textView.font = .systemFont(ofSize: 18.0, weight: .semibold)
        textView.returnKeyType = .done
        textView.delegate = self
        
        
        return textView
    }()
    
    init(delegate: SourceTextViewControllerDelegate?) {
        self.delegate = delegate
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        setUp()
    }
}

private extension SourceTextViewController {
    func setUp() {
        [textView].forEach { view.addSubview($0) }
        
        textView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(16.0)
        }
    }
    
}

extension SourceTextViewController:UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        guard textView.textColor == .secondaryLabel else {return}
        
        textView.text = nil
        textView.textColor = .label
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        guard text == "\n" else {return true}
        
        delegate?.didEnterText(textView.text)
        
        dismiss(animated: true)
        
        // 키보드만 닫음
        // textView.resignFirstResponder()
        return true
    }
}
