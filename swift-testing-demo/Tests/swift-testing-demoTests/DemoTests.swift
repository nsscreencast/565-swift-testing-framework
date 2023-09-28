import Testing
import Foundation

class Calculator {
    var result = 0

    var arg1: Int?
    var arg2: Int?

    enum Error: Swift.Error {
        case missingOperands
    }

    func enter(_ number: Int) {
        if arg1 == nil {
            arg1 = number
        } else if arg2 == nil {
            arg2 = number
        }
    }

    func add() throws {
        guard let arg1, let arg2 else {
            throw Error.missingOperands
        }
        result = arg1 + arg2
        self.arg1 = result
        self.arg2 = nil
    }

    func slowClear() {
        sleep(1)
        clear()
    }

    func clear() {
        arg1 = nil
        arg2 = nil
        result = 0
    }
}

struct DemoTests {
    static let slowTestsEnabled = false
    let calculator: Calculator

    init() {
        calculator = Calculator()
    }

    @Test("calculator throws an error if operands are missing")
    func requiresOperands() throws {
        #expect(throws: Calculator.Error.missingOperands, performing: {
            try calculator.add()
        })
    }

    @Test
    func canEnterNumber() {
        calculator.enter(5)
        #expect(calculator.arg1 == 5)

        calculator.enter(8)
        #expect(calculator.arg2 == 8)
    }

    @Test
    func add() throws {
        calculator.enter(5)
        calculator.enter(7)
        try calculator.add()
        #expect(calculator.result == 12)
    }

    @Test
    func storesResultOfAddition() throws {
        calculator.enter(5)
        calculator.enter(7)
        try calculator.add()
        try #require(calculator.result == 12)

        calculator.enter(14)
        try calculator.add()
        #expect(calculator.result == 26)
    }

    @Test(.enabled(if: DemoTests.slowTestsEnabled))
    func slowClear() {
        calculator.enter(5)
        calculator.slowClear()
        #expect(calculator.arg1 == nil)
    }

    @Test(.bug("PROJ-1234", relationship: .reproducesBug))
    func someAsyncFunction() async {
        withKnownIssue {
            throw Calculator.Error.missingOperands
        }
    }
}
