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
    
    func resetRatingSelection() {
        ratingImages.enumerated().forEach { element in
            let image = UIImage(systemName: "star")?.withRenderingMode(.alwaysOriginal)
            image?.withTintColor(.yellow)
            element.element.setImage(image, for: .normal)
            //element.element.isSelected = false
        }
    }
    
    func setColorToRating(newValue: Int) {
        /*: 1 - Happy Path
         - Seleciono 3
         - Se seleccionan los items 1, 2 y 3
         */
        
        ratingImages.enumerated().forEach { element in
            let index = element.offset
            let prevSelected = prevSelectedValues[index]
            if index < newValue {
                let image = UIImage(systemName: !prevSelected ? "star.fill" : "star")
                image?.withTintColor(.yellow)
                element.element.setImage(image, for: .normal)
                prevSelectedValues[index] = !prevSelected
            } else {
                let image = UIImage(systemName: "star")
                image?.withTintColor(.yellow)
                element.element.setImage(image, for: .normal)
                prevSelectedValues[index] = false
            }
        }
        self.value = newValue
    }
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
}
