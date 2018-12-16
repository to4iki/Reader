import SwiftCheck
import XCTest
@testable import Reader

final class ReaderTests: XCTestCase {
    let addTwo: (Int) -> Int = { $0 + 2 }

    func testExecute() {
        let reader = Reader(addTwo)
        XCTAssertEqual(reader.execute(1), 3)
    }

    func testMonadLaw() {
        // TODO: Monad left identity law, associativity law"
        property("Monad right identity law") <- forAll { (i: Int, r: Reader<Int, Int>) in
            r.flatMap(Reader<Int, Int>.pure).execute(i) == r.execute(i)
        }
    }

    func testMapOperator() {
        let reader = Reader(addTwo)
            .map(String.init)
        XCTAssertEqual(reader.execute(1), "3")
    }

    func testFlatMapOperator() {
        let reader = Reader<String, String> { $0.capitalized }
            .flatMap { input1 in Reader<String, Cat> { input2 in Cat(name: input1 + input2) } }
        XCTAssertEqual(reader.execute("a").name, "Aa")
    }

    func testFlatMapConcat() {
        let reader = Reader(addTwo)
            .flatMapConcat { input1 in Reader<String, Cat> { input2 in Cat(name: "\(input1)" + input2) } }
        XCTAssertEqual(reader.execute((1, "a")).name, "3a")
    }

    func testZipOperator() {
        let reader1 = Reader(addTwo)
        let reader2 = Reader<Int, String>(String.init)
        let zipped = Reader<Int, (Int, String)>.zip(reader1, reader2).execute(1)
        XCTAssertEqual(zipped.0, 3)
        XCTAssertEqual(zipped.1, "1")
    }

    static var allTests = [
        ("testExecute", testExecute),
        ("testMapOperator", testMapOperator),
        ("testFlatMapOperator", testFlatMapOperator),
        ("testFlatMapConcat", testFlatMapConcat),
        ("testZipOperator", testZipOperator)
    ]
}

extension ReaderTests {
    /// Object for tests
    private struct Cat {
        let name: String
    }
}
