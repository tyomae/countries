//
//  MapTableViewCell.swift
//  CountriesApp
//
//  Created by Артем  Емельянов  on 08.11.2020.
//

import UIKit
import MapKit

class MapTableViewCell: UITableViewCell, MKMapViewDelegate, ConfigurableView {
	
	@IBOutlet weak var mapView: MKMapView!
	
	func configure(with model: MapCellViewModel) {
		self.coordinates = CLLocationCoordinate2D(latitude: model.latitude, longitude: model.longitude)
	}
	
	var coordinates: CLLocationCoordinate2D? {
		didSet {
			guard let coordinates = coordinates else { return }
			let hotelPosition = MKPointAnnotation()
			hotelPosition.coordinate = coordinates
			mapView.addAnnotation(hotelPosition)
			mapView.centerCoordinate = coordinates
			let viewRegion = MKCoordinateRegion(center: coordinates, latitudinalMeters: 1200000, longitudinalMeters: 1200000)
			mapView.setRegion(viewRegion, animated: false)
		}
	}
	
	override func awakeFromNib() {
		super.awakeFromNib()
		
		mapView.delegate = self
	}
	
	func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
		guard annotation is MKPointAnnotation else { return nil }
		
		let identifier = "Annotation"
		var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
		if annotationView == nil {
			annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
			annotationView!.canShowCallout = true
		} else {
			annotationView?.annotation = annotation
		}
		return annotationView
	}
}
