//
//  ViewController.swift
//  TreasureHunt
//
//  Created by datdn1 on 12/7/15.
//  Copyright © 2015 datdn1. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var treasures = [Treasure]()
    
    var foundLocations = [Location]()
    var polyline: MKPolyline!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.treasures = [
            HistoryTreasure(what: "Google's first office", year: 1999,
                lat: 37.44451, long: -122.163369),
            HistoryTreasure(what: "Facebook's first office", year: 2005,
                    lat: 37.444268, long: -122.163271),
            FactTreasure(what: "Stanford University",
                fact: "Founded in 1885 by Leland Stanford.",
                lat: 37.427474, long: -122.169719),
            FactTreasure(what: "Moscone West",fact: "Host to WWDC since 2003.",
                        lat: 37.783083, long: -122.404025),
            FactTreasure(what: "Computer History Museum", fact: "Home to a working Babbage Difference Engine.", lat: 37.414371, long: -122.076817),
            HQTreasure(company: "Apple",
                lat: 37.331741, long: -122.030333),
            HQTreasure(company: "Facebook",lat: 37.485955, long: -122.148555),
            HQTreasure(company: "Google",
                    lat: 37.422, long: -122.084)
        ]
        
        self.mapView.delegate = self
        self.mapView.addAnnotations(self.treasures)
        
        let rectToDisplay = self.treasures.reduce(MKMapRectNull) { (var rect: MKMapRect, treasure:Treasure) -> MKMapRect in
            let rectTreasure = MKMapRectMake(treasure.location.mapPoint.x, treasure.location.mapPoint.y, 0, 0)
            rect = MKMapRectUnion(rect, rectTreasure)
            return rect
        }
        self.mapView.setVisibleMapRect(rectToDisplay, edgePadding: UIEdgeInsets(top: 74, left: 10, bottom: 10, right: 10), animated: true)
    }
    
    override func didReceiveMemoryWarning() {
                super.didReceiveMemoryWarning()
    }
    
}


extension ViewController: MKMapViewDelegate {
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if let treasure = view.annotation as? Treasure {
            if let alertable = treasure as? Alertable {
               let alert = alertable.alert()
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                let findNearestLocationAction = UIAlertAction(title: "Find Nearest", style: .Default, handler: { (action) -> Void in
                        // sort treasure by selected annotation
                        var sortedTreasure = self.treasures
                        let sorted = sortedTreasure.sort({ (treasure1: Treasure, treasure2: Treasure) -> Bool in
                            let distanceFromTreasure1 = treasure.location.distanceBetween(treasure1.location)
                            let distanceFromTreasure2 = treasure.location.distanceBetween(treasure2.location)
                            return distanceFromTreasure1 < distanceFromTreasure2
                        })
                        // deselect current annotation
                        self.mapView.deselectAnnotation(view.annotation, animated: true)
                        // select nearest annotation
                        self.mapView.selectAnnotation(sorted[1], animated: true)
                    })
                alert.addAction(findNearestLocationAction)
                
                alert.addAction(UIAlertAction(title: "Found", style: UIAlertActionStyle.Default, handler: { (action) -> Void in
                        self.markTreasureAsFound(treasure)
                    }))
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }
    }
        
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if let treasure = annotation as? Treasure {
            var view = mapView.dequeueReusableAnnotationViewWithIdentifier("pin") as? MKPinAnnotationView
            if view == nil {
                view = MKPinAnnotationView(annotation: treasure, reuseIdentifier: "pin")
                view?.canShowCallout = true
                view?.animatesDrop = false
                view?.calloutOffset = CGPoint(x: -10, y: 5)
                view?.rightCalloutAccessoryView = UIButton(type: .DetailDisclosure) as UIView
                view?.pinColor = treasure.pinColor()
            }
            else {
                view?.annotation = treasure
            }
            return view
        }
        return nil
    }
        
        func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer! {
                if let polyline = overlay as? MKPolyline {
                    let render = MKPolylineRenderer(polyline: polyline)
                    render.strokeColor = UIColor.blueColor()
                    return render
                }
                return nil
        }
        
        func markTreasureAsFound(treasure: Treasure) {
                    if let index = self.foundLocations.indexOf({ (lo:Location) -> Bool in
                        return treasure.location == lo
                        }) {
                let alert = UIAlertController(title: "Oops!", message: "You've already found this treasure (at step \(index + 1))! Try again!", preferredStyle: .Alert)
                alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
            }
            else {
                self.foundLocations.append(treasure.location)
                
                if self.polyline != nil {
                    self.mapView.removeOverlay(self.polyline)
                }
                
                var coordinates = self.foundLocations.map {
                    $0.coordinate
                }
                
                self.polyline = MKPolyline(coordinates: &coordinates, count: coordinates.count)
                self.mapView.addOverlay(self.polyline)
            }

        }
}

