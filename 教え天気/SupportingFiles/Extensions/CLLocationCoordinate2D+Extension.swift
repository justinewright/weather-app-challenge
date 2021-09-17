//
//  CLLocationCoordinate2D+Extension.swift
//  教え天気(1)
//
//  Created by Justine Wright on 2021/09/14.
//

import CoreLocation

extension CLLocationCoordinate2D {
    func address(completion: @escaping (_ city: String?, _ country: String?, _ error: Error?) -> Void ) {
        CLGeocoder().reverseGeocodeLocation(CLLocation(latitude: self.latitude, longitude: self.longitude)) { completion($0?.first?.locality, $0?.first?.isoCountryCode, $1) }
    }
}
