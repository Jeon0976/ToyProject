//
//  LocationInformationModelTests.swift
//  FindCVSTests
//
//  Created by 전성훈 on 2022/11/16.
//

import XCTest
import Nimble

@testable import FindCVS

final class LocationInformationModelTest: XCTestCase {
    let stubNetwork = LocalNetworkStub()
    
    var doc: [KLDocument]!
    var model: LocationInformationModel!
    
    override func setUp() {
        self.model = LocationInformationModel(localNetwork: stubNetwork)
        self.doc = cvsList
    }

    func testDocumentsToCellData() {
        let cellData = model.documentsToCellData(doc) // 실제 모델 값
        let placeName = doc.map {$0.placeName} // 더미 값
        let address0 = cellData[1].address // 실제 모델의 값
        let roadAddressName = doc[1].roadAddressName // 더미 값
        
        expect(cellData.map {$0.placeName}).to(
            equal(placeName),
            description: "DetailListCellData의 PlaceName은 document의 PlaceName이다."
        )
        
        expect(address0).to(
            equal(roadAddressName),
            description: "KLDocument의 RoadAddressName이 빈 값이 아닐 경우 roadAdderss가 cellData에 전달된다."
        )
    }
}
