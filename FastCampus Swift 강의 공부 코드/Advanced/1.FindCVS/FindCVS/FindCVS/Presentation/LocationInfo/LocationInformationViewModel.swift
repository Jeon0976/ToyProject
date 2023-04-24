//
//  LocationInformationViewModel.swift
//  FindCVS
//
//  Created by 전성훈 on 2022/11/11.
//

import RxSwift
import RxCocoa

struct LocationInformationViewModel {
    let disposeBag = DisposeBag()
    
    // subViewModels
    let detailListBackgroundViewModel = DetailListBackgroundViewModel()
    
    // viewModel -> View
    let setMapCenter: Signal<MTMapPoint>
    let errorMessage: Signal<String>
    let detailListCellData: Driver<[DetailListCellData]>
    let scrollToSelectedLocation: Signal<Int>
    
    // View -> ViewModel
    let currentLocation = PublishRelay<MTMapPoint>()
    let mapCenterPoint = PublishRelay<MTMapPoint>()
    let selectPOIItem = PublishRelay<MTMapPOIItem>()
    let mapViewError = PublishRelay<String>()
    let currentLocationButtonTapped = PublishRelay<Void>()
    let detailListItemSelected = PublishRelay<Int>()

    private let documentData = PublishSubject<[KLDocument]>()
    
    // setMapCenter, errorMessage 초기화 해줘야 함
    init(model: LocationInformationModel = LocationInformationModel()) {
        //MARK: 네트워크 통신으로 데이터 불러오기
        let cvsLocationDataResult = mapCenterPoint
            .flatMapLatest(model.getLocation)
            .share()
        
        let cvsLocationDataValue = cvsLocationDataResult
            .compactMap { data -> Location? in
                guard case let .success(value) = data else {
                    return nil
                }
                return value
            }
        
        let cvsLocationDataErrorMessage = cvsLocationDataResult
            .compactMap { data -> String? in
                switch data {
                case let .success(data) where data.documents.isEmpty:
                    return """
                500m 근처에 이용할 수 있는 편의점이 없어요.
                지도 위치를 옮겨서 재검색해주세요.
                """
                case let .failure(error):
                    return error.localizedDescription
                // 성공일 경우
                default:
                    return nil
                }
            }
        
        cvsLocationDataValue
            .map { $0.documents}
            .bind(to: documentData)
            .disposed(by: disposeBag)
        
        //MARK: 지도 중심점 설정
//        let selectDetailListItem = detailListItemSelected
//        // selected 한 데이터의 row
//            .withLatestFrom(documentData) { $1[$0] }
//            .map { data -> MTMapPoint in
//                guard let longitute = Double(data.x),
//                      let latitude = Double(data.y) else {
//                    return MTMapPoint()
//                }
//                let getCoord = MTMapPointGeo(latitude: latitude, longitude: longitute)
//                return MTMapPoint(geoCoord: getCoord)
//            }
        let selectDetailListItem = detailListItemSelected
            .withLatestFrom(documentData) { $1[$0] }
            .map(model.documentToMTMapPoint)
        
        let moveToCurrentLocation = currentLocationButtonTapped
            .withLatestFrom(currentLocation)
        
        let currentMapCenter = Observable
            .merge(
                selectDetailListItem,
                // currentLocation을 최초 받았을 때 한번
                currentLocation.take(1),
                moveToCurrentLocation
            )
        
        setMapCenter = currentMapCenter
            .asSignal(onErrorSignalWith: .empty())
        
        //MARK: Error Message 설정
        errorMessage = Observable
            .merge(
                cvsLocationDataErrorMessage,
                mapViewError.asObservable()
            )
            .asSignal(onErrorJustReturn: "잠시 후 시도해주세요.")
        
        detailListCellData = documentData
            .map(model.documentsToCellData)
            .asDriver(onErrorDriveWith: .empty())
        
        documentData
            .map { !$0.isEmpty }
            .bind(to: detailListBackgroundViewModel.shouldHideStatusLabel)
            .disposed(by: disposeBag)
        
        scrollToSelectedLocation = selectPOIItem
            .map { $0.tag }
            .asSignal(onErrorJustReturn: 0)
    }
}

