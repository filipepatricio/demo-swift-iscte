//
//  Movie.swift
//  demo-swift-iscte
//
//  Created by Filipe Patricio on 17/03/2017.
//  Copyright © 2017 Filipe Patricio. All rights reserved.
//

import UIKit
import Gloss

struct Movie {
  //TODO: with full movie
}

struct MovieResult {
  
  let poster: String?
  let title: String
  let type: String
  let year: String
  let imdbId: String
  // MARK: - Deserialization
  
  init?(json: JSON) {
    self.poster = "Poster" <~~ json
    guard let title: String = "Title" <~~ json,
      let type: String = "Type" <~~ json,
      let year: String = "Year" <~~ json,
      let imdbId: String = "imdbID" <~~ json
      else {
        print("It miss some values to deserialization of MovieResult")
        return nil
    }
    
    self.title = title
    self.type = type
    self.year = year
    self.imdbId = imdbId
  }
  
}

struct MoviesSearchResult {
  
  var movieResults: [MovieResult] = []
  // MARK: - Deserialization
  
  init?(json: JSON) {
    guard let searchResultJson: [JSON] = "Search" <~~ json else { return nil }
    
    for movieResultJson in searchResultJson {
      if let movieResult = MovieResult(json: movieResultJson) {
        self.movieResults.append(movieResult)
      }
    }
    
  }
  
}
