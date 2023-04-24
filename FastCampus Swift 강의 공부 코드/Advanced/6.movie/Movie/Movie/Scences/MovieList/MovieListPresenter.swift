//
//  MovieListPresenter.swift
//  Movie
//
//  Created by 전성훈 on 2023/01/04.
//

import UIKit

protocol MovieListProtocol: AnyObject {
    func setUpNavigationBar()
    func setUpSearchBar()
    func setUpViews()
    func updateSearchTableView(isHidden: Bool)
    func pushToMovieDetailViewController(with likedMovie: LikedMovie)
    func updateCollectionView()
}

final class MovieListPresenter: NSObject {
    /// memory leak
    /// 메모리 참조에서 안전을 위해 weak var
    /// 화면에 생성되었다가 사라지는 것이 빈번한 경우에는 weak var, unowned let 사용하면 조금 더 안전함
    private weak var viewController: MovieListProtocol?
    
    private let movieSearchManager: MovieSearchManagerProtocol
    
    private let userDefalutsManager: UserDefaultsManagerProtocol
    
    private var likedMovie: [LikedMovie] = []
    
    private var currentMovieSearchResult: [Movie] = []

    init(viewController: MovieListProtocol,
         movieSearchManager: MovieSearchManagerProtocol = MovieSearchManager(),
         userDefaultsManager: UserDefaultsManagerProtocol = UserDefaultsManager()
    ) {
        self.viewController = viewController
        self.movieSearchManager = movieSearchManager
        self.userDefalutsManager = userDefaultsManager
    }
    
    func viewDidLoad() {
        viewController?.setUpNavigationBar()
        viewController?.setUpSearchBar()
        viewController?.setUpViews()
    }
    
    func viewWillAppear() {
        likedMovie = userDefalutsManager.getMovies()
        viewController?.updateCollectionView()
    }
}

// MARK: UISearchBarDelegate
extension MovieListPresenter: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        viewController?.updateSearchTableView(isHidden: false)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        currentMovieSearchResult = []
        viewController?.updateSearchTableView(isHidden: true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        movieSearchManager.reqeuset(from: searchText) { [weak self] movies in
            self?.currentMovieSearchResult = movies
            self?.viewController?.updateSearchTableView(isHidden: false)
        }
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension MovieListPresenter: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing: CGFloat = 16.0
        let width: CGFloat = (collectionView.frame.width - spacing * 3) / 2
        let height: CGFloat = width + 40
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        let inset: CGFloat = 16.0
        return UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewController?.pushToMovieDetailViewController(with: likedMovie[indexPath.item])
    }
}

// MARK: UICollectionViewDataSource
extension MovieListPresenter: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return likedMovie.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MovieListCollectionViewCell.identifier,
            for: indexPath
        ) as? MovieListCollectionViewCell
        
        
        let likedmovie = likedMovie[indexPath.item]
        cell?.update(likedmovie)
        
        
        return cell ?? UICollectionViewCell()
    }
}

// MARK: UITableVIewDelegate
extension MovieListPresenter: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let title = currentMovieSearchResult[indexPath.row].filteringTitle
        let imageURL = currentMovieSearchResult[indexPath.row].imageURL
        let userRating = currentMovieSearchResult[indexPath.row].userRating
        let director = currentMovieSearchResult[indexPath.row].director
        let actor = currentMovieSearchResult[indexPath.row].actor
        let pubDate = currentMovieSearchResult[indexPath.row].pubDate
        let isLiked = false
        let likedMovie = LikedMovie(
            title: title,
            imageURL: imageURL!,
            userRating: userRating,
            director: director,
            actor: actor,
            pubDate: pubDate,
            isliked: isLiked)
        viewController?.pushToMovieDetailViewController(with: likedMovie)
    }
}

// MARK: UITableViewDataSource
extension MovieListPresenter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentMovieSearchResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = UITableViewCell()
        cell.textLabel?.text = currentMovieSearchResult[indexPath.row].filteringTitle
        
        return cell
    }
    
    
}
