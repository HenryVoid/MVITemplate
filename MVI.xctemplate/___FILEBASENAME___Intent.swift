//___FILEHEADER___

import Foundation
import Combine

protocol ___FILEBASENAMEASIDENTIFIER___Type {
    var state: ___VARIABLE_productName:identifier___Model.State { get }
    
    func send(action: ___VARIABLE_productName:identifier___Model.ViewAction)
}

// MARK: ___VARIABLE_productName:identifier___Intent

final class ___FILEBASENAMEASIDENTIFIER___: ObservableObject {
    
    // MARK: Internal
    
    typealias State = ___VARIABLE_productName:identifier___Model.State
    typealias ViewAction = ___VARIABLE_productName:identifier___Model.ViewAction
    
    @Published var state: State
    
    var cancellable: Set<AnyCancellable> = []

    init(
        initialState: State
    ) {
        self.state = initialState
    }
}

extension ___FILEBASENAMEASIDENTIFIER___: IntentType, ___VARIABLE_productName:identifier___IntentType {
    func mutate(action: ___VARIABLE_productName:identifier___Model.ViewAction, viewEffect: (() -> Void)?) {
        switch action {
            
        }
    }
}

// MARK: Custom Method

extension ___FILEBASENAMEASIDENTIFIER___ {
    
}
