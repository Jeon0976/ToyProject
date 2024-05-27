//
//  ViewController.swift
//  snsLoginTest
//
//  Created by 전성훈 on 5/10/24.
//

import UIKit

class ViewController: UIViewController {

    private let loginBtn: UIButton = {
        let btn = UIButton()
        
        btn.setTitle("로그인", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.addTarget(self, action: #selector(tappedButton(_:)), for: .touchUpInside)
        
        return btn
    }()
    
    private let loadUser: UIButton = {
        let btn = UIButton()
        
        btn.setTitle("Jeon0976", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.addTarget(self, action: #selector(tappedButton2(_:)), for: .touchUpInside)
        
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        loginBtn.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(loginBtn)
        
        loadUser.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(loadUser)
        
        NSLayoutConstraint.activate([
            loginBtn.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            loginBtn.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            loadUser.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            loadUser.topAnchor.constraint(equalTo: loginBtn.bottomAnchor, constant: 16)
        ])
    }
    
    @objc private func tappedButton(_ sender: UIButton) {
        LoginManager.shared.requestCode()
    }
    
    @objc private func tappedButton2(_ sender: UIButton) {
        searchGitHubUsers()
    }
    
    private func searchGitHubUsers() {
        let query = "Jeon"
        let url = URL(string: "https://api.github.com/search/users?q=\(query)&sort=followers&order=desc&per_page=10&page=1")!

        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        request.setValue("application/vnd.github.v3+json", forHTTPHeaderField: "Accept")
        request.setValue("Bearer \(LoginManager.shared.accessToken)", forHTTPHeaderField: "Authorization")

        print(request.url)
        
        let session = URLSession.shared
          session.dataTask(with: request) { data, response, error in
              if let error = error {
                  print("Error: \(error)")
                  return
              }
              
              guard let data = data, let response = response as? HTTPURLResponse,
                    response.statusCode == 200 else {
                  print("No data or wrong response")
                  return
              }
              
              do {
                  if let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] {
                        print("Full JSON Response:")
                        print(jsonObject) // 전체 JSON 출력
                    }
              } catch {
                  print("JSON Error: \(error)")
              }
          }.resume()
    }
}


class LoginManager {
    static let shared = LoginManager()
    
    private init() { }
    
    private let client_id = "Ov23licQ2DwLzDA6QCMn"
    private let client_secret = "338ef5cdc9668ba2f6aaba076c408dd21c95d9ba"
    
    var accessToken = "" {
        didSet {
            print("---")
            print(accessToken)
            print("---")
        }
    }
    
    func requestCode() {
        let scope = "user"
        let urlString = "https://github.com/login/oauth/authorize?client_id=Ov23licQ2DwLzDA6QCMn&scope=\(scope)"
        
        if let url = URL(string: urlString),
           UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
    
    func requestAccessToken(with code: String) {
        let url = URL(string: "https://github.com/login/oauth/access_token")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let parameters = ["client_id": client_id,
                          "client_secret": client_secret,
                          "code": code]
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])
        
        let session = URLSession.shared
                
        session.dataTask(with: request) { [weak self] data, response, error in
            guard let self = self else { return }
            
            if let error = error {
                print(error)
                return
            }
            
            guard let data = data else {
                print("No Data")
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: String] {
                    print("____WDAW")
                    print(json)
                    let accessToken = json["access_token"] ?? ""
                    self.accessToken = accessToken
                }
            } catch {
                print("JSON Error")
            }
        }.resume()
    }
}
