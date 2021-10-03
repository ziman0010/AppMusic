//
//  SearchViewController.swift
//  AppMusic
//
//  Created by Алексей Черанёв on 02.10.2021.
//

import UIKit
import Alamofire

struct TrackModel {
    var trackName: String
    var bandName: String
    
}

class SearchViewController: UITableViewController {
    
    let searchController = UISearchController(searchResultsController: nil)
    let tracks = [TrackModel(trackName: "bad guy", bandName: "Billy Eilish"), TrackModel(trackName: "bury a friend", bandName: "Billie Eilish")]
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        
        setupSearchBar()
    }
    
    private func setupSearchBar() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        
        let track = tracks[indexPath.row]
        cell.textLabel?.text = " \(track.trackName) \n\(track.bandName)"
        cell.textLabel?.numberOfLines = 2
        cell.imageView?.image = #imageLiteral(resourceName: "Image")
        return cell
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        let url = "https://itunes.apple.com/search?term=\(searchText)"
        AF.request(url).responseData { (dataResponse) in
            if let error = dataResponse.error
            {
                print("error received requesting data: \(error.localizedDescription)")
                return
            }
            guard let data = dataResponse.data else
            {
                return
            }
            let someString  = String(data: data, encoding: .utf8)
            print(someString)
        }
        
    }
}
