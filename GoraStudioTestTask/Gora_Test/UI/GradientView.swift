//
//  GradientView.swift
//  Gora_Test
//
//  Created by Максим Хлесткин on 14.03.2022
//

import Foundation
import UIKit

class GradientView: UIView {
    
    private let gradientLayer = CAGradientLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupGradient()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
    
    private func setupGradient() {
        self.layer.addSublayer(gradientLayer)
        setupGradientColors()
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        
    }
    
    private func setupGradientColors() {
        gradientLayer.colors = [UIColor.black.cgColor,
                                UIColor.clear.cgColor]
    }
}

