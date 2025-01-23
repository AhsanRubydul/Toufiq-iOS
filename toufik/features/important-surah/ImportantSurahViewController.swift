//
//  ImportantSurahViewController.swift
//  toufik
//
//  Created by Ratul Sharker on 16/3/21.
//

import UIKit

class ImportantSurahViewController : UIViewController {
    
    @IBOutlet private var tableView: UITableView!
    
    private var suras: [Sura]?
    
    private let importantSura = "¸iæZ¡c~Y© m~ivmg~n" // গুরুত্বপূর্ণ সূরাসমূহ
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAppTopBackground()
        setupAppBottomBackground()
        setupCustomBackButton()
        
        setupSuras()
        setupTitle(title: importantSura)
        setupBottomTitle(title: "আরবি ও বাংলা অনুবাদ সূত্রঃ\nআল-কুরআনুল-করিম\nসম্পাদনা পরিষদ, ইসলামিক ফাউন্ডেশন")

        setupTableView()
    }
    
    private func setupSuras() {
        suras = AppData.sharedInstance.getAllSuras()
    }
    
    private func setupTableView() {
        let nib: UINib = UINib.init(nibName: "SimpleListCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: SimpleListCell.reusingIdentifier)
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 60
    }
}

extension ImportantSurahViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return suras?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: SimpleListCell.reusingIdentifier) as! SimpleListCell

        cell.label.text = suras?[indexPath.row].sura
        return cell
    }
}

extension ImportantSurahViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let filename = suras?[indexPath.row].file
        let url = Bundle.main.url(forResource: filename, withExtension: "pdf", subdirectory: "data/pdfs/surah")
        showPdfWithFilename(fileUrl: url!, title: importantSura)
    }
}
