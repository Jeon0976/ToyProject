//
//  TranslateViewController.swift
//  Translator
//
//  Created by 전성훈 on 2022/12/12.
//

import UIKit
import SnapKit

final class TranslateViewController: UIViewController {
    private var translateManager = TranslatorManager()
    
    
    private lazy var sourceLanguageButton: UIButton = {
        let button = UIButton()
        button.setTitle(translateManager.sourceLanguage.title, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15.0, weight: .semibold)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .systemBackground
        button.layer.cornerRadius = 9.0
        button.addTarget(self, action: #selector(didTapSourceLanguageButton), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var targetLanguageButton: UIButton = {
        let button = UIButton()
        button.setTitle(translateManager.targetLanguage.title, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15.0, weight: .semibold)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .systemBackground
        button.layer.cornerRadius = 9.0
        button.addTarget(self, action: #selector(didTapTargetLanguageButton), for: .touchUpInside)

        return button
    }()
        
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.spacing = 8.0
        
        [sourceLanguageButton,targetLanguageButton].forEach { stackView.addArrangedSubview($0) }
        
        return stackView
    }()
    private lazy var resultBaseView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        
        return view
    }()
    
    private lazy var resultLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 23.0, weight: .bold)
        label.textColor = UIColor.mainTintColor
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var bookmarkButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "bookmark"), for: .normal)
        button.addTarget(self, action: #selector(didTapBookmarkButton), for: .touchUpInside)
        
        return button
    }()


    private lazy var copyButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "doc.on.doc"), for: .normal)
        button.addTarget(self, action: #selector(didTapCopyButton), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var sourceLabelBaseButton: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        
        let tapGesture = UITapGestureRecognizer(target: self,
                                             action: #selector(didTapSourceLabelBaseButton))
        
        
        view.addGestureRecognizer(tapGesture)
        
        return view
    }()
   
    
    private lazy var sourceLabel: UILabel = {
       let label = UILabel()
        label.text = NSLocalizedString("Enter_Text", comment: "텍스트입력")
        // 옅은 회색
        label.textColor = .tertiaryLabel
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 23.0, weight: .semibold)
        
        return label
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .secondarySystemBackground
        setupViews()
        
    }
}
// MARK: SourceTextViewControllerDelegate
extension TranslateViewController: SourceTextViewControllerDelegate {
    func didEnterText(_ sourceText: String) {
        if sourceText.isEmpty { return }
        
        sourceLabel.text = sourceText
        sourceLabel.textColor = .label
        
        translateManager.translate(from: sourceText) { [weak self] translatedText in
            self?.resultLabel.text = translatedText
        }
        bookmarkButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
    }
}

private extension TranslateViewController {
    // MARK: setupViews
    func setupViews() {
        [
            buttonStackView,
            resultBaseView,
            resultLabel,
            bookmarkButton,
            copyButton,
            sourceLabelBaseButton,
            sourceLabel
        ]
            .forEach { view.addSubview($0) }
        
        let defaultSpacing: CGFloat = 16.0
        
        buttonStackView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(defaultSpacing)
            $0.leading.equalToSuperview().inset(defaultSpacing)
            $0.trailing.equalToSuperview().inset(defaultSpacing)
            $0.height.equalTo(50)
        }
        
        resultBaseView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.top.equalTo(buttonStackView.snp.bottom).offset(defaultSpacing)
            $0.bottom.equalTo(bookmarkButton.snp.bottom).offset(defaultSpacing)
        }
        
        resultLabel.snp.makeConstraints {
            $0.leading.equalTo(resultBaseView.snp.leading).inset(24.0)
            $0.trailing.equalTo(resultBaseView.snp.trailing).inset(24.0)
            $0.top.equalTo(resultBaseView.snp.top).inset(24.0)
        }
        
        bookmarkButton.snp.makeConstraints {
            $0.leading.equalTo(resultLabel.snp.leading)
            $0.top.equalTo(resultLabel.snp.bottom).offset(24.0)
            $0.width.equalTo(40.0)
            $0.height.equalTo(40.0)
        }
        
        copyButton.snp.makeConstraints {
            $0.leading.equalTo(bookmarkButton.snp.trailing).inset(8.0)
            $0.top.equalTo(bookmarkButton.snp.top)
            $0.width.equalTo(40.0)
            $0.height.equalTo(40.0)
        }
        
        sourceLabelBaseButton.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.top.equalTo(resultBaseView.snp.bottom).offset(defaultSpacing)
            $0.bottom.equalToSuperview().inset(tabBarController?.tabBar.frame.height ?? 0.0)
        }

        sourceLabel.snp.makeConstraints {
            $0.leading.equalTo(sourceLabelBaseButton.snp.leading).inset(24.0)
            $0.top.equalTo(sourceLabelBaseButton.snp.top).inset(24.0)
            $0.trailing.equalTo(sourceLabelBaseButton.snp.trailing).inset(24.0)
        }
    }
    
    // MARK: didTapBookmarkButton
    @objc func didTapBookmarkButton() {
        guard let sourceText = sourceLabel.text,
              let translatedText = resultLabel.text,
              bookmarkButton.imageView?.image == UIImage(systemName: "bookmark") // bookmark.fill == 북마크가 된 상태
        else {return}
        
        bookmarkButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)

        let currentBookmarks: [Bookmark] = UserDefaults.standard.bookmarks
        let newBookmark = Bookmark(sourceLanguage: translateManager.sourceLanguage,
                                   translatedLanguage: translateManager.targetLanguage,
                                   soruceText: sourceText,
                                   translatedText: translatedText)
        // 최신 정보가 맨 위로 올라가야 하기 때문 [newbookmark]가 앞으로
        UserDefaults.standard.bookmarks = [newBookmark] + currentBookmarks
        
        print(UserDefaults.standard.bookmarks)
    }

    // TODO: 북마크 해제 기능 구현
    // MARK: didTapCopyButton
    @objc func didTapCopyButton() {
        UIPasteboard.general.string = resultLabel.text
    }
    
    @objc func didTapSourceLabelBaseButton() {
        let viewController = SourceTextViewController(delegate: self)
        
        present(viewController, animated: true)
    }
    
    @objc func didTapSourceLanguageButton() {
        didTapLanguageButton(type: .source)
    }
    @objc func didTapTargetLanguageButton() {
        didTapLanguageButton(type: .target)
    }
    
    // enum은 objectiveC 시절에는 없었고 swift 시절에 등장해서 @objc사용시 에러 발생
    // 기존 아래 함수는 @objc형태였지만 위의 함수를 만듦으로써 아래 함수를 기본함수로 변경해서 사용
    // MARK: didTapLanguageButton
    func didTapLanguageButton(type: Type) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        Language.allCases.forEach { language in
            let action = UIAlertAction(title: language.title, style: .default) { [weak self] _ in
                switch type {
                case .source:
                    self?.translateManager.sourceLanguage = language
                    self?.sourceLanguageButton.setTitle(language.title, for: .normal)
                case .target:
                    self?.translateManager.targetLanguage = language
                    self?.targetLanguageButton.setTitle(language.title, for: .normal)
                    self?.translateManager.translate(from: self?.sourceLabel.text ?? "Error" ) { [weak self] translatedText in
                        self?.resultLabel.text = translatedText
                    }

                }
            }
            alertController.addAction(action)
        }
        
        let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: "취소"), style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        present(alertController,animated: true)
    }

}
