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
    private(set) var isFirstTime: Bool = true
    
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
        }
    }
    
    func setColorToRating(newValue: Int) {
        /*:
         selecciono 1
         reseteo apariencia
         valido que newValue y value sean diferentes
         Si newValue y value son iguales = preservo valore hasta ese indice el resto los reseteo o false
         
         */
        resetRatingSelection()
        ratingImages.enumerated().forEach { rating in
            let index = rating.offset
            
            if newValue == value {
                if (index < newValue) {
                    prevSelectedValues[index] = prevSelectedValues[index]
                    let image = UIImage(systemName: "star.fill")?.withRenderingMode(.alwaysOriginal)
                    image?.withTintColor(.yellow)
                    rating.element.setImage(image, for: .normal)
                    rating.element.isSelected = prevSelectedValues[index]
                } else {
                    prevSelectedValues[index] = !prevSelectedValues[index]
                    let image = UIImage(systemName: "star")?.withRenderingMode(.alwaysOriginal)
                    image?.withTintColor(.yellow)
                    rating.element.setImage(image, for: .normal)
                    rating.element.isSelected = prevSelectedValues[index]
                }
            }
            
            if value > newValue {
                // solo actualizo los indices que son mayor/igual a newValue
                
                if index >= newValue {
                    prevSelectedValues[index] = !prevSelectedValues[index]
                    let image = UIImage(systemName: "star")?.withRenderingMode(.alwaysOriginal)
                    image?.withTintColor(.yellow)
                    rating.element.setImage(image, for: .normal)
                    rating.element.isSelected = prevSelectedValues[index]
                } else {
                    let image = UIImage(systemName: "star.fill")?.withRenderingMode(.alwaysOriginal)
                    image?.withTintColor(.yellow)
                    rating.element.setImage(image, for: .normal)
                    rating.element.isSelected = prevSelectedValues[index]
                }
                
            } else if newValue > value {
                // solo actualizo los indice que son mayor/igual a value
                if index >= value {
                    prevSelectedValues[index] = !prevSelectedValues[index]
                    let image = UIImage(systemName: "star.fill")?.withRenderingMode(.alwaysOriginal)
                    image?.withTintColor(.yellow)
                    rating.element.setImage(image, for: .normal)
                    rating.element.isSelected = prevSelectedValues[index]
                } else {
                    let image = UIImage(systemName: "star")?.withRenderingMode(.alwaysOriginal)
                    image?.withTintColor(.yellow)
                    rating.element.setImage(image, for: .normal)
                    rating.element.isSelected = prevSelectedValues[index]
                }
            }
        }
        
        self.value = (value != newValue) ? newValue : 0
        self.isFirstTime = false
    }
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
}
