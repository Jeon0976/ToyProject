//
//  LocationInformationViewController.swift
//  FindCVS
//
//  Created by 전성훈 on 2022/11/11.
//

import UIKit
import CoreLocation
import RxSwift
import RxCocoa
import SnapKit

class LocationInformationViewController : UIViewController {
    let disposeBag = DisposeBag()
    
    let locationManager = CLLocationManager()
    let mapView = MTMapView()
    let currentLocationButton = UIButton()
    let detailList = UITableView()
    let detailListBackgroundView = DetailListBackgroundView()
    let viewModel = LocationInformationViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        bind(viewModel)
        attribute()
        layout()
    }
    
    private func bind(_ viewModel: LocationInformationViewModel) {
        detailListBackgroundView.bind(viewModel.detailListBackgroundViewModel)
        
        viewModel.setMapCenter
            .emit(to: mapView.rx.setMapCenterPoint)
            .disposed(by: disposeBag)
        
        viewModel.errorMessage
            .emit(to: self.rx.presentAlert)
            .disposed(by: disposeBag)
        
        viewModel.detailListCellData
            .drive(detailList.rx.items) { tv, row, data in
                let cell = tv.dequeueReusableCell(withIdentifier: "DetailListCell", for: IndexPath(row: row, section: 0)) as! DetailListCell
                cell.setData(data)
                return cell
            }
            .disposed(by: disposeBag)
        
        viewModel.detailListCellData
            .map { $0.compactMap{ $0.point }}
            .drive(self.rx.addPOIItems)
            .disposed(by: disposeBag)
        
        viewModel.scrollToSelectedLocation
            .emit(to: self.rx.showSelectedLocation)
            .disposed(by: disposeBag)
        
        detailList.rx.itemSelected
            .map{ $0.row }
            .bind(to: viewModel.detailListItemSelected)
            .disposed(by: disposeBag)
        
        currentLocationButton.rx.tap
            .bind(to: viewModel.currentLocationButtonTapped)
            .disposed(by: disposeBag)
    }
    
    private func attribute() {
        title = "내 주변 편의점 찾기"
        view.backgroundColor = .systemBackground
        
        mapView.currentLocationTrackingMode = .onWithoutHeadingWithoutMapMoving
//        let po = MTMapPOIItem()
//        po.mapPoint = MTMapPoint(geoCoord: MTMapPointGeo(latitude: 37.4948788646619, longitude: 126.741223612586))
//        po.markerType = .yellowPin
//        po.showAnimationType = .springFromGround
//        let po1 = MTMapPOIItem()
//        po1.mapPoint = MTMapPoint(geoCoord: MTMapPointGeo(latitude: 37.5948788646619, longitude: 126.741223612586))
//        po1.markerType = .yellowPin
//        po1.showAnimationType = .springFromGround
//        let po2 = MTMapPOIItem()
//        po2.mapPoint = MTMapPoint(geoCoord: MTMapPointGeo(latitude: 37.6948788646619, longitude: 126.741223612586))
//        po2.markerType = .yellowPin
//        po2.showAnimationType = .springFromGround
//        mapView.addPOIItems([po,po1,po2])

        
        currentLocationButton.setImage(UIImage(systemName: "location.fill"), for: .normal)
        currentLocationButton.backgroundColor = .systemBackground
        currentLocationButton.layer.cornerRadius = 20
        
        detailList.register(DetailListCell.self , forCellReuseIdentifier: "DetailListCell")
        detailList.separatorStyle = .none
        detailList.backgroundView = detailListBackgroundView
    }
    
    private func layout() {
        [mapView, currentLocationButton, detailList].forEach {view.addSubview($0)}
        
        mapView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(view.snp.centerY).offset(20)
        }
        
        currentLocationButton.snp.makeConstraints {
            $0.bottom.equalTo(detailList.snp.top).offset(-12)
            $0.leading.equalToSuperview().offset(12)
            $0.width.height.equalTo(40)
        }
        
        detailList.snp.makeConstraints {
            $0.top.equalTo(mapView.snp.bottom)
            $0.centerX.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(8)
        }
    }
    
