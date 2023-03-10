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
    
    let map = GMSMapView(
        frame: .zero,
        camera: GMSCameraPosition(
            latitude: 37.7576,
            longitude: -122.4194,
            zoom: 10.0))
    
    var isAnimating: Bool = false
    
    override func loadView() {
        super.loadView()
        self.view = map
    }
}
