//
//  BaseViewModel.swift
//  mood-recorder
//
//  Created by LanNTH on 12/08/2021.
//

import Combine
import Foundation

protocol ViewModel: ObservableObject where ObjectWillChangePublisher.Output == Void {
    associatedtype State
    associatedtype InputTrigger

    var state: State { get }
    func trigger(_ input: InputTrigger)
}

extension BaseViewModel: Identifiable where State: Identifiable {
    var id: State.ID {
        state.id
    }
}

@dynamicMemberLookup
final class BaseViewModel<State, Input>: ViewModel {
    private let wrappedObjectWillChange: () -> AnyPublisher<Void, Never>
    private let wrappedState: () -> State
    private let wrappedTrigger: (Input) -> Void

    subscript<Value>(dynamicMember keyPath: KeyPath<State, Value>) -> Value {
        state[keyPath: keyPath]
    }

    init<V: ViewModel>(_ viewModel: V) where V.State == State, V.InputTrigger == Input {
        self.wrappedObjectWillChange = { viewModel.objectWillChange.eraseToAnyPublisher() }
        self.wrappedState = { viewModel.state }
        self.wrappedTrigger = viewModel.trigger
    }

    var objectWillChange: AnyPublisher<Void, Never> {
        wrappedObjectWillChange()
    }

    var state: State {
        wrappedState()
    }

    func trigger(_ input: Input) {
        wrappedTrigger(input)
    }
}
