//
//  BottomBanneredWindow.swift
//  toufik
//
//  Created by Ratul Sharker on 6/3/21.
//

import UIKit

class BottomBanneredWindow : UIWindow {

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let resultView = super.hitTest(point, with: event)
        
        if resultView != nil {
            return resultView
        } else {
            let bannerView: BottomBannerView = Banner.sharedInstance.getBottomBanner()
            let subpoint : CGPoint = bannerView.convert(point, from: self)
            return bannerView.hitTest(subpoint, with: event)
        }
    }

}
