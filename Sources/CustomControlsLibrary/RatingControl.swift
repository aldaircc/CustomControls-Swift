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
    private(set) var value: Int
    
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
            contentStackView.addArrangedSubview(generateView(id: index, selected: false))
        }
    }
    
    func generateView(id: Int, selected: Bool) -> UIImageView {
        if let image = UIImage(systemName: !selected ? "star" : "star.fill") {
            image.withTintColor(selected ? .yellow : .clear)
            let imageView = UIImageView(image: image)
            imageView.tag = id

            let tapped = UITapGestureRecognizer(target: self, action: #selector(ratingSelectionChanging(_:)))
            imageView.isUserInteractionEnabled = true
            imageView.addGestureRecognizer(tapped)
            
            return imageView
        }
        
        return UIImageView()
    }
    
    @IBAction public func ratingSelectionChanging(_ sender: UIImageView) {
        print(sender)
        print(sender.tag)
        sendActions(for: .valueChanged)
    }
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
}
