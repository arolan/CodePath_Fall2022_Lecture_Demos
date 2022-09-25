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
    
    @IBOutlet var movieOverview: UITextView!
    @IBOutlet var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let movie = movie else {
            return
        }
        
        navigationItem.title = movie.title
        movieOverview.text = movie.overview
        
        loadImage()
        
//        let webViewController = WebViewController()
//        present(webViewController,
//                animated: true)
    }
    
    private func loadImage() {
        guard let imageUrl = movie?.getLargeImageUrl(),
                let url = URL(string: imageUrl) else {
            return
        }
        
        DispatchQueue(label: "image").async { [weak self] in
            if let imageData = try? Data(contentsOf: url) {
                if let image = UIImage(data: imageData) {
                    DispatchQueue.main.async {
                        self?.imageView.image = image
                    }
                }
            }
        }
    }
}
