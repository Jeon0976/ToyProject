//
//  ViewController.swift
//  PhotoKit
//
//  Created by 전성훈 on 2023/05/15.
//

import UIKit
import Photos

class ViewController: UIViewController {
    
    let tableView = UITableView()
    
    //MARK: Image 처리를 위한 객체
    var fetchResult: PHFetchResult<PHAsset>?
    let imageManager: PHCachingImageManager = PHCachingImageManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        attribute()
        layout()
        
        photoAuthorization()
        
        // MARK: 바뀐것 확인하기 위한 코드
        PHPhotoLibrary.shared().register(self)
    }
    
    
    // MARK: Image 불러오기
    func requestCollection() {
        let cameraRoll: PHFetchResult<PHAssetCollection> = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumUserLibrary, options: nil)
        
        guard let cameraRollCollection = cameraRoll.firstObject else {
            return
        }
        
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        self.fetchResult = PHAsset.fetchAssets(in: cameraRollCollection, options: fetchOptions)
    }
    
    // MARK: Image authorization 확인
    func photoAuthorization() {
        let photoAutorizationStatus = PHPhotoLibrary.authorizationStatus(for: .readWrite)
        
        switch photoAutorizationStatus {
        case .authorized:
            print("접근 허가됨")
            requestCollection()
            tableView.reloadData()
        case .denied:
            print("접근 불허")
        case .notDetermined:
            print("아직 응답하지 않음")
            PHPhotoLibrary.requestAuthorization(for: .readWrite) { [weak self] status in
                switch status {
                case .authorized:
                    print("사용자가 허용함")
                    self?.requestCollection()
                    DispatchQueue.main.async {
                        self?.tableView.reloadData()
                    }
                case .denied:
                    print("사용자가 불허함")
                default: break
                }
            }
        case .restricted:
            print("접근 제한")
        case .limited:
            print("limited가 뭐야?")
        @unknown default:
            break
        }
    }
    
    
    private func attribute() {
        tableView.dataSource = self
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
    }
    
    private func layout() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 6),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -6),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 6),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -6)
        ])
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchResult?.count ?? 0
    }
    
    // MARK: targetSize를 통해
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as? TableViewCell
        
        let asset: PHAsset = fetchResult!.object(at: indexPath.row)
        
        imageManager.requestImage(for: asset, targetSize: CGSize(width: 100, height: 100), contentMode: .aspectFill, options: nil) { image , _ in
            cell?.makeCell(image ?? UIImage())
        }
        
        return cell ?? UITableViewCell()
    }
    
    
}


//MARK: 사진 삭제하기
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let asset: PHAsset = self.fetchResult![indexPath.row]
            
            PHPhotoLibrary.shared().performChanges {
                PHAssetChangeRequest.deleteAssets([asset] as NSArray)
            }
        }
        tableView.reloadData()
    }
}


//MARK: Library 변화 생길 시 감지
extension ViewController: PHPhotoLibraryChangeObserver {
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        guard let changes = changeInstance.changeDetails(for: fetchResult!) else { return }
        
        fetchResult = changes.fetchResultAfterChanges
        
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
        
    }
}
