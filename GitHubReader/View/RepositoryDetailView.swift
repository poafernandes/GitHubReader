//
//  RepositoryDetailView.swift
//  GitHubReader
//
//  Created by Alexandre on 06/09/21.
//

import UIKit

class RepositoryDetailView: UIView {

    var repositoryDetailViewModel: RepositoryDetailViewModel!
    var stackView = UIStackView()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        setupViews()
    }
    
    func setupViews() {
        self.backgroundColor = .white
        
        let scrollView = UIScrollView()
        
        scrollView.addSubview(stackView)

        self.addSubview(scrollView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor,constant: 0).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor,constant: 20).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor,constant: -20).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        setupStackview()

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor,constant: 0).isActive = true
        stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,constant: 0).isActive = true
        stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor,constant: 0).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor,constant: 0).isActive = true
        
        stackView.widthAnchor.constraint(greaterThanOrEqualTo: scrollView.widthAnchor).isActive = true
        
    }
    
    func setupStackview(){
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 20
    }
    
    let contentView: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor.red.cgColor
        return view
    }()
    
    let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Save", for: .normal)
        return button
    }()
    
    func textLabel(text: String) -> UILabel {
        let titleLabel = UILabel()
        titleLabel.text = text
        titleLabel.font = UIFont.boldSystemFont(ofSize: 22)
        titleLabel.textAlignment = .left
        titleLabel.numberOfLines = 0
        titleLabel.adjustsFontSizeToFitWidth = true

        return titleLabel
    }
    
    func textContent(text: String) -> UILabel{
        let valueLabel = UILabel()
        valueLabel.text = text
        valueLabel.font = UIFont.systemFont(ofSize: 18)
        valueLabel.textAlignment = .left
        valueLabel.numberOfLines = .max
        valueLabel.adjustsFontSizeToFitWidth = true
        
        return valueLabel
    }
    
    func setLabelIntoStackView(type: String, label: String){
        switch type {
        case "header":
            stackView.addArrangedSubview(textLabel(text: label))
        case "content":
            stackView.addArrangedSubview(textContent(text: label))
        default:
            return
        }
        
    }
    
    
//    func setLabelConstraints(label: UILabel){
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor,constant: 20).isActive = true
//        label.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor,constant: 20).isActive = true
//    }
    

}
