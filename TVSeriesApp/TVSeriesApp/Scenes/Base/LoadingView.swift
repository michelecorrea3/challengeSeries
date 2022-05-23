//
//  LoadingView.swift
//  TVSeriesApp
//
//  Created by Michele de Olivio Corrêa on 21/05/22.
//

import UIKit

public class LoadingView {
    
    // MARK: - UI Properties
    
    var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        view.alpha = 1.0
        return view
    }()
    
    var indicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.style = UIActivityIndicatorView.Style.large
        view.startAnimating()
        view.color = .darkGray
        return view
    }()

    // MARK: - Public methods

    func showIndicator(in view: UIView) {
        contentView.frame = view.bounds
        indicatorView.center = contentView.center

        view.addSubview(self.contentView)
        view.addSubview(self.indicatorView)
    }
    
    func hideIndicator() {
        contentView.removeFromSuperview()
        indicatorView.removeFromSuperview()
    }
}
