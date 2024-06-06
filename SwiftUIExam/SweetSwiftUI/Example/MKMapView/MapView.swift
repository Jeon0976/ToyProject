//
//  MapView.swift
//  SweetSwiftUI
//
//  Created by 전성훈 on 6/3/24.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    let coordinate: CLLocationCoordinate2D
    
    func makeUIView(context: Context) -> MKMapView {
        MKMapView()
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        let camera = MKMapCamera(
            lookingAtCenter: coordinate,
            fromDistance: 2500,
            pitch: 45,
            heading: 0
        )
        
        uiView.setCamera(camera, animated: true)
    }
}

struct ContentViewMap: View {
    @State private var coordinate = CLLocationCoordinate2D(latitude: 37.551416, longitude: 126.988194)
    
    let locations: [String: CLLocationCoordinate2D] = [
        "남산": CLLocationCoordinate2D(latitude: 37.551416, longitude: 126.988194),
        "시청": CLLocationCoordinate2D(latitude: 37.566308, longitude: 126.977948),
        "국회": CLLocationCoordinate2D(latitude: 37.531830, longitude: 126.914187)
    ]
    
    var body: some View {
        ZStack(alignment: .bottom) {
            MapView(coordinate: coordinate)
            HStack(spacing: 30, content: {
                ForEach(["남산", "시청", "국회"], id: \.self) { location in
                    Button(action: { self.coordinate = self.locations[location]! }, label: {
                        Text(location)
                            .font(.headline)
                            .foregroundStyle(.white)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 8).fill(.blue))
                    })
                }
            })
            .padding(.bottom, 40)
        }
        .ignoresSafeArea(.all)

    }
}

#Preview {
    ContentViewMap()
}
