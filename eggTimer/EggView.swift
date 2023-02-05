//
//  EggView.swift
//  eggTimer
//
//  Created by Димаш Алтынбек on 29.01.2023.
//

import UIKit

class EggView: UIView {

    //MARK: -Views-
    let image = UIImageView()
    let button = UIButton()
    
    //MARK: -LifeCycle-
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: -Functions-
    func setUpViews() {
        addSubview(image)
        addSubview(button)
        
        image.image = #imageLiteral(resourceName: "Medium")
        image.contentMode = .scaleAspectFit
        
        image.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: topAnchor),
            image.leadingAnchor.constraint(equalTo: leadingAnchor),
            image.bottomAnchor.constraint(equalTo: bottomAnchor),
            image.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            button.topAnchor.constraint(equalTo: topAnchor),
            button.leadingAnchor.constraint(equalTo: leadingAnchor),
            button.bottomAnchor.constraint(equalTo: bottomAnchor),
            button.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    func config(with title: String, _ target: Any?, action: Selector ) {
        image.image = UIImage(named: title)
        button.setTitle(title, for: .normal)
        
        button.addTarget(target, action: action, for: .primaryActionTriggered)
    }

}
