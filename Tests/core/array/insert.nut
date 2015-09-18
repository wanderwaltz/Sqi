//
//  core/array/insert.nut
//  Sqi
//
//  Created by Egor Chiglintsev on 18.09.15.
//  Copyright (c) 2015  Egor Chiglintsev
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

SqTest.spec("array", @{
    describe("insert", @{
        it("inserts the value at the given position into the array", @{
            local array = [1.0, "abc", false];
            expect(clone array).to().equal([1.0, "abc", false]);

            array.insert(0, "qwerty");
            expect(clone array).to().equal(["qwerty", 1.0, "abc", false]);

            array.insert(4, null);
            expect(clone array).to().equal(["qwerty", 1.0, "abc", false, null]);

            array.insert(1, 3.14);
            expect(clone array).to().equal(["qwerty", 3.14, 1.0, "abc", false, null]);
        });


        it("properly resizes the array", @{
            local array = [1.0, "abc", false];
            expect(array.len()).to().equal(3);

            array.insert(0, "qwerty");
            expect(array.len()).to().equal(4);

            array.insert(4, null);
            expect(array.len()).to().equal(5);

            array.insert(1, 3.14);
            expect(array.len()).to().equal(6);
        });


        it("returns null (mutates the receiver in-place)", @{
            expect([].insert(0, 1234)).to().equal(null);
        });


        it("throws an error when trying to insert at negative index", @{
            local array = [1.0, "abc", false];
            expect(@()array.insert(-1, "qwerty")).to().throwError();
        });


        it("throws an error when trying to insert at index greater than the length of the receiver", @{
            expect(@()[].insert(1, 1234)).to().throwError();
            expect(@()[1.0, "abc", false].insert(50, "qwerty")).to().throwError();
        });


        it("throws an error when trying to insert at non-numeric index", @{
            local array = [1.0, "abc", false];
            expect(@()array.insert("asdfg", "qwerty")).to().throwError();
            expect(@()array.insert(false, "qwerty")).to().throwError();
        });


        it("truncates the floating point index arguments", @{
            local array = [1.0, "abc", false];
            expect(clone array).to().equal([1.0, "abc", false]);

            array.insert(0.5, "qwerty");
            expect(clone array).to().equal(["qwerty", 1.0, "abc", false]);

            array.insert(4.75, null);
            expect(clone array).to().equal(["qwerty", 1.0, "abc", false, null]);

            array.insert(1.25, 3.14);
            expect(clone array).to().equal(["qwerty", 3.14, 1.0, "abc", false, null]);
        });
    });
});
