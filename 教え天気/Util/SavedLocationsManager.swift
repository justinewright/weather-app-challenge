//
//  SavedLocationsManager.swift
//  教え天気
//
//  Created by Justine Wright on 2021/09/08.
//

import Foundation
import CoreLocation
import Combine

extension LocationRepo {
    
}

extension Publishers {

    public struct SavedLocationPublisher: Publisher {
        public typealias Output = CLLocationCoordinate2D
        public typealias Failure = Never

        public func receive<S>(subscriber: S) where S: Subscriber, Self.Failure == S.Failure, Self.Output == S.Input {
            let subscription = SavedLocationSubscription(subscriber: subscriber)
            subscriber.receive(subscription: subscription)
        }

        final class SavedLocationSubscription<S: Subscriber>: NSObject, CLLocationManagerDelegate, Subscription where S.Input == Output, S.Failure == Failure {

            private var subscriber: S?
            private var locationManager = CLLocationManager()
            // todo make a delegate to save location

            init(subscriber: S) {
                super.init()
                self.subscriber = subscriber

            }

            func request(_ demand: Subscribers.Demand) {

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

