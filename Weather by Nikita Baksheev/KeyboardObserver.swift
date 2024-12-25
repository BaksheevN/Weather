//
//  KeyboardObserver.swift
//  Weather by Nikita Baksheev
//
//  Created by Nikita Baksheev on 25.12.2024.
//
import SwiftUI
import Combine

class KeyboardObserver: ObservableObject {
    @Published var isKeyboardVisible: Bool = false
    @Published var keyboardHeight: CGFloat = 0
    
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)
            .sink { [weak self] notification in
                self?.keyboardWillShow(notification)
            }
            .store(in: &cancellables)
        
        NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)
            .sink { [weak self] _ in
                self?.keyboardWillHide()
            }
            .store(in: &cancellables)
    }
    
    private func keyboardWillShow(_ notification: Notification) {
        withAnimation { isKeyboardVisible = true }
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            keyboardHeight = keyboardFrame.height
        }
    }
    
    private func keyboardWillHide() {
        withAnimation { isKeyboardVisible = false }
        keyboardHeight = 0
    }
}

