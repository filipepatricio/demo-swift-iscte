//
//  Movie.swift
//  demo-swift-iscte
//
//  Created by Filipe Patricio on 17/03/2017.
//  Copyright © 2017 Filipe Patricio. All rights reserved.
//

import UIKit
import Gloss

//MARK: - Models
struct Movie {
  let actors: String?
  let awards: String?
  let country: String?
  let director: String?
  let genre: String?
  let language: String?
  let metascore: String?
  let plot: String?
  let poster: String?
  let rated: String?
  let released: String?
  let runtime: String?
  let title: String?
  let type: String?
  let writer: String?
  let year: String?
  let imdbId: String?
  let imdbRating: String?
  let imdbVotes: String?
  // MARK: - Deserialization
  
  init?(json: JSON) {
    self.actors = "Actors" <~~ json
    self.awards = "Awards" <~~ json
    self.country = "Country" <~~ json
    self.director = "Director" <~~ json
    self.genre = "Genre" <~~ json
    self.language = "Language" <~~ json
    self.metascore = "Metascore" <~~ json
    self.plot = "Plot" <~~ json
    self.poster = "Poster" <~~ json
    self.rated = "Rated" <~~ json
    self.released = "Released" <~~ json
    self.runtime = "Runtime" <~~ json
    self.title = "Title" <~~ json
    self.type = "Type" <~~ json
    self.writer = "Writer" <~~ json
    self.year = "Year" <~~ json
    self.imdbId = "imdbID" <~~ json
    self.imdbRating = "imdbRating" <~~ json
    self.imdbVotes = "imdbVotes" <~~ json
  }
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
