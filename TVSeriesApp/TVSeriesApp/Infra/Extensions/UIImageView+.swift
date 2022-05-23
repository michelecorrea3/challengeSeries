//
//  UIImageView+.swift
//  TVSeriesApp
//
//  Created by Michele de Olivio Corrêa on 21/05/22.
//

//<a href="https://www.flaticon.com/free-icons/error" title="error icons">Error icons created by mim_studio - Flaticon</a>
import Foundation

import Alamofire

extension UIImageView {
    func downloadImageFrom(url: String) {
        DispatchQueue.main.async {
            AF.request(url, method: .get).responseData { result in
                let data = result.data ?? Data()
                self.image = UIImage(data: data) ?? UIImage(named: "imageNotFound")
            }
        }
    }
}
