//
//  RestaurantHoursCell.swift
//  WEats
//
//  Created by Will Cohen on 1/8/18.
//  Copyright © 2018 Will Cohen. All rights reserved.
//

import UIKit

class RestaurantHoursCell: UITableViewCell {

    @IBOutlet weak var dayOfWeekLabel: UILabel!
    @IBOutlet weak var hoursLabel: UILabel!
    
    func buildCell(dayOfWeek: String, hour: String) {
        self.dayOfWeekLabel.text = dayOfWeek;
        self.hoursLabel.text = hour;
    }

}
