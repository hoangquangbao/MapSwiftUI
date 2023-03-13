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
    var onAnimationEnded: () -> ()
    var mapViewWillMove: (Bool) -> ()
    
    func makeUIViewController(context: Context) -> MapViewController {
        // Replace this line
//        return MapViewController()
        let uiViewController = MapViewController()
        uiViewController.mapView.delegate = context.coordinator
        return uiViewController
    }
    
    func updateUIViewController(_ uiViewController: MapViewController, context: Context) {
        // Update the map for each marker
        markers.forEach {  $0.map = uiViewController.mapView }
        
        selectedMarker?.map = uiViewController.mapView
        animateSelectedMarker(viewController: uiViewController)
    }
    
    //Animation map to selected city
    private func animateSelectedMarker(viewController: MapViewController) {
        guard let selectedMarker = selectedMarker else { return }
        
        let map = viewController.mapView
        if map.selectedMarker != selectedMarker {
            map.selectedMarker = selectedMarker
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                map.animate(toZoom: kGMSMaxZoomLevel)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    map.animate(with: GMSCameraUpdate.setTarget(selectedMarker.position))
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        map.animate(toZoom: 12)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            // Invoke onAnimationEnded() one the animation sequence completes
                            onAnimationEnded()
                        }
                    }
                }
            }
        }
    }
    
    func makeCoordinator() -> MapViewCoordinator {
        return MapViewCoordinator(mapViewControllerBridge: self)
    }
    
    final class MapViewCoordinator: NSObject, GMSMapViewDelegate {
        var mapViewControllerBridge: MapViewControllerBridge
        
        init(mapViewControllerBridge: MapViewControllerBridge) {
            self.mapViewControllerBridge = mapViewControllerBridge
        }
        
        func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
            self.mapViewControllerBridge.mapViewWillMove(gesture)
        }
    }
}
