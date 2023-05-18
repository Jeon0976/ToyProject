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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
    }
    
    
    @objc func buttonTapped() {
        presenter.buttonTapped()
    }
}

//MARK: Presenter Protocol
extension ViewController: ViewProtocol {
    func attribute() {
        view.backgroundColor = .systemBackground
        
        weatherImage.layer.cornerRadius = 8
        weatherImage.clipsToBounds = true
        
        loadWeatherButton.setImage(UIImage(systemName: "location"), for: .normal)
        loadWeatherButton.setImage(UIImage(systemName: "location.fill"), for: .selected)
        loadWeatherButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        lowTemp.font = .systemFont(ofSize: 16, weight: .medium)
        lowTemp.numberOfLines = 2
        
        maxTemp.font = .systemFont(ofSize: 16, weight: .medium)
        maxTemp.numberOfLines = 2
        
        nowTemp.font = .systemFont(ofSize: 18, weight: .heavy)
        
        location.font = .systemFont(ofSize: 16, weight: .heavy)
        
        tempStackView.axis = .vertical
        tempStackView.distribution = .equalSpacing
        
        
        // Test MockupData
        lowTemp.text = "23\n최저"
        maxTemp.text = "25\n최고"
        nowTemp.text = "24"
        
        let url = URL(string: "https://openweathermap.org/img/wn/10n@4x.png")!
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                return print(error.localizedDescription)
            }
            if let data = data {
                DispatchQueue.main.async { [weak self] in
                    self?.weatherImage.image = UIImage(data: data)
                    print("Test Succeess")
                }
            }
        }.resume()
        
        location.text = "부천시"
    }
    
    func layout() {
        view.backgroundColor = .systemGray
        [
            lowTemp,
            nowTemp,
            maxTemp
        ].forEach { tempStackView.addArrangedSubview($0) }
        
        [
            weatherImage,
//            loadWeatherButton,
//            tempStackView,
//            location
        ].forEach { view.addSubview($0) }
        
        lowTemp.translatesAutoresizingMaskIntoConstraints = false
        nowTemp.translatesAutoresizingMaskIntoConstraints = false
        maxTemp.translatesAutoresizingMaskIntoConstraints = false
        
        weatherImage.translatesAutoresizingMaskIntoConstraints = false
        loadWeatherButton.translatesAutoresizingMaskIntoConstraints = false
        tempStackView.translatesAutoresizingMaskIntoConstraints = false
        location.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            weatherImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            weatherImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            weatherImage.heightAnchor.constraint(equalToConstant: 200),
            weatherImage.widthAnchor.constraint(equalTo: weatherImage.heightAnchor)
        ])
    }
}
