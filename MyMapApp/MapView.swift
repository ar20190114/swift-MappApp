//
//  MapView.swift
//  MyMapApp
//
//  Created by ryotaban on 2023/01/15.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    
    let searchKey: String
    
    func  makeUIView(context: Context) -> MKMapView {
        MKMapView()
    }
    
    func updateUIView(_ uiView: MKMapView, context:Context) {
        print(searchKey)
        
        let geocoder = CLGeocoder()
        
        geocoder.geocodeAddressString(
            searchKey,
            completionHandler: { (placemarks, error) in
                if let unwrapPlacemarks = placemarks,
                   let firstPlacemark = unwrapPlacemarks.first,
                   let location = firstPlacemark.location {
                    let targetCoordinate = location.coordinate
                    
                    print(targetCoordinate)
                    
                    let pin = MKPointAnnotation()
                    
                    pin.coordinate = targetCoordinate
                    pin.title = searchKey
                    
                    uiView.addAnnotation(pin)
                    
                    uiView.region = MKCoordinateRegion(
                        center: targetCoordinate,
                        latitudinalMeters: 500,
                        longitudinalMeters: 500
                    )
                }
            })
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(searchKey: "東京タワー")
    }
}
