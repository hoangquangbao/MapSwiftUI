//
//  MapViewControllerBridge.swift
//  MapSwiftUI
//
//  Created by Quang Bao on 10/03/2023.
//

import GoogleMaps
import SwiftUI

struct MapViewControllerBridge: UIViewControllerRepresentable {
    
    @Binding var markers: [GMSMarker]

  func makeUIViewController(context: Context) -> MapViewController {
    // Replace this line
    return MapViewController()
  }

  func updateUIViewController(_ uiViewController: MapViewController, context: Context) {
      // Update the map for each marker
      markers.forEach {  $0.map = uiViewController.map }
  }
}
