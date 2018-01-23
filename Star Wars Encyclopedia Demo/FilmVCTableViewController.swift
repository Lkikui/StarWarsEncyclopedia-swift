//
//  PeopleViewController.swift
//  Star Wars Encyclopedia Demo
//
//  Created by Lisa Ryland on 1/22/18.
//

import UIKit
class FilmVCTableViewController: UITableViewController {
    // Hardcoded data for now
    var movies = [NSDictionary]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        StarWarsModel.getAllFilms(completionHandler: { // passing what becomes "completionHandler" in the 'getAllFilms' function definition in StarWarsModel.swift
            data, response, error in
            do {
                // Try converting the JSON object to "Foundation Types" (NSDictionary, NSArray, NSString, etc.)
                if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                    if let results = jsonResult["results"] as? NSArray {
                        for film in results {
                            let filmDict = film as! NSDictionary
                            self.movies.append(filmDict)
                        }
                    }
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch {
                print("Something went wrong")
            }
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // if we return - sections we won't have any sections to put our rows in
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // return the count of people in our data array
        return movies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "filmTitleCell", for: indexPath)
        let film = movies[indexPath.row].value(forKey: "title") as! String
        cell.textLabel?.text = film
        
        // return cell so that Table View knows what to draw in each row
        return cell
    }
    
}




