//
//  DetailViewController.swift
//  Unit1_Lecture_Demo
//
//  Created by Rolan on 9/13/22.
//

import Foundation
import UIKit
import Lottie

class DetailViewController: UIViewController {
    var movie: Movie?
    
    @IBOutlet var movieOverview: UITextView!
    @IBOutlet var imageView: UIImageView!
    //@IBOutlet var animationView: AnimationView!
    var animationView: AnimationView?
    
    private func setupLottieAnimation() {
        // 2. Start AnimationView with animation name (without extension)
        animationView = .init(name: "4762-food-carousel")
        
        guard let animationView = animationView else {
            return
        }
        
        animationView.frame = view.bounds
        
        // 3. Set animation content mode
        
        animationView.contentMode = .scaleAspectFit
        
        // 4. Set animation loop mode
        animationView.loopMode = .playOnce
        
        // 5. Adjust animation speed
        animationView.animationSpeed = 0.25

        
        view.addSubview(animationView)
        
        // 6. Play animation
        animationView.play()
    }
    
    private func setupKeyframeAnimations() {
        let startPosition = imageView.center

        UIView.animateKeyframes(withDuration: 5,
                                delay: 0,
                                options: .calculationModeCubicPaced, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.5) {
                self.imageView.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            }

            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5) {
                self.imageView.center = CGPoint(x: self.view.bounds.midX, y: self.view.bounds.maxY)
            }

            UIView.addKeyframe(withRelativeStartTime: 1, relativeDuration: 0.5) {
                self.imageView.center = CGPoint(x: self.view.bounds.width, y: startPosition.y)
            }

            UIView.addKeyframe(withRelativeStartTime: 1.5, relativeDuration: 0.5) {
                self.imageView.center = startPosition
            }
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        setupKeyframeAnimations()
        setupLottieAnimation()
        
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
        
        imageView.showAnimatedGradientSkeleton()
        
        DispatchQueue(label: "image").async { [weak self] in
            if let imageData = try? Data(contentsOf: url) {
                if let image = UIImage(data: imageData) {
                    DispatchQueue.main.async {
                        self?.imageView.image = image
                        self?.imageView.hideSkeleton()
                    }
                }
            }
        }
    }
}
