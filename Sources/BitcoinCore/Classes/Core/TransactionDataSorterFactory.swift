//
//  TransactionDataSorterFactory.swift
//  BitcoinCore
//
//  Created by Sun on 2024/8/21.
//

import Foundation

class TransactionDataSorterFactory: ITransactionDataSorterFactory {
    func sorter(for type: TransactionDataSortType) -> ITransactionDataSorter {
        switch type {
        case .none: StraightSorter()
        case .shuffle: ShuffleSorter()
        case .bip69: Bip69Sorter()
        }
    }
}
