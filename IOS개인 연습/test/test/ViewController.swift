
import UIKit

class ViewController: UIViewController {
    
    var test = [CommentArray(commentId: "테스트데데데데데데데데데데데데", userId: "테스트테스트테스트", content: """
테스트입니다테스트입니다테스트입니다테스트입
니다테스트입니다테스트입니다테스트입
니다테스트입니다테스트입니다
테스트입니다테스트입니다테스트입니다테스트입니다테스트입니다테스트입니다
테스트입니다테스트입니다테스트입니다테스트입니다테스
트입니다테스트입니다테스트입니다테스트입니다테스트입니다
""", createdTime: "22.02.12"),
                CommentArray(commentId: "test", userId: "테스트", content: """
가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마
바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바
사아자
차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하가나다라마바사
아자차카타파하가나다라마바사아자차카타파하가나다라마바사아자차
카타파하가나다라마바사아자차카타파하가나다라마바사아자차카타파하
""", createdTime: "22.02.12"),
                CommentArray(commentId: "테스트", userId: "테스트", content: "테스트입니다.", createdTime: "22.02.12"),
                CommentArray(commentId: "테스트", userId: "테스트", content: "테스트입니다.", createdTime: "22.02.12"),
                CommentArray(commentId: "테스트", userId: "테스트", content: "테스트입니다.", createdTime: "22.02.12"),
                CommentArray(commentId: "테스트", userId: "테스트", content: "테스트입니다.", createdTime: "22.02.12"),
                CommentArray(commentId: "테스트", userId: "테스트", content: "테스트입니다.", createdTime: "22.02.12"),
                CommentArray(commentId: "테스트", userId: "테스트", content: "테스트입니다.", createdTime: "22.02.12"),
                CommentArray(commentId: "테스트", userId: "테스트", content: "테스트입니다.", createdTime: "22.02.12")
    ]
    
    private lazy var reviewsTableView: UITableView = {
        let tableView = UITableView()
        
        tableView.register(
            PlaceReviewTableViewCell.self,
            forCellReuseIdentifier: PlaceReviewTableViewCell.identifier
        )
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isScrollEnabled = true
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableView.automaticDimension
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(reviewsTableView)
        reviewsTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            reviewsTableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 16),
            reviewsTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            reviewsTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            reviewsTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -16)
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
//        reviewsTableView.reloadData()
//        reviewsTableView.layoutIfNeeded()
    }
}


extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        test.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PlaceReviewTableViewCell.identifier, for: indexPath) as? PlaceReviewTableViewCell
        
        let comment = test[indexPath.row]
        
        cell?.selectionStyle = .none
        cell?.bindingData(comment)
        
        return cell ?? UITableViewCell()
    }
}

extension ViewController: UITableViewDelegate {

}

final class PlaceReviewTableViewCell: UITableViewCell {
    static let identifier = "PlaceReviewTableViewCell"
    
    private lazy var userId: UILabel = {
        let label = UILabel()
                
        return label
    }()
    
    private lazy var createdTime: UILabel = {
        let label = UILabel()

        
        return label
    }()
    
    private lazy var review: ReviewLabel = {
        let label = ReviewLabel()
        
        return label
    }()
    
    private lazy var topLabelStack: UIStackView = {
        let stackView = UIStackView()
        
        stackView.spacing = 7
        stackView.axis = .horizontal
        stackView.distribution = .fill
        
        return stackView
    }()
    
    private lazy var topStackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.spacing = 15
        stackView.axis = .horizontal
        stackView.distribution = .equalCentering
        
        return stackView
    }()
    
    private lazy var reportButton: UIButton = {
        let button = UIButton()
        
        button.setImage(UIImage(named: "test"), for: .normal)
        
        return button
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
            userId,
            createdTime
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            topLabelStack.addArrangedSubview($0)
        }
        
        [
            topLabelStack,
            reportButton
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            topStackView.addArrangedSubview($0)
        }
        
        [
            topStackView,
            review
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.contentView.addSubview($0)
        }
//        topLabelStack.setContentHuggingPriority(.defaultHigh, for: .horizontal)

        
        NSLayoutConstraint.activate([
            topStackView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 0),
            topStackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            topStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
//            reportButton.topAnchor.constraint(equalTo: topStackView.topAnchor),
//            reportButton.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
//            reportButton.widthAnchor.constraint(equalToConstant: 20),
//            reportButton.heightAnchor.constraint(equalToConstant: 20),
            
            review.topAnchor.constraint(equalTo: topStackView.bottomAnchor, constant: 10),
            review.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            review.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            review.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -15)
        ])
    }
    
    func bindingData(_ comment: CommentArray) {
        userId.text = comment.userId
        createdTime.text = comment.createdTime
        
        review.setLabel(text: comment.content, isAbbreviated: true, isMyReview: false)
    }
}

struct CommentArray: Codable {
    var commentId: String
    var userId: String
    var content: String
    var createdTime: String
}


final class ReviewLabel: UILabel {
    
    private var topInset: CGFloat = 12.0
    private var bottomInset: CGFloat = 12.0
    private var leftInset: CGFloat = 16.0
    private var rightInset: CGFloat = 16.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setAttribute()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }

    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + leftInset + rightInset,
                      height: size.height + topInset + bottomInset)
    }
    
    private func setAttribute() {
        self.font = .systemFont(ofSize: 15, weight: .medium)
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
    }
    
    func setLabel(text: String, isAbbreviated: Bool, isMyReview: Bool) {
        if isMyReview {
            changedReviewColor()
        } else {
            normalColorReview()
        }
        
        if isAbbreviated {
            whenIsAbbreviated(text)
        } else {
            whenShowAllLabel(text)
        }
    }
    
    private func whenIsAbbreviated(_ text: String) {
        self.numberOfLines = 4
        self.text = text
        self.layoutIfNeeded()
        print(self.text)
    }
    
    private func whenShowAllLabel(_ text: String) {
        self.numberOfLines = 0
        self.text = text
    }
    
    private func normalColorReview() {
        self.textColor = .black
        self.backgroundColor = .lightGray
    }
    
    private func changedReviewColor() {
        self.textColor = .blue
        self.backgroundColor = .lightGray
    }
}


extension UILabel {
    func replaceEllipsis(with string: String) {
        guard let text = self.text else { return }
        
        lineBreakMode = .byTruncatingTail
        
        if numberOfLine(for: text) <= self.numberOfLines {
            return
        }
        
        let stringArray = text.components(separatedBy: "\n")
        
        var numberOfLines: Int = 0
        var index: Int = 0

        while !(numberOfLines >= self.numberOfLines) {
            let string = stringArray[index]

            let numberOfLine = numberOfLine(for: string)
            numberOfLines += numberOfLine

            if !(numberOfLines >= self.numberOfLines) { index += 1 }
        }
        
        let last = stringArray[index]

        var result = stringArray[0..<index].joined(separator: "\n") + "\n" + last
        while !(numberOfLine(for: result + string) == self.numberOfLines) {
            result.removeLast()
        }
        
        print(numberOfLines)
        print(index)
        
        result += string
//        print(result)
        self.text = result
//        self.sizeToFit()
    }
    
    fileprivate func numberOfLine(for text: String) -> Int {
        guard let font = self.font, text.count != 0 else { return 0 }
        
        let rect = CGSize(width: self.bounds.width, height: CGFloat.greatestFiniteMagnitude)
        let labelSize = text.boundingRect(with: rect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        let numberOfLine = Int(ceil(CGFloat(labelSize.height) / font.lineHeight ))
        
        return numberOfLine
    }
}
