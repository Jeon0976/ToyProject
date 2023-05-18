//
//  ViewController.swift
//  MyWeather
//
//  Created by 전성훈 on 2023/05/18.
//

// baf0548634d00b30b393182fbbf46c53
import UIKit
import CoreLocation

class ViewController: UIViewController {
    lazy var presenter = ViewPresenter(viewController: self)
    
    var weatherImage = UIImageView()
    var loadWeatherButton = UIButton()
    var lowTemp = UILabel()
    var nowTemp = UILabel()
    var maxTemp = UILabel()
    var location = UILabel()
    
    var tempStackView = UIStackView()
    
    var activity = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
        presenter.locationAuthorizaion()
    }
    
    // MARK: Button 탭!
    @objc func buttonTapped() {
        weatherImage.isHidden = true
        tempStackView.isHidden = true
        location.isHidden = true
        
        activity.isHidden = false
        activity.startAnimating()
        presenter.locationUpdate { [weak self] in
            self?.presenter.buttonTapped()
        }
        
    }
    
}

//MARK: Presenter Protocol
extension ViewController: ViewProtocol {
    // MARK: Attribute
    func attribute() {
        view.backgroundColor = .systemBackground
        
        weatherImage.layer.cornerRadius = 8
        weatherImage.clipsToBounds = true
                
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 18, weight: .heavy)
        
        loadWeatherButton.setImage(UIImage(systemName: "location",withConfiguration: imageConfig), for: .normal)
        loadWeatherButton.setImage(UIImage(systemName: "location.fill",withConfiguration: imageConfig), for: .highlighted)
        loadWeatherButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        loadWeatherButton.tintColor = .black
        
        lowTemp.font = .systemFont(ofSize: 16, weight: .medium)
        lowTemp.numberOfLines = 2
        
        maxTemp.font = .systemFont(ofSize: 16, weight: .medium)
        maxTemp.numberOfLines = 2
        
        nowTemp.font = .systemFont(ofSize: 18, weight: .heavy)
        
        location.font = .systemFont(ofSize: 16, weight: .heavy)
        
        tempStackView.axis = .horizontal
        tempStackView.distribution = .equalSpacing

    }
    
    // MARK: Layout
    func layout() {
        view.backgroundColor = .systemGray
        [
            lowTemp,
            nowTemp,
            maxTemp
        ].forEach { tempStackView.addArrangedSubview($0) }
        
        [
            weatherImage,
            activity,
            loadWeatherButton,
            tempStackView,
            location
        ].forEach { view.addSubview($0) }
                
        weatherImage.translatesAutoresizingMaskIntoConstraints = false
        loadWeatherButton.translatesAutoresizingMaskIntoConstraints = false
        tempStackView.translatesAutoresizingMaskIntoConstraints = false
        location.translatesAutoresizingMaskIntoConstraints = false
        activity.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            weatherImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            weatherImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            weatherImage.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/5),
            weatherImage.widthAnchor.constraint(equalTo: weatherImage.heightAnchor),
            location.topAnchor.constraint(equalTo: weatherImage.bottomAnchor, constant: 16),
            location.centerXAnchor.constraint(equalTo: weatherImage.centerXAnchor),
            tempStackView.topAnchor.constraint(equalTo: location.bottomAnchor, constant: 16),
            tempStackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1/2),
            tempStackView.centerXAnchor.constraint(equalTo: location.centerXAnchor),
            loadWeatherButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            loadWeatherButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activity.centerXAnchor.constraint(equalTo: weatherImage.centerXAnchor),
            activity.centerYAnchor.constraint(equalTo: weatherImage.centerYAnchor)
        ])
    }
    
    //MARK: Hidden 함수
    func reverseHidden() {
        weatherImage.isHidden = false
        tempStackView.isHidden = false
        location.isHidden = false
        activity.isHidden = true
        activity.stopAnimating()
    }
    
    //MARK: UpdateUI 함수
    func updateUI(_ weather: Weather, _ image: UIImage) {
        lowTemp.text = weather.lowTemp
        maxTemp.text = weather.maxTemp
        nowTemp.text = weather.nowTemp
        location.text = weather.location
        weatherImage.image = image
    }
}
