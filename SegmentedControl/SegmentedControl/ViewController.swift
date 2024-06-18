//
//  ViewController.swift
//  SegmentedControl
//
//  Created by Oğuz Canbaz on 1.06.2024.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: -- Components
    
    @IBOutlet weak var scrollViewLabel: UILabel!
    @IBOutlet weak var segmentedViewLabel: UILabel!
    @IBOutlet weak var scrollView: SegmentedControlScrollView! {
        didSet{
            scrollView.delegateTwo = self
            scrollView.setButtonTitles(["İşlemlerim","Kişisel Bilgilerim","Benim Hesap Hareketlerim","Gönderilen İşlemlerim"])
            scrollView.selectorTextColor = .brown
            scrollView.selectorViewColor = .brown
        }
    }
    
    @IBOutlet weak var segmentedControl: SegmentedControlView! {
        didSet{
            segmentedControl.delegate = self
            segmentedControl.setButtonTitles(["OFF","HTTP","AUTO"])
            segmentedControl.selectorViewColor = .orange
            segmentedControl.selectorTextColor = .orange
        }
    }
    
    // MARK: -- Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

// MARK: -- Extensions

extension ViewController:SegmentedControlViewDelegate{
    func changeSegmented(index: Int) {
        segmentedViewLabel.text = "\(index)"
    }
}

extension ViewController:SegmentedControlScrollViewDelegate{
    func changeScrollSegmented(index: Int) {
        scrollViewLabel.text = "\(index)"
    }
}
