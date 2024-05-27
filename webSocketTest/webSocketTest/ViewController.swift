//
//  ViewController.swift
//  webSocketTest
//
//  Created by 전성훈 on 5/24/24.
//

import UIKit

class ViewController: UIViewController {

    private var webSocket: URLSessionWebSocketTask?
    
    private lazy var button: UIButton = {
        let btn = UIButton()
        
        btn.backgroundColor = .blue
        btn.setTitle("Disconnect", for: .normal)
        btn.addTarget(self, action: #selector(closeSession(_:)), for: .touchUpInside)
        
        return btn
    }()
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        
        textField.textColor = .black
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 1
        
        return textField
    }()
    
    private lazy var sendButton: UIButton = {
        let btn = UIButton()
        
        btn.backgroundColor = .red
        btn.setTitle("Send", for: .normal)
        btn.addTarget(self, action: #selector(sendText(_:)), for: .touchUpInside)
        
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        [
            textField,
            button,
            sendButton
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            textField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            textField.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            textField.heightAnchor.constraint(equalToConstant: 80),
            textField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            textField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            
            button.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            button.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            button.widthAnchor.constraint(equalToConstant: 120),
            button.heightAnchor.constraint(equalToConstant: 80),
            
            sendButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
            sendButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            sendButton.widthAnchor.constraint(equalToConstant: 120),
            sendButton.heightAnchor.constraint(equalToConstant: 80)
        ])
        
        let session = URLSession(
            configuration: .default,
            delegate: self,
            delegateQueue: OperationQueue()
        )
        
        let url = URL(string: "wss://free.blr2.piesocket.com/v3/1?api_key=Tc2TOploqXkjPRZ8CBuzjQLxnI7XpL7YjZQAuuzS&notify_self=1")!
        
        webSocket = session.webSocketTask(with: url)
        webSocket?.resume()
    }

    /// The receive function needs to be recurring so that we can keep on listening to the server response.
    func receive() {
        let workItem = DispatchWorkItem { [weak self] in
            self?.webSocket?.receive(completionHandler: { result in
                switch result {
                case .success(let message):
                    switch message {
                    case .data(let data):
                        print("Data received \(data)")
                    case .string(let strMessage):
                        print("String received \(strMessage)")
                    default:
                        break
                    }
                case .failure(let error):
                    print("Error receiving \(error)")
                }
                
                // Create the Recurrsion
                self?.receive()
            })
        }
        
        DispatchQueue.global().asyncAfter(
            deadline: .now() + 0.5,
            execute: workItem
        )
    }
    
    func send(with text: String) {
        let workItem = DispatchWorkItem { [weak self] in
            self?.webSocket?.send(
                URLSessionWebSocketTask.Message.string(text),
                completionHandler: { error in
                  print(error)
            })
        }
        
        DispatchQueue.global().asyncAfter(
            deadline: .now() + 0.5,
            execute: workItem
        )
    }
    
    @objc private func sendText(_ sender: UIButton) {
        if let text = textField.text {
            send(with: text)
        }
    }
    
    @objc private func closeSession(_ sender: UIButton) {
        webSocket?.cancel(
            with: .goingAway,
            reason: "You've Closed The Connection".data(using: .utf8)
        )
    }
}

extension ViewController: URLSessionWebSocketDelegate {
    func urlSession(
        _ session: URLSession,
        webSocketTask: URLSessionWebSocketTask,
        didOpenWithProtocol protocol: String?
    ) {
        print("Connected to server")
        receive()
    }
    
    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didCloseWith closeCode: URLSessionWebSocketTask.CloseCode, reason: Data?) {
        print("Disconnect from server \(reason)")
    }
}

