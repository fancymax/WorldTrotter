//
//  MapViewController.swift
//  WorldTrotter
//
//  Created by fancymax on 2017/8/19.
//  Copyright © 2017年 ws. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    var mapView: MKMapView!
    
    override func loadView() {
        mapView = MKMapView()
        
        view = mapView
        
        let segmentControl = UISegmentedControl(items: ["Standard","Hybird","Satellite"])
        view.addSubview(segmentControl)
        
        segmentControl.translatesAutoresizingMaskIntoConstraints = false
        
        segmentControl.selectedSegmentIndex = 0
        segmentControl.addTarget(self, action: #selector(mapTypeChange(_ :)), for: .valueChanged)
        
        let topConstraint = segmentControl.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor,constant:8)
        let margins = view.layoutMarginsGuide
        let leftConstraint = segmentControl.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        let rightConstraint = segmentControl.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        
        topConstraint.isActive = true
        leftConstraint.isActive = true
        rightConstraint.isActive = true
    }
    
    @IBAction func mapTypeChange(_ sender:UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .hybrid
        case 2:
            mapView.mapType = .satellite
        default:
            mapView.mapType = .standard
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}
