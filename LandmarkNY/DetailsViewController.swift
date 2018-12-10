//
//  DetailsViewController.swift
//  LandmarkNY
//
//  Created by Sungjea Cho on 2018-12-04.
//  Copyright © 2018 nyu.edu. All rights reserved.
//

import Foundation
import UIKit


class DetailsViewController: UIViewController {
    
    
    @IBOutlet weak var detailsTitle: UILabel!
    @IBOutlet weak var detailsImage: UIImageView!
    @IBOutlet weak var detailsDesc: UITextView!
    
    var landmarks = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nameOfFile = "inputFile2"
        landmarks = arrayFromContentsOfFileWithName(fileName: nameOfFile)!
        
        //Sample string
        let str = "Trinity Church"
        
        loadDetail(landmark: str)
        
        
        
        
        
        
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //Input Helper
    func arrayFromContentsOfFileWithName(fileName: String) -> [String]? {
        guard let path = Bundle.main.path(forResource: fileName, ofType: "txt") else {
            return nil
        }
        
        do {
            let content = try String(contentsOfFile:path, encoding: String.Encoding.utf8)
            return content.components(separatedBy: "\n")
        } catch _ as NSError {
            return nil
        }
    }
    
    
    
    func loadDetail(landmark: String){
        
        
        
        var i = 0;
        
        while(i<17){
            
            let temp = landmarks[i];
            
            
            let splitted = temp.components(separatedBy: ",");
            let title = splitted[0]
            print(title)
            
            
            
            if(title == landmark){
                
                let description = splitted[1]
                let image = splitted[2]
                
                
                detailsTitle.text = title
                detailsDesc.text = description
                detailsImage.image = UIImage(named: image)
                
                break;
    
            }
            
            
            
            
            i += 1;
            
            
        }
    }
    
    
  
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}


