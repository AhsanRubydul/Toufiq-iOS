//
//  NamajTimingCell.swift
//  toufik
//
//  Created by Ratul Sharker on 19/3/21.
//

import UIKit

class NamajTimingCell : UITableViewCell {
    
    @IBOutlet var namajTimeTitle: UILabel!
    @IBOutlet var timeTitle: UILabel!
    @IBOutlet var timeImage: UIImageView!
    
    public static let reusingIdentifier = "NamajTimingCell"
    
    public func setupNamajTiming(timing: NamajTimes, time: String?) {
        
        switch timing {
        case .achor:
            namajTimeTitle.text = "আছর"
        case .esha:
            namajTimeTitle.text = "এশা"
        case .fazar:
            namajTimeTitle.text = "ফজর"
        case .johor:
            namajTimeTitle.text = "যোহর"
        case .magrib:
            namajTimeTitle.text = "মাগরীব"
        }
        
        timeTitle.text = time?.removeAMPM()
        
        setupNamajTimingImage(timing: timing)
    }
    
    public func setupNamajTimingImage(timing: NamajTimes) {
        switch timing {
        case .achor:
            timeImage.image = UIImage(named: "achor")
        case .esha:
            timeImage.image = UIImage(named: "esha")
        case .fazar:
            timeImage.image = UIImage(named: "fazar")
        case .johor:
            timeImage.image = UIImage(named: "johor")
        case .magrib:
            timeImage.image = UIImage(named: "magrib")
        }
    }
}

