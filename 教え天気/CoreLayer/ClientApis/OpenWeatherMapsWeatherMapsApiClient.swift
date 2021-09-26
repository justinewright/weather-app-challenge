//
//  OpenWeatherMapsWeatherMapsApiClient.swift
//  教え天気
//
//  Created by Justine Wright on 2021/09/26.
//

import Foundation
import Combine
import UIKit

class OpenWeatherMapsWeatherMapsApiClient: ObservableObject {
    @Published private(set) var image: UIImage?
    private var cancellable = Set<AnyCancellable>()

    private let apiURL = " https://tile.openweathermap.org/map"
    private let layer = "precipitation_new"
    private let appIDParam = "appid=cc6410932cff63f7d50d5c52d6ea4903"

    init() {
    }

    func fetch(x: Double, y: Double, z: Double) {

        if let url = URL(string: "https://images.unsplash.com/photo-1453728013993-6d66e9c9123a?ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8dmlld3xlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&w=1000&q=80") {
            URLSession
                .DataTaskPublisher(request: URLRequest(url: url),
                                   session: URLSession(configuration: .default))
                .retry(3)
                .map { UIImage(data: $0.data) }
                .replaceError(with: nil)
                .receive(on: DispatchQueue.main)
                .assign(to: \.image, on: self)
                .store(in: &cancellable)
            }
    }

    func listen() -> AnyPublisher<UIImage?, Never> {
        $image.eraseToAnyPublisher()
    }

    private func apiLink(x: Int, y: Int, z: Int) -> String {
        "\(apiURL)/\(layer)/\(1)/\(1)/\(1).png?\(appIDParam)"
    }

}
