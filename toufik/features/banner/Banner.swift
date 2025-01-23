//
//  Banner.swift
//  toufik
//
//  Created by Ratul Sharker on 6/3/21.
//

import Foundation
import UIKit

class Banner {
    
    public static let sharedInstance = Banner()
    
    private var bannerConfigured = false
    
    private var bottomBannerView : BottomBannerView
    private var topBannerView : TopBannerView
    
    private init() {
        bottomBannerView = UINib(nibName: "BottomBannerView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! BottomBannerView
        bottomBannerView.translatesAutoresizingMaskIntoConstraints = false
        
        topBannerView = UINib(nibName: "TopBannerView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! TopBannerView
        topBannerView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    public func configureBottomBanner() {
        guard bannerConfigured == false else {
            print("Banner already configured")
            return
        }

        guard let window = getKeyWindow() else {
            print("Key Window not found")
            return
        }

        window.addSubview(topBannerView)
        topBannerView.bottomAnchor.constraint(equalTo: window.topAnchor, constant: 0).isActive = true
        topBannerView.leftAnchor.constraint(equalTo: window.leftAnchor, constant: 0).isActive = true
        topBannerView.rightAnchor.constraint(equalTo: window.rightAnchor, constant: 0).isActive = true
        
        window.addSubview(bottomBannerView)
        bottomBannerView.topAnchor.constraint(equalTo: window.bottomAnchor, constant: 0).isActive = true
        bottomBannerView.leftAnchor.constraint(equalTo: window.leftAnchor, constant: 0).isActive = true
        bottomBannerView.rightAnchor.constraint(equalTo: window.rightAnchor, constant: 0).isActive = true

        window.setNeedsLayout()
        window.layoutIfNeeded()

        window.frame = CGRect(x: 0,
                              y: topBannerView.frame.height,
                              width: window.frame.width,
                              height: window.frame.height - bottomBannerView.frame.height - topBannerView.frame.height)
        window.setNeedsLayout()
        window.layoutIfNeeded()
        
        bannerConfigured = true
    }
    
    private func getKeyWindow() -> UIWindow? {
        return UIApplication.shared.keyWindow
    }
    
    public func getTopBanner() -> TopBannerView {
        return topBannerView
    }
    
    public func getBottomBanner() -> BottomBannerView {
        return bottomBannerView
    }
}
