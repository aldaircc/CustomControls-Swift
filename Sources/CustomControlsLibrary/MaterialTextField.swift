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
            activationIndicator.heightAnchor.constraint(equalToConstant: 2),
            activationIndicator.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            textField.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            textField.bottomAnchor.constraint(equalTo: activationIndicator.topAnchor),
            textField.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        NSLayoutConstraint.activate([
            placeHolder.leadingAnchor.constraint(equalTo: textField.leadingAnchor, constant: 8),
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
    
    public func placeHolderAnimation() {
        guard let textfield = textField.text else {
            return
        }
        
        if textfield.isEmpty {
            print("Origin: \(self.placeHolder.frame.origin)")
            let destination = CGPoint(x: textField.frame.origin.x, y: textField.frame.origin.y - 30) //mover label arriba
            
            
            UIView.animate(withDuration: 0.3) {
                self.placeHolder.frame.origin = destination
                self.placeHolder.font = UIFont.systemFont(ofSize: 13) //reducir tamaño de letra
                self.placeHolder.textColor = .red
                print("Nuevo origin: \(self.placeHolder.frame.origin)")
            }
        } else {
            
        }
    }
}

extension MaterialTextField: UITextFieldDelegate {
    //textFieldDidBeginEditing
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        placeHolderAnimation()
    }
}
