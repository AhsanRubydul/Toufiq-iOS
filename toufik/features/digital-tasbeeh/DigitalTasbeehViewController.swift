//
//  DigitalTasbeehViewController.swift
//  toufik
//
//  Created by Ratul Sharker on 6/3/21.
//

import UIKit

class DigitalTasbeehViewController : UIViewController {
    
    @IBOutlet var mTashbeehLabel: UILabel!
    @IBOutlet var mResetButton: UIButton!
    
    private var counter: Int = 0
    private var resetAlert: UIAlertController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAppTopBackground()
        setupAppBottomBackground()
        setupCustomBackButton()
        setupTitle(title: "Zmexn Mbbv") // তসবীহ গণনা
        
        setupResetButton()
        setupResetAlert()
        
        updateTasbeehLabel()
    }
    
    private func setupResetButton() {
        mResetButton.imageView?.contentMode = .scaleAspectFit
    }
    
    private func setupResetAlert() {
        resetAlert = UIAlertController.init(title: "আপনি কি নিশ্চিত ?", message: "যে নতুন করে আরম্ভ করতে চান", preferredStyle: .alert)
        let cancelAction = UIAlertAction.init(title: "না", style: .default, handler: nil)
        let resetAction = UIAlertAction.init(title: "হ্যাঁ", style: .destructive) { [weak self](action) in

            UIImpactFeedbackGenerator(style: .heavy).impactOccurred()
            self?.counter = 0
            self?.updateTasbeehLabel()
        }
        
        resetAlert.addAction(cancelAction)
        resetAlert.addAction(resetAction)
    }
    
    @IBAction
    func count() {
        counter += 1
        updateTasbeehLabel()
        if #available(iOS 13.0, *) {
            UIImpactFeedbackGenerator(style: .soft).impactOccurred()
        } else {
            // Fallback on earlier versions
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
        }
    }
    
    @IBAction
    func reset() {
        guard counter != 0 else {
            return
        }

        self.present(resetAlert, animated: true, completion: nil)
        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
    }
    
    func updateTasbeehLabel() {
        mTashbeehLabel.text = String(format: "%d", counter)
    }
    
}
