//
//  CenterList.swift
//  FindCoronaCenter
//
//  Created by 전성훈 on 2022/11/25.
//

import SwiftUI

struct CenterList: View {
    var centers = [Center]()
    var body: some View {
        List(centers, id: \.id) { center in
            NavigationLink(destination: CenterDetailView(center: center)) {
                CenterRow(center: center)
            }
            .navigationTitle(center.sido.rawValue)
        }
    }
}

struct CenterList_Previews: PreviewProvider {
    static var previews: some View {
        let centers = [
            Center(id: 0, sido: .경기도, facilityName: "test1", address: "address1", lat: "37.484476", lng: "126.9491998", centerType: .local, phoneNumber: "010-0000-0000"),
            Center(id: 1, sido: .경상남도, facilityName: "test2", address: "address2", lat: "37.484555", lng: "126.9495555", centerType: .local, phoneNumber: "010-0000-0000"),
            Center(id: 2, sido: .강원도, facilityName: "test3", address: "address3", lat: "37.495555", lng: "126.969999", centerType: .local, phoneNumber: "010-0000-0000")
        ]
        CenterList(centers: centers)
    }
}
