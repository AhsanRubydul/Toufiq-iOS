//
//  MainMenuViewController.swift
//  toufik
//
//  Created by Ratul Sharker on 6/3/21.
//

import Foundation
import UIKit

class MainMenuViewController : UIViewController {
    
    @IBOutlet var menuButtons: [UIButton]!
    @IBOutlet var container: UIView!
    @IBOutlet var namajTimingMenuButton: UIButton!
    
    private var childViewController : UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMenuButton()
        
        decorateMenuAndPopulateContainer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // hiding the naviagation bar
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(decorateMenuAndPopulateContainer),
                                               name: NSNotification.Name(rawValue: RemoteCfgMgr.CONFIG_FETCHED_NOTIFICATION),
                                               object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self)
    }
    
    public func setupMenuButton() {
        menuButtons.forEach { (menuButton) in
            menuButton.imageView?.contentMode = .scaleAspectFit
        }
    }

    @objc private func decorateMenuAndPopulateContainer() {
        let isRamadanRunning = RemoteCfgMgr.sharedInstance.shouldShowRamdanUI()
        
        if isRamadanRunning {
            remove(asChild: childViewController)
            childViewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "RomjanTimingViewController")
            add(asChild: childViewController, container: container)
            namajTimingMenuButton.isHidden = false
            
        } else {
            remove(asChild: childViewController)
            childViewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NamajTimingViewController")
            add(asChild: childViewController, container: container)
            namajTimingMenuButton.isHidden = true
        }
    }
}
