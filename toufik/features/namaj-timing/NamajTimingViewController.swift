//
//  NamajTimingViewController.swift
//  toufik
//
//  Created by Ratul Sharker on 18/3/21.
//

import UIKit
import DropDown

class NamajTimingViewController : UIViewController {

    @IBOutlet var todaysLabel: UILabel!
    @IBOutlet var districtSelectorBtn: UIButton!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var noDataLabel: UILabel!
    
    private var dropDown: DropDown!
    private var districts: [District]!
    private var waktTiming: WaktTiming? = nil {
        didSet {
            tableView.reloadData()
        }
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTodaysLabel()
        setupData()
        setupAppTopBackground()
        setupAppBottomBackground()

        if let nc = navigationController, nc.viewControllers.count > 1 {
            setupCustomBackButton()
        }

        setupTitle(title: "bvgv‡Ri mgqm~Px")    // নামাজের সময়সূচী
        
        setupDropdown()
        
        setupTableView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        dropDown.width = districtSelectorBtn.frame.width
        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)! + UIConstants.GAP_BETWEEN_DROPDOWN_AND_BUTTON)
    }
    
    public func setupDropdown() {
        dropDown = DropDown()

        // The view to which the drop down will appear on
        dropDown.anchorView = districtSelectorBtn // UIView or UIBarButtonItem

        // The list of items to display. Can be changed dynamically
        dropDown.dataSource = districts.map({ (district) -> String in
            return district.name.capitalized
        })
        
        // Action triggered on selection
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            UserDefaults.standard.userSelectedDistrictIndex = index
            self.selectDistrict(index: index)
        }
        
        dropDown.direction = .bottom

        let lastTimeSelectedIndex = UserDefaults.standard.userSelectedDistrictIndex
        dropDown.selectRow(lastTimeSelectedIndex)
        selectDistrict(index: lastTimeSelectedIndex)
    }
    
    private func setupTableView() {
        let nib: UINib = UINib.init(nibName: "NamajTimingCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: NamajTimingCell.reusingIdentifier)
    }
    
    private func setupTodaysLabel() {
        todaysLabel.text = DateFormatter.dateFormat_bn_week_dd_MMM_yyyy().string(from: Date.today())
    }
    
    @IBAction
    public func selectDistrictPressed() {
        dropDown.show()
    }
    
    func selectDistrict(index: Int) {
        
        let districtTitle = districts?[index].name.capitalized
        districtSelectorBtn.setTitle(districtTitle, for: .normal)
        
        let districtId = districts[index].districtId
        waktTiming = AppData.sharedInstance.getTodaysWakTimingForDistrictId(districtId: districtId)
        
        #if DEBUG
        print(waktTiming as Any)
        #endif
    }

    private func setupData() {
        districts = AppData.sharedInstance.getDivisions()
    }
}


extension NamajTimingViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let _ = waktTiming else {
            noDataLabel.isHidden = false
            return 0
        }
        
        noDataLabel.isHidden = true
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NamajTimingCell.reusingIdentifier) as! NamajTimingCell
        
        switch indexPath.row {
        case 0:
            cell.setupNamajTiming(timing: .fazar, time: waktTiming?.fazarTime)
        case 1:
            cell.setupNamajTiming(timing: .johor, time: waktTiming?.zoharTime)
        case 2:
            cell.setupNamajTiming(timing: .achor, time: waktTiming?.asarTime)
        case 3:
            cell.setupNamajTiming(timing: .magrib, time: waktTiming?.maghribTime)
        case 4:
            cell.setupNamajTiming(timing: .esha, time: waktTiming?.ishaTime)
        default:
            print("Never meant to happen")
        }
        
        return cell
    }

}

extension NamajTimingViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
}
