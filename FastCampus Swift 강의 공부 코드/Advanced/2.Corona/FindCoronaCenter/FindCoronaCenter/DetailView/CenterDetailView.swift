//
//  CenterDetailView.swift
//  FindCoronaCenter
//
//  Created by 전성훈 on 2022/11/25.
//

import SwiftUI
import MapKit

struct CenterDetailView: View {
    var center: Center
    var body: some View {
        VStack {
            MapView(coordination: center.coordinate)
                .ignoresSafeArea(edges: .all)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            CenterRow(center: center)
        }
        .navigationTitle(center.facilityName)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct CenterDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let center0 = Center(id: 0, sido: .경기도, facilityName: "test1", address: "address1", lat: "37.484476", lng: "126.9491998", centerType: .local, phoneNumber: "010-0000-0000")
        CenterDetailView(center: center0)
    }
}
