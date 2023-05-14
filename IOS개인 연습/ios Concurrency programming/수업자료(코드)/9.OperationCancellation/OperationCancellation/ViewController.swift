//
//  ViewController.swift
//  Concurrency
//
//  Created by Allen on 2020/02/08.
//  Copyright © 2020 allen. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
    
    private let layout = UICollectionViewFlowLayout()
    
    lazy var collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
    
    private let reuseIdentifier = "PhotoCell"
    
    private let cellSpacing: CGFloat = 1
    private let columns: CGFloat = 3
    
    private var urls: [URL] = []
    
    // 오퍼레이션큐생성
    private let queue = OperationQueue()
    
    // 🎾 취소관리를 위한 indexPath및 오퍼레이션을 저장
    private var operations: [IndexPath: [Operation]] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Photos.plist에서 뽑아내서, urls에 저장하기
        guard let url = Bundle.main.url(forResource: "Photos", withExtension: "plist"),
            let contents = try? Data(contentsOf: url),
            let serial = try? PropertyListSerialization.propertyList(from: contents, format: nil),
            let serialUrls = serial as? [String]
            else { return print("무엇인가 잘못되었습니다.") }
        
        urls = serialUrls.compactMap { URL(string: $0) }
        
        
        //코드로 컬렉션뷰 생성 및 오토레이아웃 잡기
        setupCollectionView()
        setupLayouts()
    }
    
    private func setupCollectionView() {
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = cellSpacing
        layout.minimumInteritemSpacing = cellSpacing
        let width = (UIScreen.main.bounds.width - cellSpacing * 2) / columns
        layout.itemSize = CGSize(width: width , height: width)
        
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        
        view.addSubview(collectionView)
    }
    
    private func setupLayouts() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.urls.count
    }
    
    // 🎾 셀 구현부
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PhotoCell
        
        cell.display(image: nil)
        
        // 오퍼레이션 생성
        let downloadOp = NetworkImageOperation(url: urls[indexPath.row])
        let tiltShiftOp = TiltShiftOperation()
        
        // 오퍼레이션 의존성 설정
        tiltShiftOp.addDependency(downloadOp)
        
        // 🎾 오퍼레이션에 콜백함수의 전달(TiltShilt가 끝나고 할일) (메인쓰레드에서 실행됨)
        tiltShiftOp.onImageProcessed = { image in
            // indexPath에 해당하는 셀찾아서
            guard let cell = collectionView.cellForItem(at: indexPath) as? PhotoCell else { return }
            
            // 액티비티 인디케이터 멈추고, 이미지표시
            cell.isLoading = false
            cell.display(image: image)
        }
        
        // 오퍼레이션큐에 오퍼레이션 넣기
        queue.addOperation(downloadOp)
        queue.addOperation(tiltShiftOp)
        
        // indexPath에 기존 operation이 있으면 일단 취소시키기
        if let existingOperations = operations[indexPath] {
            for operation in existingOperations {
                operation.cancel()
            }
        }
        
        // 🎾 향후, 오퍼레이션 취소를 위해 딕셔너리에 찾기쉽게 [indexPath:[오퍼레이션]]으로 저장
        operations[indexPath] = [tiltShiftOp, downloadOp]
        
        return cell
    }
}

extension ViewController: UICollectionViewDelegate {
    
    // 🎾 컬렉션뷰의 셀이 지났갔을때, 취소를 위한 구현부분
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        // 🎾 indexPath에 해당하는 Operation찾아서 취소
        if let operations = operations[indexPath] {
            for operation in operations {
                operation.cancel()
            }
        }
    }
}
