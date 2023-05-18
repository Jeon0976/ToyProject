//
//  ViewPresenter.swift
//  MyWeather
//
//  Created by 전성훈 on 2023/05/18.
//

import UIKit

protocol ViewProtocol: NSObject {
    func attribute()
    func layout()
}


final class ViewPresenter {
    weak var viewController: ViewProtocol?
    
    let requestManager = WeatherRequestManager()
    
    
    init(viewController: ViewProtocol) {
        self.viewController = viewController
    }
    
    
    func viewDidLoad() {
        viewController?.attribute()
        viewController?.layout()
    }
    
    func buttonTapped() {
        
    }
}
