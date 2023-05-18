//
//  ViewController.swift
//  ScrollView
//
//  Created by 전성훈 on 2023/05/15.
//

import UIKit

protocol ViewControllerProtocol: NSObject {
    func imageViewBinding(_ image: UIImage)
}

class ViewController: UIViewController {
    lazy var presenter = ViewPresenter(viewController: self)
    
    
    var imageView = UIImageView()
    var scrollView = UIScrollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        presenter.viewDidLoad()
        
        attribute()
        layout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter.viewDidLoad()
    }
    
    private func attribute() {
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        
        scrollView.maximumZoomScale = 5.0
        scrollView.minimumZoomScale = 1.0
        scrollView.delegate = self
    }
    
    private func layout() {
        [
            scrollView,
            imageView
        ].forEach { view.addSubview($0)}
        
        
        scrollView.addSubview(imageView)
        scrollView.contentSize = imageView.bounds.size
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
            imageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            imageView.widthAnchor.constraint(equalToConstant: 200),
        ])
    }
}

extension ViewController: ViewControllerProtocol {
    func imageViewBinding(_ image: UIImage) {
        self.imageView.image = image
    }
}

extension ViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
}



class ViewPresenter {
    weak var viewController: ViewControllerProtocol?
    var model: ImageProtocol
    
    init(viewController: ViewControllerProtocol,
         model: ImageProtocol = ImageModelClass()
    ) {
        self.viewController = viewController
        self.model = model
    }
    
    func viewDidLoad() {
        model.fetchUsers { [weak self] image in
            DispatchQueue.main.async {
                self?.viewController?.imageViewBinding(image.image)
            }
        }
    }
}


struct ImageModel {
    var image: UIImage
}


protocol ImageProtocol {
    func fetchUsers(completion: @escaping (ImageModel) -> Void)
}

class ImageModelClass: ImageProtocol {
    
    var url = URL(string: "https://dcf.wisconsin.gov/files/images/400/blue-policy-icon.png")
    
    func fetchUsers(completion: @escaping (ImageModel) -> Void) {
        var imageModel: ImageModel?
        URLSession.shared.dataTask(with: URLRequest(url: url!)) { data, response, error in
            guard let data = data else {
                print(error!)
                return
            }
            let image = UIImage(data: data)
            imageModel = ImageModel(image: image!)
            completion(imageModel!)
        }.resume()
    }
}
