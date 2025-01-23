//
//  RomjanTimingViewController.swift
//  toufik
//
//  Created by Ratul Sharker on 20/3/21.
//

import UIKit
import DropDown

class RomjanTimingViewController : UIViewController {
    
    @IBOutlet var districtSelectorBtn: UIButton!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var todaysDateLabel: UILabel!
    @IBOutlet var sehriTimeLabel: UILabel!
    @IBOutlet var iftariTimeLabel: UILabel!
    @IBOutlet var noDataLabel: UILabel!
    
    private var dropDown: DropDown!
    private var districts: [District]!
    
    private var today = Date.today()
    
    private let banglaTodaysDateFormat = DateFormatter.dateFormat_bn_dd_MM_yyyy()
    private let banglaFullDateFormatter = DateFormatter.dateFormat_bn_dd_MM_yyyy()
    private let banglaWeekDayFormatter = DateFormatter.dateFormat_bn_weekDayName()
    private let banglaNumberFormatter = NumberFormatter.numberFormatter_bn()
    
    private var fullRojaTimingForCurDistrict: [SehriIftarTiming]? {
        didSet {
            tableView.reloadData()
            highlightTodaysRow()
        }
    }
    
    private var todaysRojaTiming: SehriIftarTiming? {
        didSet {
            sehriTimeLabel.text = todaysRojaTiming?.sehriTime.removeAMPM()
            iftariTimeLabel.text = todaysRojaTiming?.iftariTime.removeAMPM()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTodaysDateLabel()
        setupData()
        setupTableView()
        
        setupAppTopBackground()
        setupAppBottomBackground()
        setupDropdown()
        setupTitle(title: "igRv‡bi mgqm~Px")    // রমজানের সময়সূচী
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let lastTimeSelectedDistrictIndex = UserDefaults.standard.userSelectedDistrictIndex
        dropDown.selectRow(lastTimeSelectedDistrictIndex)
        selectDistrict(index: lastTimeSelectedDistrictIndex)
        
        perform(#selector(highlightTodaysRow), with: self, afterDelay: 0.5)
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
    }
    
    public func setupTodaysDateLabel() {
        todaysDateLabel.text = banglaTodaysDateFormat.string(from: Date.today())
    }
    
    @IBAction public func selectDistrictPressed() {
        dropDown.show()
    }
    
    func selectDistrict(index: Int) {
        
        let districtTitle = districts[index].name.capitalized
        districtSelectorBtn.setTitle(districtTitle, for: .normal)

        loadRojaTimingData(districtId: districts[index].districtId)
    }
    
    private func setupTableView() {
        let nib: UINib = UINib.init(nibName: "RojaTimingCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: RojaTimingCell.reusingIdentifier)
    }
    
    private func setupData() {
        districts = AppData.sharedInstance.getDivisions()!
    }
    
    private func loadRojaTimingData(districtId: Int) {
        // today's roja timing needed to be resolved first
        // check the `highlightCurrentDateRow` method implementaiton
        todaysRojaTiming = AppData.sharedInstance.getTodaysSehriIftarTimingForDistrict(districtId: districtId)
        
        let ramadanStartDate = RemoteCfgMgr.sharedInstance.ramadanStartDate()
        let ramadanEndDate = RemoteCfgMgr.sharedInstance.ramadanEndDate()
        fullRojaTimingForCurDistrict = AppData.sharedInstance.getAllSehriIftarTimingForDistrict(districtId: districtId,
                                                                                                from: ramadanStartDate,
                                                                                                to: ramadanEndDate)
    }
    
    @objc
    private func highlightTodaysRow() {
        if let rowIndexToHighlight = fullRojaTimingForCurDistrict?.firstIndex(where: { (rojaTiming) -> Bool in
            return rojaTiming.sehriIftarTimingId == todaysRojaTiming?.sehriIftarTimingId
        }) {
            tableView.scrollToRow(at: IndexPath(row: rowIndexToHighlight, section: 0), at: .middle, animated: true)
        }
    }
}

extension RomjanTimingViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let rojaTiming = fullRojaTimingForCurDistrict,
           rojaTiming.count > 0 {
            noDataLabel.isHidden = true
            return rojaTiming.count
        } else {
            noDataLabel.isHidden = false
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: RojaTimingCell.reusingIdentifier) as! RojaTimingCell

        cell.rojaNo.text = banglaNumberFormatter.string(from: NSNumber(value: indexPath.row + 1))
        
        let timingOfDate = fullRojaTimingForCurDistrict![indexPath.row].timingOfDate
        let sehriTime = fullRojaTimingForCurDistrict?[indexPath.row].sehriTime.removeAMPM()
        let iftariTime = fullRojaTimingForCurDistrict?[indexPath.row].iftariTime.removeAMPM()
        
        cell.date.text = banglaFullDateFormatter.string(from: timingOfDate)
        cell.day.text = banglaWeekDayFormatter.string(from: timingOfDate)
        cell.sehriTime.text = sehriTime
        cell.iftariTime.text = iftariTime

        // highlighting cell color
//        let showingSehriIftariTimingId = fullRojaTimingForCurDistrict![indexPath.row].sehriIftarTimingId
//        let todaysSehriIftariTimingId = todaysRojaTiming?.sehriIftarTimingId
//        cell.backgroundColor = showingSehriIftariTimingId == todaysSehriIftariTimingId ?
//            .red
//            : .clear

        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UINib.init(nibName: "RomjanTimingHeader", bundle: nil).instantiate(withOwner: self)[0] as? UIView
    }
}

extension RomjanTimingViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 35
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
}
