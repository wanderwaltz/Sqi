//
//  core/array/sort.nut
//  Sqi
//
//  Created by Egor Chiglintsev on 20.09.15.
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
    describe("sort", @{
        it("sorts the array", @{
            local array = [3, 4, 2, 1, 6, 7];
            array.sort();
            expect(array).to().equal([1,2,3,4,6,7]);
        });

        it("returns null (sorts the receiver in-place)", @{
            expect([1,3,2].sort()).to().equal(null);
        });

        context("when called without arguments", @{
            it("sorts the array in ascending order", @{
                local numbers = [3,2,1];
                numbers.sort();
                expect(numbers).to().equal([1,2,3]);

                local strings = ["qwerty", "asdfg", "zx"];
                strings.sort();
                expect(strings).to().equal(["asdfg", "qwerty", "zx"]);
            });

            it("allows sorting integer arrays", @{
                local integers = [1, 100500, 2, -12, 56];
                expect(@()integers.sort()).notTo().throwError();
            });

            it("allows sorting float arrays", @{
                local floats = [1.0, 100.500, 0.2, -1.2, 56.03];
                expect(@()floats.sort()).notTo().throwError();
            });

            it("allows sorting mixed numeric arrays", @{
                local mixed_numerics = [1.0, 100500, 20, -1.2, 56.03];
                expect(@()mixed_numerics.sort()).notTo().throwError();
            });

            it("allows sorting string arrays", @{
                local strings = ["a", "c", "b"];
                expect(@()strings.sort()).notTo().throwError();
            });

            it("allows sorting arrays of tables", @{
                local tables = [{}, { val = false }, { qwerty = "asdfg" }];
                expect(@()tables.sort()).notTo().throwError();
            });

            it("does not allow sorting mixed type arrays", @{
                local mixed = [1, "abc", {}];
                expect(@()mixed.sort()).to().throwError();
            });

            it("calls _cmp metamethod when sorting arrays of tables", @{
                local a = { val = 3 };
                local b = { val = 2 };
                local c = {};

                local tables = [a,b,c];

                local delegate = {
                    function _cmp(other) {
                        if (this.len() == 0) {
                            return -1;
                        }
                        else if (other.len() == 0) {
                            return 1;
                        }
                        else {
                            return this.val <=> other.val;
                        }
                    }
                };

                foreach (i, t in tables) {
                    t.setdelegate(delegate);
                }

                tables.sort();

                expect(tables).to().equal([c,b,a]);
            });

            it("allows mixing nulls and numbers", @{
                local mixed = [1, 3, 2, null];
                expect(@()mixed.sort()).notTo().throwError();
            });

            it("allows mixing nulls and strings", @{
                local mixed = ["qwerty", "asdfg", "zxcvb", null];
                expect(@()mixed.sort()).notTo().throwError();
            });

            it("sorts nulls before everything", @{
                local mixed_numerics = [1, 3, 2, null];
                mixed_numerics.sort();
                expect(mixed_numerics).to().equal([null, 1, 2, 3]);

                local mixed_strings = ["qwerty", "a", "zxcvb", null];
                mixed_strings.sort();
                expect(mixed_strings).to().equal([null, "a", "qwerty", "zxcvb"]);
            });
        });


        context("when called with a compare function", @{
            it("uses the compare function to determine the ordering", @{
                local numbers = [1, 2, 3];
                numbers.sort(@(a,b)-(a<=>b));
                expect(numbers).to().equal([3,2,1]);
            });

            it("allows any combination of types allowed by the compare function", @{
                local mixed = [1, "abc", {}, false, null];
                expect(@()mixed.sort(@(a,b)(typeof(a) <=> typeof(b)))).notTo().throwError();
            });

            it("throws error if compare function does not return a numeric value", @{
                expect(@()[1,2,3].sort(@(a,b)null)).to().throwError();
                expect(@()[1,2,3].sort(@(a,b)"qwerty")).to().throwError();
                expect(@()[1,2,3].sort(@(a,b)false)).to().throwError();
                expect(@()[1,2,3].sort(@(a,b){})).to().throwError();
            });

            it("throws error if compare function throws", @{
                expect(@()[1,2,3].sort(@(a,b){throw "error"})).to().throwError();
            });
        });
    });
});
