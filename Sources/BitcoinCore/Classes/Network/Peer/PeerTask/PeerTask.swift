import Foundation

// MARK: - PeerTask

open class PeerTask {
    class TimeoutError: Error { }

    public let dateGenerator: () -> Date
    public var lastActiveTime: Double? = nil

    public weak var requester: IPeerTaskRequester? = nil
    public weak var delegate: IPeerTaskDelegate? = nil

    public init(dateGenerator: @escaping () -> Date = Date.init) {
        self.dateGenerator = dateGenerator
    }

    open var state: String { "" }

    open func start() {
        resetTimer()
    }

    open func handle(message _: IMessage) throws -> Bool {
        false
    }

    open func checkTimeout() { }

    open func resetTimer() {
        lastActiveTime = dateGenerator().timeIntervalSince1970
    }
}

// MARK: Equatable

extension PeerTask: Equatable {
    public static func == (lhs: PeerTask, rhs: PeerTask) -> Bool {
        switch lhs {
        case let t as GetBlockHashesTask: t.equalTo(rhs as? GetBlockHashesTask)
        case let t as GetMerkleBlocksTask: t.equalTo(rhs as? GetMerkleBlocksTask)
        case let t as SendTransactionTask: t.equalTo(rhs as? SendTransactionTask)
        case let t as RequestTransactionsTask: t.equalTo(rhs as? RequestTransactionsTask)
        default: true
        }
    }
}
