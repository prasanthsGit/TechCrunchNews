//
//  Extensions.swift
//  TechCrunchNews
//
//  Created by pankaj bandewar on 02/08/22.
//

import Foundation
import UIKit
import NVActivityIndicatorView
import Kingfisher

// MARK: - UIViewController
extension UIViewController: NVActivityIndicatorViewable {
    // LOADER
    func startPreloader() {
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(ActivityData(size: CGSize(width: 40, height: 40), type: .lineScale, color: UIColor.red, backgroundColor: .clear))
    }

    func stopPreloder() {
        NVActivityIndicatorPresenter.sharedInstance.stopAnimating(NVActivityIndicatorView.DEFAULT_FADE_OUT_ANIMATION)
    }
}

// MARK: - dowloadImageFromServer
extension UIImageView {
    func load(url: String, placeholder: UIImage? = UIImage(named: "")) {
        if let imgUrl = URL(string: url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "") {
            let processor = DownsamplingImageProcessor(size: frame.size)
            kf.indicatorType = .activity
            kf.setImage(with: imgUrl, placeholder: placeholder, options: [.processor(processor), .scaleFactor(UIScreen.main.scale), .transition(.fade(1)), .cacheOriginalImage])
        }
    }
}
