//
//  LocationSearchBarViewController.swift
//  教え天気(1)
//
//  Created by Justine Wright on 2021/09/16.
//  
//

import UIKit
import MapKit
import CoreLocation

class LocationSearchBarViewController: UIViewController {

    private lazy var searchBar = UISearchBar()
    private lazy var searchResultsTable = UITableView()

    var searchCompleter = MKLocalSearchCompleter()
    var searchResults = [MKLocalSearchCompletion]()

    var callback: ((_ address: String, _ coordinate: CLLocationCoordinate2D) -> Void)?

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        searchCompleter.delegate = self
        searchBar.delegate = self
        searchResultsTable.delegate = self
        searchResultsTable.dataSource = self
    }

    private func setupViews() {
        self.view.addSubview(searchBar)

        self.view.addSubview(searchResultsTable)
        setupConstraints()
    }

    private func setupConstraints() {
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 50)
        ])

        searchResultsTable.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchResultsTable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchResultsTable.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchResultsTable.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            searchResultsTable.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension LocationSearchBarViewController: UISearchBarDelegate, MKLocalSearchCompleterDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            searchCompleter.queryFragment = searchText
        }

    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
            searchResults = completer.results
            searchResultsTable.reloadData()
        }

    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        }

}

extension LocationSearchBarViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }

        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return searchResults.count
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let searchResult = searchResults[indexPath.row]
            let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
            cell.textLabel?.text = searchResult.title
            cell.detailTextLabel?.text = searchResult.subtitle
            return cell
        }
}

extension LocationSearchBarViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let result = searchResults[indexPath.row]
        let searchRequest = MKLocalSearch.Request(completion: result)

        let search = MKLocalSearch(request: searchRequest)
        search.start { (response, _) in
            guard let coordinate = response?.mapItems[0].placemark.coordinate else {
                return
            }

            guard let countryCode = response?.mapItems[0].placemark.countryCode else {
                return
            }
            guard let city = response?.mapItems[0].placemark.locality else {
                return
            }
            self.callback?("\(city), \(countryCode)", coordinate)
        }
    }
}
