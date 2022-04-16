//
//  DetailScreenView.swift
//  VIPER
//
//  Created by Tatiana Sosina on 02.04.2022.
//

import UIKit

/// события которые отправляем из View в Presenter
protocol DetailScreenViewOutput: AnyObject {
    
    /// Кнопка была нажата пользователем
    func presentNewScreenButtonAction()
}

/// события которые отправляем из Presenter в View
protocol DetailScreenViewInput: AnyObject {
    
    /// Изменить цвет фона на Рандомный
    /// - Parameter color: Цвет для`экрана`
    func changeBackground(color: UIColor?)
    
    /// Устанавливает текст
    /// - Parameter text: текс для `titleLable`
    func setTitle(text: String)
}

/// `View для экрана MainScreenView`
final class DetailScreenView: UIView, DetailScreenViewInput {
    
    // MARK: - Internal properties
    
    weak var output: DetailScreenViewOutput?
    
    // MARK: - Private properties
    
    private let presentNewScreenButton = UIButton()
    private let titleLable = UILabel()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        
        setupConstraints()
        setDefaultsSettings()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Internal func
    
    func changeBackground(color: UIColor?) {
        guard let color = color else { return }
        backgroundColor = color
    }
    
    func setTitle(text: String) {
        titleLable.text = text
    }
    
    // MARK: - Private func
    
    private func setupConstraints() {
        [presentNewScreenButton, titleLable].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            titleLable.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLable.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -Appearance().padding),
            
            presentNewScreenButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            presentNewScreenButton.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    private func setDefaultsSettings() {
        presentNewScreenButton.setTitle(Appearance().buttonTitle, for: .normal)
        presentNewScreenButton.setTitleColor(.blue, for: .normal)
        presentNewScreenButton.addTarget(self, action: #selector(presentNewScreenButtonAction), for: .touchUpInside)
    }
    
    @objc private func presentNewScreenButtonAction() {
        output?.presentNewScreenButtonAction()
    }
}

// MARK: - Appearance

private extension DetailScreenView {
    struct Appearance {
        let padding: CGFloat = 50
        let buttonTitle = "Закрыть экран"
    }
}
