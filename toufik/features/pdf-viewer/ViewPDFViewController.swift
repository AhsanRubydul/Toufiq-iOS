//
//  ViewPDFViewController.swift
//  toufik
//
//  Created by Ratul Sharker on 19/3/21.
//

import UIKit
import WebKit

class ViewPDFViewController : UIViewController {

    public var pdfFileUrl : URL!
    public var topTitle: String?
    
    private var webview: WKWebView!
    private var imageView: UIImageView!
    private var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

//        setupWebView()
        setupPDFAsImage()
        setupCustomBackButton()
        
        if let title = topTitle {
            setupTitle(title: title)
        }
    }
    
    public func setupPDFAsImage() {
        
        scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        
        let image = drawPDFfromURL(url: pdfFileUrl)!
//        scrollView.contentSize = image.size
        
        imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        
        imageView.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 6.0).isActive = true
        imageView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        imageView.rightAnchor.constraint(equalTo: scrollView.rightAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 44.0).isActive = true
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        print("view bounds : \(view.frame)")
        print("Scroll bounds: \(scrollView.frame)")
        print("imageView bounds: \(imageView.frame)")
    }
    
    public func setupWebView() {
        webview = WKWebView()
        webview.backgroundColor = .clear
        webview.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(webview)
        
        webview.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        webview.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        webview.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        webview.topAnchor.constraint(equalTo: view.topAnchor, constant: 44.0).isActive = true

        webview.loadFileURL(pdfFileUrl, allowingReadAccessTo: pdfFileUrl)
    }

    func drawPDFfromURL(url: URL) -> UIImage? {
        guard let document = CGPDFDocument(url as CFURL) else { return nil }

        var width: CGFloat = 0
        var height: CGFloat = 0
        
        // calculating overall page size
        for index in 1...document.numberOfPages {
            print("index: \(index)")
            if let page = document.page(at: index) {
                let pageRect = page.getBoxRect(.mediaBox)
                width = max(width, pageRect.width)
                height = height + pageRect.height
            }
        }

        // now creating the image
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: width, height: height))

        let image = renderer.image { (ctx) in
            ctx.cgContext.scaleBy(x: 1.0, y: -1.0)
            for index in (1...document.numberOfPages) {
                
                if let page = document.page(at: index) {
                    let pageRect = page.getBoxRect(.mediaBox)
                    ctx.cgContext.translateBy(x: 0.0, y: -pageRect.height)
                    ctx.cgContext.drawPDFPage(page)
                }
            }
            
            ctx.cgContext.scaleBy(x: 1.0, y: -1.0)
        }
        return image
    }
}
