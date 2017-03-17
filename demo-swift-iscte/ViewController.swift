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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func changeTitleAction(_ sender: Any) {
    //    self.titleLabel.text = self.textField.text
    guard let title = self.textField.text else{
      print("self.textField.text shouldn't be nil")
      return
    }
    
    self.getMovies(withTitle:title)
  }
  
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
  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
    return self.movieResults.count
  }
  
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
}


extension ViewController: UITableViewDelegate{
  
}

