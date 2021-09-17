//
//  Publisher+Extension.swift
//  教え天気(1)
//
//  Created by Justine Wright on 2021/09/15.
//

import Combine
import CoreLocation

extension Publishers {

    public struct LocationPublisher: Publisher {
        public typealias Output = CLLocationCoordinate2D
        public typealias Failure = Never

        public func receive<S>(subscriber: S) where S: Subscriber, Self.Failure == S.Failure, Self.Output == S.Input {
            let subscription = LocationSubscription(subscriber: subscriber)
            subscriber.receive(subscription: subscription)
        }

        final class LocationSubscription<S: Subscriber>: NSObject, CLLocationManagerDelegate, Subscription where S.Input == Output, S.Failure == Failure {

            private var subscriber: S?
            private var locationManager = CLLocationManager()
            init(subscriber: S) {
                super.init()
                self.subscriber = subscriber

                locationManager.desiredAccuracy = kCLLocationAccuracyBest
                locationManager.distanceFilter = kCLDistanceFilterNone
                locationManager.delegate = self
            }

            func request(_ demand: Subscribers.Demand) {
                locationManager.startUpdatingLocation()
                locationManager.requestWhenInUseAuthorization()
            }

            func cancel() {
                locationManager.stopUpdatingLocation()
            }

            func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
                for location in locations {
                    _ = subscriber?.receive(location.coordinate)
                }
            }
        }
    }
}
