//
//  MapViewController.swift
//  MapSwiftUI
//
//  Created by Quang Bao on 10/03/2023.
//

import GoogleMaps
import SwiftUI
import UIKit

class MapViewController: UIViewController, GMSMapViewDelegate {
    
    let mapView = GMSMapView(
        frame: .zero,
        camera: GMSCameraPosition(
            latitude: 37.7576,
            longitude: -122.4194,
            zoom: 15.0))
    
    var isAnimating: Bool = false
    let infoMarker = GMSMarker()
    let MapStyle = "[ \n  { \n    \"featureType\": \"poi.business\", \n    \"elementType\": \"all\",\n    \"stylers\": [\n      {\n        \"visibility\": \"off\"\n      }\n    ]\n  },\n  {\n    \"featureType\": \"transit\",\n    \"elementType\": \"labels.icon\",\n    \"stylers\": [\n      {\n        \"visibility\": \"off\"\n      }\n    ]\n  }\n]"
    
    // Set the status bar style to complement night-mode.
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
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
        
        // Hiding Map Features with Styling - Using a string resource
        /* https://developers.google.com/maps/documentation/ios-sdk/hiding-features */
        do {
            // Set the map style by passing a valid JSON string.
            mapView.mapStyle = try GMSMapStyle(jsonString: MapStyle)
        } catch {
            NSLog("One or more of the map styles failed to load. \(error)")
        }
        
        mapView.delegate = self
        self.view = mapView
    }
    
    // Attach an info window to the POI using the GMSMarker.
    func mapView(
        _ mapView: GMSMapView,
        didTapPOIWithPlaceID placeID: String,
        name: String,
        location: CLLocationCoordinate2D
    ) {
        print("You tapped \(name): \(placeID), \(location.latitude)/\(location.longitude)")
        
        infoMarker.snippet = placeID
        infoMarker.position = location
        infoMarker.title = name
        
        // Add a marker
        infoMarker.opacity = 1
        infoMarker.appearAnimation = .pop
        infoMarker.icon = GMSMarker.markerImage(with: .green)
        
        // Attach an info window
        //        infoMarker.opacity = 0
        //        infoMarker.infoWindowAnchor.y = 1
        //        mapView.selectedMarker = infoMarker
        
        infoMarker.map = mapView
    }
}
