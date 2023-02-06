//
//  NewsListPresenter.swift
//  KeywordNews
//
//  Created by 전성훈 on 2023/02/02.
//

import UIKit

protocol NewsListProtocol: AnyObject {
    func setupNavigationBar()
    func setupLayout()
    func endRefreshing()
    func moveToNewsWebViewController(with news: News)
    func moveToTagPlusViewController()
    func reloadTableView()
}

final class NewsListPresenter: NSObject {
    private weak var viewController: NewsListProtocol?
    private let newsSearchManager: NewsSearchManagerProtocol
    private let userDefaultsManager: UserDefaultsManagerProtocol
    
    /// 임의 변수
    private var currentKeyword = ""
    // 지금까지 request 된, 가지고 있는 page가 어디인지 알고 있어야함
    private var currentPage: Int = 0
    // 한 페이지에 최대 몇 개까지 보여줄건지
    private let display: Int = 20
    
    // naver api에서는 컴퓨터 속성과 다르게 인간친화적이여서 1부터 시작함
    // 0 : 0*20 +1 = 1
    // 1 : 1*20 +1 = 2
    
    var tags: [Tags] = UserDefaultsManager().getTags()
    
    private var newsList: [News] = []
    
    init(
        viewController: NewsListProtocol,
        newsSearchManager: NewsSearchManagerProtocol = NewsSearchManager(),
        userDefaultsManager: UserDefaultsManagerProtocol = UserDefaultsManager()
    ) {
        self.viewController = viewController
        self.newsSearchManager = newsSearchManager
        self.userDefaultsManager = userDefaultsManager
    }
    
    func viewDidLoad() {
        viewController?.setupNavigationBar()
        viewController?.setupLayout()
    }
    
    func didCalledRefresh() {
        requestNewsList(isNeededToReset: true)
    }
    
    func didCalledPlus() {
        viewController?.moveToTagPlusViewController()
    }
}

extension NewsListPresenter: NewsListTableViewHeaderViewDelegate {
    func didSelectTag(_ seletedIndex: Int) {

        currentKeyword = tags[seletedIndex].tag

        requestNewsList(isNeededToReset: true)
    }
    
}

extension NewsListPresenter: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let news = newsList[indexPath.row]
        
        viewController?.moveToNewsWebViewController(with: news)
    }
    
    // willDisplay -> display되려고 하면, indexpath의 willDisplay의 method가 불려짐
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let currentRow = indexPath.row
        
        /// 뉴스개수 20개 중 마지막 17번째이면서 마지막 페이지 일때 requestNewsList() 실행
        guard (currentRow % 20) == display - 3 && (currentRow / display) == (currentPage - 1) else {
            return
        }
        
        requestNewsList(isNeededToReset: false)
    }
}

extension NewsListPresenter: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        newsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: NewsListTableViewCell.identifier,
            for: indexPath
        ) as? NewsListTableViewCell
        
        let news = newsList[indexPath.row]
        
        cell?.setUp(news: news)
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: NewsListTableViewHeaderView.identifier
        ) as? NewsListTableViewHeaderView

        header?.setUp(tags: tags, delegate: self)
        
        return header
    }
}

private extension NewsListPresenter {
    func requestNewsList(isNeededToReset: Bool) {
        if isNeededToReset {
            currentPage = 0
            newsList = []
        }
        
        newsSearchManager.request(
            from: currentKeyword,
            start: (currentPage * display) + 1,
            display: display
        ) { [weak self] newValue in
            self?.newsList += newValue
            self?.currentPage += 1
            self?.viewController?.reloadTableView()
            self?.viewController?.endRefreshing()
        }
    }
}

// MARK: Pagination
// 지금까지 request 된, 가지고 있는 page가 어디인지 알고 있어야함
