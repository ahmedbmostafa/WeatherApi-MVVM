//
//  WeatherVC+LocationEx.swift
//  WeatherApp
//
//  Created by AhmedHD_SL on 08/11/2022.
//

import UIKit
import CoreLocation
import MapKit

extension WeatherVC: CLLocationManagerDelegate {
    
    func getCurrentUserLocation() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestAlwaysAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = manager.location else {
            print("Warning: location is nil")
            return
        }
        let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
        let region = MKCoordinateRegion(center: location.coordinate, span: span)
        mapView.setRegion(region, animated: true)
        getLocationName(location: location)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func getLocationName(location: CLLocation) {
        fetchCityAndCountry(from: location) {[weak self] country, error in
            guard let self = self else {return}
            guard let country = country, error == nil else {
                print("Error occurred while fetching city and country")
                return
            }
            
            if self.shouldUpdate {
                self.viewModel.didLoad(countery: country)
            }
            
        }
    }
    
    func fetchCityAndCountry(from location: CLLocation, completion: @escaping (_ city: String?, _ error: Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            completion(placemarks?.first?.country, error)
        }
    }
    
}
