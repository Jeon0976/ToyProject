//
//  MapView.swift
//  FindCoronaCenter
//
//  Created by 전성훈 on 2022/11/25.
//

import SwiftUI
import MapKit

struct AnnotationItem: Identifiable {
    let id = UUID()
    var coordinate: CLLocationCoordinate2D
}

struct MapView: View {
    var coordination: CLLocationCoordinate2D
    // View 내부에서만 변화하는 상태
    @State private var region = MKCoordinateRegion()
    @State private var annotationItems = [AnnotationItem]()
    
    var body: some View {
        Map(coordinateRegion: $region,
            annotationItems: [AnnotationItem(coordinate: coordination)],
            annotationContent: {
            MapMarker(coordinate: $0.coordinate)
        })
        .onAppear {
            setRegion(coordination)
            setAnnotationItems(coordination)
        }
    }
    
    private func setRegion(_ coordinate: CLLocationCoordinate2D) {
        region = MKCoordinateRegion(center: coordinate,
                                    span: MKCoordinateSpan(latitudeDelta: 0.01,
                                                           longitudeDelta: 0.01))
    }
    private func setAnnotationItems(_ coordinate: CLLocationCoordinate2D) {
        annotationItems = [AnnotationItem(coordinate: coordinate)]
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        let center0 = Center(id: 0, sido: .경기도, facilityName: "test1", address: "address1", lat: "37.484476", lng: "126.9491998", centerType: .local, phoneNumber: "010-0000-0000")
        MapView(coordination: CLLocationCoordinate2D(latitude: Double(center0.lat) ?? .zero, longitude: Double(center0.lng) ?? .zero))
    }
}
