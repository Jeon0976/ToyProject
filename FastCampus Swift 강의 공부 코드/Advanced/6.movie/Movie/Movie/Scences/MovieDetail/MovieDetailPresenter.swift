//
//  MovieDetailPresenter.swift
//  Movie
//
//  Created by 전성훈 on 2023/01/07.
//

import UIKit

protocol MovieDetailProtocol: AnyObject {
    func setViews(with likedMovie: LikedMovie)
    func setRightBarButton(with isLiked: Bool)
}

final class MovieDetailPresenter {
    private weak var viewController: MovieDetailProtocol?
    
    private let userDefaultsManager: UserDefaultsManagerProtocol
    
    private var likedMovie: LikedMovie
    
    
    init(viewController: MovieDetailProtocol,
         likedMovie: LikedMovie,
         userDefaultsManager: UserDefaultsManagerProtocol = UserDefaultsManager()
    ) {
        self.viewController = viewController
        self.likedMovie = likedMovie
        self.userDefaultsManager = userDefaultsManager
    }
    
    func viewDidLoad() {
        viewController?.setViews(with: likedMovie)
        viewController?.setRightBarButton(with: likedMovie.isliked)
    }
    
    func didTapRightBarButtonItem() {
        // bool 값을 반전 시키는 함수 toggle()
        likedMovie.isliked.toggle()
        if likedMovie.isliked {
            userDefaultsManager.addMovies(likedMovie)
        } else {
            userDefaultsManager.removeMoives(likedMovie)
        }
        
        viewController?.setRightBarButton(with: likedMovie.isliked)
    }
}
