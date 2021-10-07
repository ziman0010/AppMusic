//
//  SearchViewController.swift
//  AppMusic
//
//  Created by Алексей Черанёв on 02.10.2021.
//

import UIKit
import Alamofire

class SearchViewController: UITableViewController {
    
    private var timer: Timer?
    let searchController = UISearchController(searchResultsController: nil)
    
    var tracks = [Track]()
    
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
        cell.textLabel?.text = " \(String(describing: track.trackName)) \n\(track.artistName)"
        cell.textLabel?.numberOfLines = 0
        cell.imageView?.image = #imageLiteral(resourceName: "Image")
        return cell
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { _ in
            let url = "https://itunes.apple.com/search"
            let parameters = ["term": "\(searchText)", "limit" : "10"]
            
            AF.request(url,
                       method: .get,
                       parameters: parameters,
                       encoding: URLEncoding.default,
                       headers: nil).responseData { dataResponse in
                        if let error = dataResponse.error
                        {
                            print("error received requesting data: \(error.localizedDescription)")
                            return
                        }
                        guard let data = dataResponse.data else
                        {
                            return
                        }
                        
                        print(data.description)
                        
                        let decoder = JSONDecoder()
                        do {
                            let objects = try decoder.decode(SearchResponse.self, from: data)
                            self.tracks = objects.results
                            self.tableView.reloadData()
                        } catch let jsonError {
                            print("Failed to decode JSON", jsonError)
                        }
                       }
        })
        
        
    }
}
