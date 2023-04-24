//
//  BeerListViewController.swift
//  Brewery
//
//  Created by 전성훈 on 2022/09/05.
//

import UIKit

class BeerListViewController: UITableViewController {
    var beerList = [Beer]()
    var currentPage = 1
    // 한 번 불러온 것은 또 불러오지 않게 하기 위한 전역변수
    var dataTasks = [URLSessionTask]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //UINavigationBar
        title = "성훈브루어리"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        //UITableView Setting
        tableView.register(BeerListCell.self, forCellReuseIdentifier: "BeerListCell")
        tableView.rowHeight = 150
        // 스크롤 내리면 다음 페이지를 나올 수 있게 하는 전초작업
        // what is prefetchDataSource
        // 진행 중인 처리와 병행하여 필요하다고 생각되는 데이터를 사전에 판독하는 것
        // 사용자 화면에 보여지는 테이블 뷰의 데이터 소스와 더불어 셀에서 미리 데이터를 준비해야 하거나 데이터를 준비(처리)하는 시간이 긴 경우 사용하게 되며 tableview(_: cellForRowAt:) 메소드가 실행 되기 전에 프리페치가 수행된다.
        tableView.prefetchDataSource = self
        fetchBeer(of: currentPage)
    }
}


//UITableView DataSource, Delegate
extension BeerListViewController :UITableViewDataSourcePrefetching {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beerList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BeerListCell", for: indexPath) as? BeerListCell else {return UITableViewCell()}
                
        let beer = beerList[indexPath.row]
        cell.configure(with: beer)
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedBeer = beerList[indexPath.row]
        let detailViewController = BeerDetailViewController()
        
        detailViewController.beer = selectedBeer
        self.show(detailViewController, sender: nil)
    }
    
        
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        guard currentPage != 1 else {return}
        
        indexPaths.forEach {
            if ($0.row + 1)/25 + 1 == currentPage {
                self.fetchBeer(of: currentPage)
            }
        }
    }
}

// Data Fetching
private extension BeerListViewController {
    func fetchBeer(of page: Int) {
        guard let url = URL(string: "https://api.punkapi.com/v2/beers?page=\(page)"),
              dataTasks.firstIndex(where: { URLSessionTask in
                  URLSessionTask.originalRequest?.url == url
              }) == nil else {return}
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let dataTask = URLSession.shared.dataTask(with: request) {[weak self] data, response, error in
            guard error == nil,
                  let self = self,
                  let response = response as? HTTPURLResponse,
                  let data = data,
                  let beers = try? JSONDecoder().decode([Beer].self, from: data) else {
                print("ERROR : URLSession data task \(error?.localizedDescription ?? "")")
                return
            }
            switch response.statusCode {
            case (200...299) : // success
                self.beerList += beers
                self.currentPage += 1
                
               DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case (400...499) : // client error
                print("""
                    ERROR: Client ERROR \(response.statusCode)
                    Response: \(response)
                """)
            case (500...599) : // server error
                print("""
                    ERROR: Server ERROR \(response.statusCode)
                    Response: \(response)
                """)
            default:
                print("""
                    ERROR: ERROR \(response.statusCode)
                    Response: \(response)
                """)
            }
        }
        dataTask.resume()
        // 한 버 실행했던 작업에 대해서는 dataTasks에 저장
        dataTasks.append(dataTask)        
    }
}
