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
    @Binding var selectedMarker: GMSMarker?

  func makeUIViewController(context: Context) -> MapViewController {
    // Replace this line
    return MapViewController()
  }

  func updateUIViewController(_ uiViewController: MapViewController, context: Context) {
      // Update the map for each marker
      markers.forEach {  $0.map = uiViewController.map }
      
      selectedMarker?.map = uiViewController.map
      animateSelectedMarker(viewController: uiViewController)
  }
    
    //Animation map to selected city
    private func animateSelectedMarker(viewController: MapViewController) {
        guard let selectedMarker = selectedMarker else { return }
        
        let map = viewController.map
        if map.selectedMarker != selectedMarker {
            map.selectedMarker = selectedMarker
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                map.animate(toZoom: kGMSMaxZoomLevel)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    map.animate(with: GMSCameraUpdate.setTarget(selectedMarker.position))
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        map.animate(toZoom: 12)
                    }
                }
            }
        }
    }
}
