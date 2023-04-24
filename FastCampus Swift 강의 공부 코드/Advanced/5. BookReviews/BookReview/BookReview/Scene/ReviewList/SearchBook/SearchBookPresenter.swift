//
//  SearchBookPresenter.swift
//  BookReview
//
//  Created by 전성훈 on 2022/12/21.
//

import UIKit

protocol SearchBookProtocol {
    func setUpViews()
    func dismiss()
    func reloadView()
}

protocol SearchBookDelegate {
    func selectedBook(_ book: Book)
}

final class SearchBookPresenter: NSObject {
    private let viewController: SearchBookProtocol
    private let bookSearchManager = BookSearchManager()
    
    private let delegate: SearchBookDelegate
    
    private var books: [Book] = []
    
    init(viewController: SearchBookProtocol,
         delegate: SearchBookDelegate
    ) {
        self.viewController = viewController
        self.delegate = delegate
    }
    
    func viewDidLoad() {
        viewController.setUpViews()
    }
    
}

extension SearchBookPresenter: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else {return}
        
        bookSearchManager.request(from: searchText) { [weak self] newBooks in
            self?.books = newBooks
            self?.viewController.reloadView()
        }
    }
}

extension SearchBookPresenter: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedBook = books[indexPath.row]
        delegate.selectedBook(selectedBook)
        
        viewController.dismiss()
    }
}

extension SearchBookPresenter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        books.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = books[indexPath.row].title
        
        return cell
    }

}
