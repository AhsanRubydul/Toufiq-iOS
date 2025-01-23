//
//  ImportantDoaViewController.swift
//  toufik
//
//  Created by Ratul Sharker on 16/3/21.
//

import UIKit

class ImportantDoaViewController : UIViewController {
    
    @IBOutlet private var tableView: UITableView!
    
    private var doas : [Dua]?
    private let importantDua = "¸iæZ¡c~Y© ‡`vqvmg~n" // গুরুত্বপূর্ণ দোয়াসমূহ
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAppTopBackground()
        setupAppBottomBackground()
        setupCustomBackButton()
        
        setupTitle(title: importantDua)
        setupBottomTitle(title: "আরবি ও বাংলা অনুবাদ সূত্রঃ\nআল-কুরআনুল-করিম\nসম্পাদনা পরিষদ, ইসলামিক ফাউন্ডেশন")

        setupDoas()
        setupTableView()
    }
    
    private func setupDoas() {
        doas = AppData.sharedInstance.getAllDuas()
    }
    
    private func setupTableView() {
        let nib: UINib = UINib.init(nibName: "SimpleListCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: SimpleListCell.reusingIdentifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 60
    }
}

extension ImportantDoaViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return doas?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: SimpleListCell.reusingIdentifier) as! SimpleListCell
        
        cell.label.text = doas?[indexPath.row].dua
        return cell
    }
}

extension ImportantDoaViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let filename = doas?[indexPath.row].file
        let url = Bundle.main.url(forResource: filename, withExtension: "pdf", subdirectory: "data/pdfs/dua")
        showPdfWithFilename(fileUrl: url!, title: importantDua)
    }
}

