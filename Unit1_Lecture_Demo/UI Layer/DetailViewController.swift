//
//  DetailViewController.swift
//  Unit1_Lecture_Demo
//
//  Created by Rolan on 9/13/22.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    var movie: Movie?
    
    @IBOutlet var movieTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let movie = movie else {
            return
        }
        
        movieTitle.text = movie.title
        
//        if let movie = movie {
//
//        }
    }
}
