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
        //Tentando delimitar tamanho pro ScrollView nao espalhar horizontalmente
        scrollView.contentSize = self.frame.size
        scrollView.addSubview(stackView)

        self.addSubview(scrollView)
        
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor,constant: 0).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor,constant: 10).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor,constant: -10).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor).isActive = true
        //scrollView.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, constant: 0).isActive = true
        

        setupStackview()

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor,constant: 10).isActive = true
        stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,constant: 0).isActive = true
        stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor,constant: 0).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor,constant: 10).isActive = true
        
        stackView.widthAnchor.constraint(greaterThanOrEqualTo: scrollView.widthAnchor).isActive = true
        
    }
    
    func setupStackview(){
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 20
    }
    
    let saveButton: UIButton = {
        let button = primaryButton()
        button.setTitle("Save", for: .normal)
        button.backgroundColor = .systemYellow
        return button
    }()
    
    let removeButton: UIButton = {
        let button = primaryButton()
        button.setTitle("Remove", for: .normal)
        button.backgroundColor = .systemRed
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
        //Quebrando a descrição em multiplas linhas
        valueLabel.numberOfLines = .max
        valueLabel.numberOfLines = 0
        valueLabel.lineBreakMode = .byWordWrapping
        valueLabel.sizeToFit()
            
        return valueLabel
    }
    
    //Funçao improvisada pra montagem das labels
    func setLabelIntoStackView(type: String, label: String){
        switch type {
        case "header":
            //stackView.addArrangedSubview(textLabel(text: label))
            setIntoStackView(button: nil, label: textLabel(text: label))
        case "content":
            //stackView.addArrangedSubview(textContent(text: label))
            setIntoStackView(button: nil, label: textContent(text: label))
        default:
            return
        }
        
    }
    
    //Funçao improvisada para montagem da StackView
    func setIntoStackView(button: UIButton?, label: UILabel?){
        if(button != nil){
            stackView.addArrangedSubview(button!)
            button?.translatesAutoresizingMaskIntoConstraints = false
            button?.center = stackView.center
        }
        if(label != nil){
            stackView.addArrangedSubview(label!)
            label?.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, constant: -20).isActive = true
        }
    }
    
//    func setLabelConstraints(label: UILabel){
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor,constant: 20).isActive = true
//        label.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor,constant: 20).isActive = true
//    }
    
    

}

class primaryButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    
    func setupButton() {
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        layer.cornerRadius = 10
    }
    
}
