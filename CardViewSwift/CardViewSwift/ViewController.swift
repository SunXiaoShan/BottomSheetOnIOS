//
//  ViewController.swift
//  CardViewSwift
//
//  Created by Phineas.Huang on 2020/6/19.
//  Copyright © 2020 Phineas. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        addBottomSheetView()
    }
    
    func addBottomSheetView() {
        let bottomSheetVC = BottomSheetViewController()

        self.addChild(bottomSheetVC)
        self.view.addSubview(bottomSheetVC.view)
        bottomSheetVC.didMove(toParent: self)

        let height = view.frame.height
        let width  = view.frame.width
        bottomSheetVC.view.frame = CGRect(x: 0, y: view.frame.maxY, width: width, height: height)
    }


}

