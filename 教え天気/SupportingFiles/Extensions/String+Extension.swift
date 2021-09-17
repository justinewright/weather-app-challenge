//
//  String+Extension.swift
//  教え天気(1)
//
//  Created by Justine Wright on 2021/09/14.
//

import CoreLocation

extension String {
    func coordinate(completion: @escaping(_ coordinate: CLLocationCoordinate2D?, _ error: Error?) -> Void ) {
        CLGeocoder().geocodeAddressString(self) { completion($0?.first?.location?.coordinate, $1) }
    }
}
