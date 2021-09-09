//
//  LocationViewModel.swift
//  教え天気
//
//  Created by Justine Wright on 2021/08/31.
//

import Foundation
import CoreLocation
import Combine

extension CLLocationCoordinate2D {
    func getCity(completion: @escaping (_ city: String?,_ country: String?, _ error: Error?) -> Void ) {
        CLGeocoder().reverseGeocodeLocation(CLLocation(latitude: self.latitude, longitude: self.longitude)) { completion($0?.first?.locality, $0?.first?.country, $1) }
    }
}

extension String {
    func getCoordinate(completion: @escaping(_ coordinate: CLLocationCoordinate2D?, _ error: Error?) -> Void ) {
        CLGeocoder().geocodeAddressString(self) { completion($0?.first?.location?.coordinate, $1) }
    }
}
