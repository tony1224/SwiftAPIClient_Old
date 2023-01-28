//
//  Task+Extensions.swift
//  APIModule
//
//  Created by Jun Morita on 2023/01/28.
//

import Foundation

// Coreで良いが今はここ

extension Task where Failure == Error {
    @discardableResult
    static func retrying(
        priority: TaskPriority? = nil,
        maxRetryCount: Int = 3,
        operation: @Sendable @escaping () async throws -> Success
    ) -> Task {
        Task(priority: priority) {
            for _ in 0..<maxRetryCount {
                try Task<Never, Never>.checkCancellation()
                
                do {
                    return try await operation()
                } catch {
                    continue
                }
            }
            try Task<Never, Never>.checkCancellation()
            return try await operation()
        }
    }
}
