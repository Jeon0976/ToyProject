//
//  LocalNetworkStub.swift
//  FindCVSTests
//
//  Created by 전성훈 on 2022/11/16.
//

import Foundation
import RxSwift
import Stubber
// stubber : dummy network

@testable import FindCVS


class LocalNetworkStub: LocalNetwork {
    override func getLocation(by mapPoint: MTMapPoint) -> Single<Result<Location, URLError>> {
        return Stubber.invoke(getLocation, args: mapPoint)
    }
}
