//
//  ViewController.swift
//  demo-swift-iscte
//
//  Created by Filipe Patricio on 17/03/2017.
//  Copyright © 2017 Filipe Patricio. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import Gloss

class ViewController: UIViewController {
  
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var textField: UITextField!
  @IBOutlet weak var tableView: UITableView!
  
  var movieResults: [MovieResult] = []
  var movieSelectedIndex: Int?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }
  
  //MARK: - Search button action
  @IBAction func changeTitleAction(_ sender: Any) {
    //    self.titleLabel.text = self.textField.text
    guard let title = self.textField.text else{
      print("self.textField.text shouldn't be nil")
      return
    }
    
    self.getMovies(withTitle:title)
  }
  
  //MARK: - Network Request To Search Movie by title
  func getMovies(withTitle title:String){
    let titleEndoded = title.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    Alamofire.request("https://www.omdbapi.com/?s=\(titleEndoded)").responseJSON { response in
      debugPrint(response)
      
      if let json = response.result.value as? JSON {
        print("JSON: \(json)")
        let searchResult = MoviesSearchResult(json: json)
        if let movieResults = searchResult?.movieResults{
          self.movieResults = movieResults
        }else{
          print("No Results")
          self.movieResults = []
        }
        self.tableView.reloadData()
      }
    }
  }
  
}


extension ViewController: UITableViewDataSource{
  //MARK: - Required to table's row
  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
    return self.movieResults.count
  }
  
  //MARK: - Customize Cell
  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
    
    let cell: UITableViewCell = UITableViewCell (style: UITableViewCellStyle.subtitle, reuseIdentifier: "subtitleCell")
    
    cell.textLabel?.text = self.movieResults[indexPath.row].title
    cell.detailTextLabel?.text =  self.movieResults[indexPath.row].year
    if let poster = self.movieResults[indexPath.row].poster{
      
      let imageUrl = URL(string: poster)!
      cell.imageView?.af_setImage(withURL: imageUrl, placeholderImage: #imageLiteral(resourceName: "movie-icon"))
    }
    
    return cell
  }
  
  //MARK: - Tap on cell action (Navigation)
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    NSLog("You selected cell number: \(indexPath.row)!")
    self.movieSelectedIndex = indexPath.row
    self.performSegue(withIdentifier: "ShowMovieDetail", sender: self)
    tableView.cellForRow(at: indexPath)?.isSelected = false
    
  }
}

extension ViewController: UITableViewDelegate{}


extension ViewController: UINavigationControllerDelegate{
  //MARK: - Pass movie to MovieDetailViewController throw navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let destinationSegue = segue.destination as? MovieDetailViewController,
      let movieSelectedIndex = self.movieSelectedIndex else {
        print("MovieDetailViewController and movieSelectedIndex are expected")
        return
    }
    
    destinationSegue.movieResult = self.movieResults[movieSelectedIndex]
  }
  
}

