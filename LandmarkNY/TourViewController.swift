//
//  TourViewController.swift
//  LandmarkNY
//
//  Created by Antony Sunwoo on 12/12/18.
//  Copyright © 2018 nyu.edu. All rights reserved.
//

import UIKit

class TourViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let barViewControllers = self.tabBarController?.viewControllers
        let discover=barViewControllers![0] as! DiscoverViewController
        //discover.currentView=0;
        // Do any additional setup after loading the view.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
