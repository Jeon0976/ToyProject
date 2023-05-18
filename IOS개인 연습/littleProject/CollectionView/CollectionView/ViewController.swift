//
//  ViewController.swift
//  CollectionView
//
//  Created by 전성훈 on 2023/05/16.
//

import UIKit

class ViewController: UIViewController {
    
    var data = ["Test1","Test2","Test3","Test4","Test5","Test6","Test7","Test8","Test9","Test10","Test11","Test12","Test13","Test14","Test15"]
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        layout.collectionView?.clipsToBounds = true
        
        
        let colletionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        colletionView.dataSource = self
        colletionView.delegate = self
        colletionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.identifier)
        colletionView.backgroundColor = .gray
        colletionView.layer.cornerRadius = 8
        
        return colletionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .systemBackground
        view.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 6),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 6),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -6),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -6)
        ])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        sleep(3)
        collectionView.performBatchUpdates {
            let data1 = data[0]
            data.remove(at: 0)
            data.append(data1)
            
            let indexPath = IndexPath(item: 0, section: 0)
            collectionView.deleteItems(at: [indexPath])
            
            let newIndexPath = IndexPath(item: data.count - 1, section: 0)
            collectionView.insertItems(at: [newIndexPath])
        }
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let randomDouble = Double.random(in: 60...150)
        
        return CGSize(width: randomDouble, height: randomDouble)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activityController = UIActivityViewController(activityItems: [data[indexPath.row]], applicationActivities: nil)
        
        activityController.completionWithItemsHandler = { [weak self] (activity, success, items, error) in
            if success {
                let alertController = UIAlertController(title: "성공", message: "복사했습니다.", preferredStyle: .alert)
                let action = UIAlertAction(title: "확인", style: .cancel)
                alertController.addAction(action)
                
                self?.present(alertController, animated: true)
            } else {
                print("Test")
            }
            
        }
        present(activityController,animated: true)
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCell.identifier, for: indexPath) as? CollectionViewCell

        cell?.makeCell(data[indexPath.item])
        
        return cell ?? UICollectionViewCell()
    }
}

