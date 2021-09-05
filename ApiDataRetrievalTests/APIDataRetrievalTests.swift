//
//  DataRetrievalTests.swift
//  DataRetrievalTests
//
//  Created by Justine Wright on 2021/09/02.
//

import XCTest
import Combine
import CoreLocation

extension XCTestCase {
    func load<T: Decodable>(_ filename: String) -> T {
        let data: Data

        guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle")
        }

        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("Couldn't load \(filename) from main bundle: \n\(error)")
        }
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
        }
    }

    func await<T: Publisher>(
        _ publisher: T,
        timeout: TimeInterval = 10,
        file: StaticString = #file,
        line: UInt = #line
    ) throws -> T.Output {
        // This time, we use Swift's Result type to keep track
        // of the result of our Combine pipeline:
        var result: Result<T.Output, Error>?
        let expectation = self.expectation(description: "Awaiting publisher")

        let cancellable = publisher.sink(
            receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    result = .failure(error)
                case .finished:
                    break
                }

                expectation.fulfill()
            },
            receiveValue: { value in
                result = .success(value)
            }
        )

        // Just like before, we await the expectation that we
        // created at the top of our test, and once done, we
        // also cancel our cancellable to avoid getting any
        // unused variable warnings:
        waitForExpectations(timeout: timeout)
        cancellable.cancel()

        // Here we pass the original file and line number that
        // our utility was called at, to tell XCTest to report
        // any encountered errors at that original call site:
        let unwrappedResult = try XCTUnwrap(
            result,
            "Awaited publisher did not produce any output",
            file: file,
            line: line
        )

        return try unwrappedResult.get()
    }
}

enum WeatherError: Error {
    case thingsJustHappen
}

class APIDataRetrievalTests: XCTestCase {

    var repo: Repository!
    var mockWeatherClientApi: MockWeatherApiClient!

    override func setUp() {
        mockWeatherClientApi = MockWeatherApiClient()
        repo = Repository(weatherApiClient:  mockWeatherClientApi)
    }
    
    func testSuccessfulApiCallReturnUpdatesRepositoryWeatherForecastWithMockedWeatherData() throws {
        let weatherData: WeatherData = load("mockData.json")

        let observer = repo.$weatherForecast
            .collect(1)
            .first()

        mockWeatherClientApi.fetch(long: 0, lat: 0)
        mockWeatherClientApi.mockServer.send(weatherData)

        let updatedWeather = try `await` (observer)

        XCTAssertEqual(updatedWeather.count, 1)
        let model = updatedWeather.last?.first

        XCTAssertEqual(model?.temperature, 20.31)
        XCTAssertEqual(model?.minTemperature, 19.57)
        XCTAssertEqual(model?.maxTemperature, 21.11)
        XCTAssertEqual(model?.conditionName, "cloud.sun.rain")
        XCTAssertEqual(model?.icon, "10d")
        XCTAssertEqual(model?.dayOfWeekEnglish, "Thu")
    }

    func testFailureApiCallReturnUpdatesRepositoryWeatherForecastWithDefault() throws {

        let observer = repo.$weatherForecast
            .collect(1)
            .first()

        mockWeatherClientApi.fetch(long: 0, lat: 0)
        mockWeatherClientApi.mockServer.send(completion: .failure(WeatherError.thingsJustHappen))

        let updatedWeather = try `await` (observer)

        XCTAssertEqual(updatedWeather.count, 1)
        let model = updatedWeather.last?.first

        XCTAssertEqual(model?.temperature, 0)
        XCTAssertEqual(model?.minTemperature, 0)
        XCTAssertEqual(model?.maxTemperature, 0)
        XCTAssertEqual(model?.conditionName, "wifi.slash")
    }
}
