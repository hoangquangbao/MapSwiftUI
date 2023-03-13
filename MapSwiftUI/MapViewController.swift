//
//  MapViewController.swift
//  MapSwiftUI
//
//  Created by Quang Bao on 10/03/2023.
//

import GoogleMaps
import SwiftUI
import UIKit

class MapViewController: UIViewController {
    
    let mapView = GMSMapView(
        frame: .zero,
        camera: GMSCameraPosition(
            latitude: 37.7576,
            longitude: -122.4194,
            zoom: 5.0))
    
    var isAnimating: Bool = false
    
    override func loadView() {
        super.loadView()
        /* MAP TYPE - We have some map types: hybrid, satellite, terrain, normal and none. Normal type is default */
//        mapView.mapType = .normal
        
        /* INDOOR MAPS - More details in this link:
         https://developers.google.com/maps/documentation/ios-sdk/configure-map */
//        mapView.isIndoorEnabled = false
        
        /* THE TRAFFIC LAYER - Default it's NO. More details in this link:
         https://developers.google.com/maps/documentation/ios-sdk/reference/interface_g_m_s_map_view#aba119ffe9f9b0c892027656767e59732*/
//        mapView.isTrafficEnabled = true
                
        mapView.isMyLocationEnabled = true
        print("My location: \(String(describing: mapView.myLocation))")
        
        /* Enable 3D buildings */
        mapView.isBuildingsEnabled = true
        
        /* ADD PADDING - Insets are specified in the order: top, bottom, left, right */
//        let mapInsets = UIEdgeInsets(top: 100, left: 0, bottom: 0, right: 150)
//        mapView.padding = mapInsets
        
        self.view = mapView
    }
}
