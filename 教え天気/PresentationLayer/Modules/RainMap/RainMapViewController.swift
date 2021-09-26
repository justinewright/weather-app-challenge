//
//  RainMapViewController.swift
//  教え天気
//
//  Created by Justine Wright on 2021/09/26.
//  
//

import UIKit
import MapKit
import Combine

class WeatherMapOverlay: NSObject, MKOverlay {
  let coordinate: CLLocationCoordinate2D
  let boundingMapRect: MKMapRect

    init(midCoordinate: CLLocationCoordinate2D, boundingRect: MKMapRect) {
    boundingMapRect = boundingRect
    coordinate = midCoordinate
  }
}
class WeatherMapOverlayView: MKOverlayRenderer {
  let overlayImage: UIImage

  // 1
  init(overlay: MKOverlay, overlayImage: UIImage) {
    self.overlayImage = overlayImage
    super.init(overlay: overlay)
  }

  // 2
  override func draw(
    _ mapRect: MKMapRect,
    zoomScale: MKZoomScale,
    in context: CGContext
  ) {
    guard let imageReference = overlayImage.cgImage else { return }

    let rect = self.rect(for: overlay.boundingMapRect)
    context.scaleBy(x: 1.0, y: -1.0)
    context.translateBy(x: 0.0, y: -rect.size.height)
    context.draw(imageReference, in: rect)
  }
}

class RainMapViewController: UIViewController {

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView = MKMapView()
        view = mapView
        mapView.delegate = self
        api = OpenWeatherMapsWeatherMapsApiClient()
        showRegion(location: locationCoordinates[0])

        cancellable = api.listen()
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [self] image in
                guard let image = image else {
                    api.fetch(x: 1, y: 1, z: 0)
                    return
                }
                let overlay = WeatherMapOverlay(midCoordinate: self.mapView.centerCoordinate, boundingRect: self.boundMapRect)

                DispatchQueue.main.async {
                    self.imageOverlay = image
                    self.mapView.addOverlay(overlay)
                }
            })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    // MARK: - Properties
    var presenter: ViewToPresenterRainMapProtocol?
    private var mapView: MKMapView!
    private var regionRadius: Double = 10000.0
    private var z : Double = 0.0
    private var api: OpenWeatherMapsWeatherMapsApiClient!
    private var boundMapRect: MKMapRect!
    private var cancellable: AnyCancellable!
    private var imageOverlay: UIImage?

}

extension RainMapViewController: PresenterToViewRainMapProtocol{
    // TODO: Implement View Output Methods
    func showRegion(location: CLLocationCoordinate2D) {
        let region = MKCoordinateRegion(center: location, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius )
        mapView.region = region
        mapView.mapType = .standard
        boundMapRect = MKMapRect(origin: MKMapPoint(location), size: MKMapSize(width: Double(mapView.frame.width), height: Double(mapView.frame.height)))
    }
}

extension RainMapViewController: MKMapViewDelegate {
    func mapViewWillStartRenderingMap(_ mapView: MKMapView) {
        print("rending")
    }

    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is WeatherMapOverlay {
            return WeatherMapOverlayView(overlay: overlay, overlayImage: (imageOverlay ?? UIImage(systemName: "sun.max")!))
        }
        return MKOverlayRenderer()
    }

}