//    private func requestAuthrozation() {
//        if locationManager == nil {
//            locationManager = CLLocationManager()
//            locationManager!.desiredAccuracy = kCLLocationAccuracyBest
//            locationManager!.requestWhenInUseAuthorization()
//            locationManager!.delegate = self
//            locationManagerDidChangeAuthorization(locationManager!)
//        } else {
//            locationManager!.startMonitoringSignificantLocationChanges()
//        }
//    }
}

extension LocationInformationViewController: CLLocationManagerDelegate {
//    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
////        switch manager.authorizationStatus {
////        case .authorizedAlways, .authorizedWhenInUse, .notDetermined: return
////        default :
////            viewModel.mapViewError.accept(MTMapViewError.locationAuthorizationDenied.errorDescription)
////            return
////        }
//        switch manager.authorizationStatus {
//        case .authorizedAlways, .authorizedWhenInUse:
//            print("권한 설절됨")
//        case .restricted, .notDetermined:
//            print("권한 설정 x")
//            getLocationUsagePermission()
//        }
//    }
    
    func getLocationUsagePermission() {
        self.locationManager.requestWhenInUseAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            print("권한 설정됨")
        case .restricted, .notDetermined:
            print("권한 설정 x")
            getLocationUsagePermission()
        case .denied:
            print("거부됨")
            getLocationUsagePermission()
            viewModel.mapViewError.accept(MTMapViewError.locationAuthorizationDenied.errorDescription)
        default:
            print("default")
        }
    }
}

extension LocationInformationViewController: MTMapViewDelegate {
    func mapView(_ mapView: MTMapView!, updateCurrentLocation location: MTMapPoint!, withAccuracy accuracy: MTMapLocationAccuracy) {
//        #if DEBUG
//        viewModel.currentLocation.accept(MTMapPoint(geoCoord: MTMapPointGeo(latitude: 37.2958378, longitude: 126.4341517)))
//        #else
         viewModel.currentLocation.accept(location)
//        #endif
    }
    
    // 지동 이동이 끝났을 때 센터 포인트를 알려줄 delegate
    func mapView(_ mapView: MTMapView!, finishedMapMoveAnimation mapCenterPoint: MTMapPoint!) {
         viewModel.mapCenterPoint.accept(mapCenterPoint)
    }
    
    // pin 표시된 아이탬
    func mapView(_ mapView: MTMapView!, selectedPOIItem poiItem: MTMapPOIItem!) -> Bool {
         viewModel.selectPOIItem.accept(poiItem)
        return false
    }
    
    func mapView(_ mapView: MTMapView!, failedUpdatingCurrentLocationWithError error: Error!) {
         viewModel.mapViewError.accept(error.localizedDescription)
    }
}



extension Reactive where Base: MTMapView {
    var setMapCenterPoint: Binder<MTMapPoint> {
        return Binder(base) { base, point in
            base.setMapCenter(point, animated: true)
        }
    }
}

extension Reactive where Base: LocationInformationViewController {
    var presentAlert: Binder<String> {
        return Binder(base) { base, message in
            let alertController = UIAlertController(title: "문제가 발생했어요", message: message, preferredStyle: .alert)
            let action = UIAlertAction(title: "확인", style: .default, handler: nil)
            alertController.addAction(action)
            base.present(alertController, animated: true)
        }
    }
    
    var showSelectedLocation: Binder<Int> {
        return Binder(base) { base, row in
            let indexPath = IndexPath(row: row, section: 0)
            base.detailList.selectRow(at: indexPath, animated: true, scrollPosition: .top)
        }
    }
    
    var addPOIItems: Binder<[MTMapPoint]> {
        return Binder(base) { base, points in
            let items = points
                .enumerated()
                .map { offset, point -> MTMapPOIItem in
                    let mapPOIItem = MTMapPOIItem()
                    
                    mapPOIItem.mapPoint = point
                    mapPOIItem.markerType = .redPin
                    mapPOIItem.showAnimationType = .springFromGround
                    mapPOIItem.tag = offset
                    
                    return mapPOIItem
                }
            base.mapView.removeAllPOIItems()
            base.mapView.addPOIItems(items)
        }
    }
}
