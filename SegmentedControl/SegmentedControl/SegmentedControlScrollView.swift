//
//  SegmentedControlScrollView.swift
//  SegmentedControl
//
//  Created by Oğuz Canbaz on 1.06.2024.
//

import UIKit
import SnapKit

// MARK: -- Protocols

protocol SegmentedControlScrollViewDelegate: AnyObject {
    func changeScrollSegmented(index: Int)
}

class SegmentedControlScrollView: UIScrollView {
    
    // MARK: -- Properties
    
    private var buttons: [UIButton] = []
    private var selectorView: UIView!
    var textColor: UIColor = .lightGray
    var selectorTextColor: UIColor = .orange
    var viewColor: UIColor = .lightGray
    var selectorViewColor: UIColor = .red{
        didSet {
            selectorView?.backgroundColor = selectorViewColor
        }
    }
    
    weak var delegateTwo: SegmentedControlScrollViewDelegate?
    
    // MARK: -- Life Cycles
    
    convenience init(frame: CGRect, buttonTitles: [String]) {
        self.init(frame: frame)
        setButtonTitles(buttonTitles)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setIndex(index: buttons.firstIndex { $0.titleColor(for: .normal) == selectorTextColor } ?? 0)
    }
    
    // MARK: -- Functions
    
    func setButtonTitles(_ buttonTitles: [String]) {
        buttons.forEach { $0.removeFromSuperview() }
        buttons.removeAll()
        
        buttonTitles.forEach { buttonTitle in
            let button = UIButton(type: .system)
            button.titleLabel?.font = UIFont(name: "FontsRUs", size: 24)
            button.setTitle(buttonTitle, for: .normal)
            button.addTarget(self, action: #selector(buttonAction(sender:)), for: .touchUpInside)
            button.setTitleColor(textColor, for: .normal)
            buttons.append(button)
        }
        buttons.first?.setTitleColor(selectorTextColor, for: .normal)
        updateView()
    }
    
    @objc private func buttonAction(sender: UIButton) {
        guard let index = buttons.firstIndex(of: sender) else { return }
        delegateTwo?.changeScrollSegmented(index: index)
        setIndex(index: index)
    }
    
    func setIndex(index: Int) {
        buttons.enumerated().forEach { offset, button in
            button.setTitleColor(offset == index ? selectorTextColor : textColor, for: .normal)
        }
        
        layoutIfNeeded()
        let buttonWidth = buttons[index].frame.width
        let selectorPosition = buttons[index].frame.origin.x
        
        UIView.animate(withDuration: 0.3) {
            self.selectorView.snp.updateConstraints { make in
                make.leading.equalToSuperview().offset(selectorPosition)
                make.width.equalTo(buttonWidth)
            }
            self.layoutIfNeeded()
        }
    }
    
    private func updateView() {
        configureSelectorView()
        configureStackView()
    }
    
    private func configureSelectorView() {
        backgroundColor = .clear
        
        let bottomLine = UIView()
        bottomLine.backgroundColor = viewColor
        addSubview(bottomLine)
        bottomLine.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
        
        selectorView = UIView()
        selectorView.backgroundColor = selectorViewColor
        addSubview(selectorView)
        
        if let firstButton = buttons.first {
            selectorView.snp.makeConstraints { make in
                make.leading.equalToSuperview().offset(firstButton.frame.origin.x)
                make.bottom.equalToSuperview()
                make.width.equalTo(firstButton.frame.width)
                make.height.equalTo(3)
            }
        }
    }
    
    private func configureStackView() {
        let stackView = UIStackView(arrangedSubviews: buttons)
        stackView.backgroundColor = .clear
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 10
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
