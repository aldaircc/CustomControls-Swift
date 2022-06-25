//
//  RatingControl.swift
//  
//
//  Created by Aldair Cosetito Coral on 18/06/22.
//

import UIKit

@available(iOS 13.0, *)
public class RatingControl: UIControl {
    
    lazy var contentStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.alignment = .center
        stack.distribution = .equalSpacing
        stack.spacing = 5
        stack.axis = .horizontal
        stack.backgroundColor = .yellow
        return stack
    }()
    
    let size: Int
    private(set) var prevValue: Int = 0
    public private(set) var value: Int
    private(set) var ratingImages: [UIButton] = []
    private(set) var prevSelectedValues: [Bool] = []
    
    public init(size: Int, value: Int) {
        self.size = size
        self.value = value
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        addSubview(contentStackView)
        for index in 0..<size {
            ratingImages.append(generateView(id: index, selected: false))
        }
        ratingImages.forEach { button in
            contentStackView.addArrangedSubview(button)
            prevSelectedValues.append(button.isSelected)
        }
    }
    
    func generateView(id: Int, selected: Bool) -> UIButton {
        if let image = UIImage(systemName: !selected ? "star" : "star.fill") {
            image.withTintColor(selected ? .yellow : .clear)
            let button = UIButton()
            button.tag = id
            button.backgroundColor = .red
            button.setImage(image, for: .normal)
            button.addTarget(self, action: #selector(ratingSelectionChanging(_:)), for: .touchUpInside)
            
            return button
        }
        return UIButton()
    }
    
    @IBAction public func ratingSelectionChanging(_ sender: UIButton) {
        setColorToRating(newValue: sender.tag + 1)
        sendActions(for: .valueChanged)
    }
    
    func setColorToRating(newValue: Int) {
        ratingImages.enumerated().forEach { element in
            
//            guard self.value != value else {
//
//                if value >= element.offset {
//                    let isOn = element.element.isSelected
//                    let image = UIImage(systemName: (!isOn) ? "star.fill" : "star")?.withRenderingMode(.alwaysOriginal)
//                    image?.withTintColor(.yellow)
//                    element.element.setImage(image, for: .normal)
//                    element.element.isSelected.toggle()
//
//                } else {
//                    let isOn = element.element.isSelected
//                    let image = UIImage(systemName: (!isOn) ? "star.fill" : "star")?.withRenderingMode(.alwaysOriginal)
//                    image?.withTintColor(.yellow)
//                    element.element.setImage(image, for: .normal)
//                    element.element.isSelected = false
//                }
//
//
//                //element.element.isSelected = false
//
//
//                return
//            }
//
//            let image = UIImage(systemName: (element.offset < value) ? "star.fill" : "star")?.withRenderingMode(.alwaysOriginal)
//            image?.withTintColor(.yellow)
//            element.element.setImage(image, for: .normal)
//            element.element.isSelected.toggle()
            
            guard self.value != newValue else {
                // evaluar los indices menores a valor
                // verificar su antiguo valor "isSelected"
                if newValue > element.offset {
                    let isOn = element.element.isSelected
                    let image = UIImage(systemName: (!isOn) ? "star.fill" : "star")?.withRenderingMode(.alwaysOriginal)
                    image?.withTintColor(.yellow)
                    element.element.setImage(image, for: .normal)
                    element.element.isSelected = !isOn
                } else {
                    let isOn = element.element.isSelected
                    let image = UIImage(systemName: (isOn) ? "star.fill" : "star")?.withRenderingMode(.alwaysOriginal)
                    image?.withTintColor(.yellow)
                    element.element.setImage(image, for: .normal)
                    element.element.isSelected = false
                }
                return
            }
            
            if newValue > element.offset {
                let isOn = element.element.isSelected
                let image = UIImage(systemName: (!isOn) ? "star.fill" : "star")?.withRenderingMode(.alwaysOriginal)
                image?.withTintColor(.yellow)
                element.element.setImage(image, for: .normal)
                element.element.isSelected.toggle()
            } else {
                let isOn = element.element.isSelected
                let image = UIImage(systemName: (isOn) ? "star.fill" : "star")?.withRenderingMode(.alwaysOriginal)
                image?.withTintColor(.yellow)
                element.element.setImage(image, for: .normal)
                element.element.isSelected = false
            }
            
        }
        self.value = (self.value != newValue) ? newValue : 0
    }
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
}
