import XCTest
@testable import Reader

final class ReaderTests: XCTestCase {
    let addTwo: (Int) -> Int = { $0 + 2 }

    func testExecute() {
        let reader = Reader(addTwo)
        XCTAssertEqual(reader.execute(1), 3)
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

    func testZipOperator() {
        let reader1 = Reader(addTwo)
        let reader2 = Reader<Int, String>(String.init)
        let zipped = Reader<Int, (Int, String)>.zip(reader1, reader2).execute(1)
        XCTAssertEqual(zipped.0, 1)
        XCTAssertEqual(zipped.1, "1")
    }

    static var allTests = [
        ("testExecute", testExecute),
        ("testMapOperator", testMapOperator),
        ("testFlatMapOperator", testFlatMapOperator),
        ("testZipOperator", testZipOperator)
    ]
}

extension ReaderTests {
    /// Object for tests
    private struct Cat {
        let name: String
    }
}
