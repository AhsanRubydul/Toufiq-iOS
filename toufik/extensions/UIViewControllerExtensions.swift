//
//  UIViewControllerExtensions.swift
//  toufik
//
//  Created by Ratul Sharker on 14/3/21.
//

import UIKit

extension UIViewController {
    
    public func setupAppTopBackground() {
        let image = UIImage(named: "background-top")!
        let topImage = UIImageView.init(image: image)
        
        topImage.translatesAutoresizingMaskIntoConstraints = false
        topImage.contentMode = .scaleAspectFit
        
        view.addSubview(topImage)
        view.sendSubviewToBack(topImage)
        
        let height = heightBasedOnImageAspectRatio(image: image)
        
        topImage.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        topImage.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        topImage.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        topImage.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    public func setupAppBottomBackground() {
        let image = UIImage(named: "background-bottom")!
        let bottomBackground = UIImageView.init(image: image)
        
        bottomBackground.translatesAutoresizingMaskIntoConstraints = false
        bottomBackground.contentMode = .scaleAspectFit
        
        view.addSubview(bottomBackground)
        view.sendSubviewToBack(bottomBackground)
        
        let height = heightBasedOnImageAspectRatio(image: image)
        
        bottomBackground.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        bottomBackground.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        bottomBackground.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        bottomBackground.heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    public func setupCustomBackButton() {
        let backButton = UIButton(type: .system)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.setTitle("←", for: .normal)
        backButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 36)
        backButton.setTitleColor(.red, for: .normal)
        
        view.addSubview(backButton)
        
        backButton.addTarget(self.navigationController, action: #selector(UINavigationController.popViewController(animated:)), for: .touchUpInside)
        
        backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 0.0).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
        backButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16.0).isActive = true
    }
    
    public func setupTitleImage(image: UIImage) {
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        view.addSubview(imageView)
        
        imageView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        imageView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
    }
    
    public func setupTitle(title: String) {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.font = UIFont(name: "Shobuj-Nolua-ANSI-V2", size: 38.0)
        titleLabel.text = title
        titleLabel.textAlignment = .center
        titleLabel.textColor = .red
        
        view.addSubview(titleLabel)
        
        titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
    }
    
    public func setupBottomTitle(title: String) {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = title
        label.font = UIFont.systemFont(ofSize: 12.0)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .darkGray
        
        view.addSubview(label)
        
        label.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        label.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    public func heightBasedOnImageAspectRatio(image: UIImage) -> CGFloat {
        let heightByWidth = image.size.height / image.size.width
        return heightByWidth * view.frame.width
    }

    public func showPdfWithFilename(fileUrl: URL, title: String?) {
        let pdfViewController = ViewPDFViewController()
        pdfViewController.pdfFileUrl = fileUrl
        pdfViewController.topTitle = title
        self.navigationController?.pushViewController(pdfViewController, animated: true)
    }

    public func add(asChild viewController: UIViewController?, container: UIView) {
        
        guard let vc = viewController else {
            return
        }

        addChild(vc)
        container.addSubview(vc.view)
        
        vc.view.frame = container.bounds
        vc.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        vc.didMove(toParent: self)
    }
    
    public func remove(asChild viewController: UIViewController?) {
        viewController?.willMove(toParent: nil)
        viewController?.view.removeFromSuperview()
        viewController?.removeFromParent()
    }
}
