//
//  core/array/remove.nut
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
    describe("remove", @{
        it("removes the value at the given position from the array", @{
            local array = [1.0, "abc", false];
            expect(clone array).to().equal([1.0, "abc", false]);

            array.remove(0);
            expect(clone array).to().equal(["abc", false]);

            array.remove(1);
            expect(clone array).to().equal(["abc"]);

            array.remove(0);
            expect(clone array).to().equal([]);
        });


        it("properly resizes the array", @{
            local array = [1.0, "abc", false];
            expect(array.len()).to().equal(3);

            array.remove(0);
            expect(array.len()).to().equal(2);

            array.remove(0);
            expect(array.len()).to().equal(1);

            array.remove(0);
            expect(array.len()).to().equal(0);
        });


        it("returns the removed object", @{
            local array = [1.0, "abc", false];
            expect(array.remove(0)).to().equal(1.0);     // ["abc", false]
            expect(array.remove(1)).to().equal(false);   // ["abc"]
            expect(array.remove(0)).to().equal(["abc"]); // []
        });


        it("throws error when trying to remove from negative index", @{
            local array = [1.0, "abc", false];
            expect(@()array.remove(-1)).to().throwError();
        });


        it("throws error when trying to remove at index >= than the length of the receiver", @{
            expect(@()[].remove(1)).to().throwError();
            expect(@()[1.0, "abc", false].remove(50)).to().throwError();
        });
    });
});
