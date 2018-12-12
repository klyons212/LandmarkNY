//
//  TourViewController.swift
//  LandmarkNY
//
//  Created by Antony Sunwoo on 12/12/18.
//  Copyright © 2018 nyu.edu. All rights reserved.
//

import UIKit

class TourViewController: UIViewController {
    
    @IBOutlet weak var tour1: UIButton!
    
    @IBOutlet weak var tour2: UIButton!
    
    @IBOutlet weak var tour3: UIButton!
    var discover:DiscoverViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        let barViewControllers = self.tabBarController?.viewControllers
        discover=barViewControllers![0] as! DiscoverViewController
        //discover.currentView=0;
        
        // Do any additional setup after loading the view.
    }

    @IBAction func pickTour1(_ sender: Any) {
        discover?.pickedTour=0
        discover?.currentView=1
    }
    
    @IBAction func pickTour2(_ sender: Any) {
        discover?.pickedTour=1
        discover?.currentView=1
    }
    
    @IBAction func pickTour3(_ sender: Any) {
        discover?.pickedTour=2
        discover?.currentView=1
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
