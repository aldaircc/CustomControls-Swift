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
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
}
