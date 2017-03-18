//
//  MovieDetailViewController.swift
//  demo-swift-iscte
//
//  Created by Filipe Patricio on 17/03/2017.
//  Copyright © 2017 Filipe Patricio. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import Gloss

class MovieDetailViewController: UIViewController {
  
  @IBOutlet weak var imageView: UIImageView!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var actorsLabel: UILabel!
  @IBOutlet weak var directorLabel: UILabel!
  @IBOutlet weak var genreLabel: UILabel!
  @IBOutlet weak var yearLabel: UILabel!
  @IBOutlet weak var ratingLabel: UILabel!
  @IBOutlet weak var plotLabel: UILabel!
  
  var movieResult: MovieResult?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    guard let movieResult = self.movieResult else{
      print("movieResult is expected")
      return
    }
    // Set movie title to navigationBar:
    self.navigationItem.title = movieResult.title 
    self.getMovie(withImdbId: movieResult.imdbId)
  }
  
  //MARK: - Request (full) movie by id
  func getMovie(withImdbId imdbId: String){
    Alamofire.request("https://www.omdbapi.com/?i=\(imdbId)").responseJSON { response in
      debugPrint(response)
      
      if let json = response.result.value as? JSON {
        print("JSON: \(json)")
        let movie = Movie(json: json)!
        self.fillMovieInfo(withMovie: movie)
      }
    }
  }
  
  //MARK: - Fill movie info to Views
  func fillMovieInfo(withMovie movie:Movie){
    self.imageView.af_setImage(withURL: URL(string: movie.poster!)!, placeholderImage: #imageLiteral(resourceName: "movie-icon"))
    self.titleLabel.text = movie.title ?? "Title not set"
    self.actorsLabel.text = movie.actors ?? "Actors not set"
    self.directorLabel.text = movie.director ?? "Director not set"
    self.genreLabel.text = movie.genre ?? "Genre not set"
    self.yearLabel.text = movie.year ?? "Year not set"
    self.ratingLabel.text = movie.imdbRating ?? "Rating not set"
    self.plotLabel.text = movie.plot ?? "Plot not set"
  }
  
}
