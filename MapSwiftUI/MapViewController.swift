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

  let map =  GMSMapView(frame: .zero)
  var isAnimating: Bool = false

  override func loadView() {
    super.loadView()
    self.view = map
  }
}
