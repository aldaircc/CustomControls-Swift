//
//  MaterialTextField.swift
//  
//
//  Created by Aldair Cosetito Coral on 13/06/22.
//

import UIKit

public class MaterialTextField: UIView {
    // MARK: - Controls
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        return textField
    }()
    
    lazy var placeHolder: UILabel = {
        let placeHolder = UILabel()
        placeHolder.translatesAutoresizingMaskIntoConstraints = false
        return placeHolder
    }()
    
    lazy var activationIndicator: UIView = {
        let activationIndicator = UIView()
        activationIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activationIndicator
    }()
    
    let placeHolderText: String
    let activationColor: UIColor
    private(set) var positionY: CGFloat = 0
    private(set) var isFirstFocus = false
    
    // MARK: - Constructor
    public init(placeHolderText: String, activationColor: UIColor) {
        self.placeHolderText = placeHolderText
        self.activationColor = activationColor
        super.init(frame: .zero)
        setupView()
        configureControl()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
    // MARK: - Methods
    func setupView() {
        self.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(textField)
        addSubview(placeHolder)
        addSubview(activationIndicator)
        
        NSLayoutConstraint.activate([
            activationIndicator.widthAnchor.constraint(equalTo: self.widthAnchor),
            activationIndicator.heightAnchor.constraint(equalToConstant: 1),
            activationIndicator.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            textField.bottomAnchor.constraint(equalTo: activationIndicator.topAnchor),
            textField.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        NSLayoutConstraint.activate([
            placeHolder.leadingAnchor.constraint(equalTo: textField.leadingAnchor, constant: 1),
            placeHolder.centerYAnchor.constraint(equalTo: textField.centerYAnchor)
        ])
    }
    
    func configureControl() {
        placeHolder.text = placeHolderText
        activationIndicator.backgroundColor = activationColor
    }
    
    public func getValue() -> String? {
        textField.text
    }
    
    public func placeHolderAnimation(onFocus: Bool) {
        guard let textfield = textField.text else {
            return
        }
        
        if !isFirstFocus {
            positionY = placeHolder.center.y
            isFirstFocus.toggle()
        }
        
//        if textfield.isEmpty && onFocus {
//            UIView.animate(withDuration: 0.2) {
//                self.placeHolder.center.y = 5
//                let scale = CGAffineTransform(scaleX: 0.7, y: 0.7)
//                let translate = CGAffineTransform(translationX: -15, y: 0)
//                self.placeHolder.transform = scale.concatenating(translate)
//            }
//        } else {
//            UIView.animate(withDuration: 0.2) {
//                self.placeHolder.center.y = self.positionY
//                let scale = CGAffineTransform(scaleX: 1, y: 1)
//                let translate = CGAffineTransform(translationX: 0, y: 0)
//                self.placeHolder.transform = scale.concatenating(translate)
//            }
//        }
        
        UIView.animate(withDuration: 0.2) {
            self.placeHolder.center.y = onFocus ? 5 : self.positionY
            let scale = CGAffineTransform(scaleX: onFocus ? 0.7 : 1, y: onFocus ? 0.7 : 1)
            let translate = CGAffineTransform(translationX: onFocus ? -15 : 0, y: 0)
            self.placeHolder.transform = scale.concatenating(translate)
        }
        
    }
}

extension MaterialTextField: UITextFieldDelegate {
    //textFieldDidBeginEditing
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        placeHolderAnimation(onFocus: true)
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        placeHolderAnimation(onFocus: false)
    }
}
