//
//  core/array/resize.nut
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
    describe("resize", @{
        context("when the size parameter does not exceed the array length", @{
            array <- [1.0, "abc", false];

            it("truncates the array to the given size", @{
                local a0 = (clone array); a0.resize(0);
                local a1 = (clone array); a1.resize(1);
                local a2 = (clone array); a2.resize(2);
                local a3 = (clone array); a3.resize(3);

                expect(a0).to().equal([]);
                expect(a1).to().equal([1.0]);
                expect(a2).to().equal([1.0, "abc"]);
                expect(a3).to().equal([1.0, "abc", false]);
            });

            it("ignores the fill parameter", @{
                local a0 = (clone array); a0.resize(0, null);
                local a1 = (clone array); a1.resize(1, "qwerty");
                local a2 = (clone array); a2.resize(2, 12345);
                local a3 = (clone array); a3.resize(3, -10.500);

                expect(a0).to().equal([]);
                expect(a1).to().equal([1.0]);
                expect(a2).to().equal([1.0, "abc"]);
                expect(a3).to().equal([1.0, "abc", false]);
            });

            it("throws an error if the size parameter is negative", @{
                expect(@()(clone array).resize(-1)).to().throwError();
                expect(@()(clone array).resize(-20)).to().throwError();
            });

            it("throws an error if the size parameter is non-numeric", @{
                expect(@()(clone array).resize("qwerty")).to().throwError();
                expect(@()(clone array).resize(false)).to().throwError();
            });

            it("truncates the floating point size arguments", @{
                local a0 = (clone array); a0.resize(0.25);
                local a1 = (clone array); a1.resize(1.5);
                local a2 = (clone array); a2.resize(2.75);

                expect(a0).to().equal([]);
                expect(a1).to().equal([1.0]);
                expect(a2).to().equal([1.0, "abc"]);
            });
        });

        context("when the size parameter is greater than the array length", @{
            array <- [1.0, "abc", false];

            it("properly updates the array length", @{
                local a0 = (clone array); a0.resize(5);
                local a1 = (clone array); a1.resize(66);
                local a2 = (clone array); a2.resize(34);

                expect(a0.len()).to().equal(5);
                expect(a1.len()).to().equal(66);
                expect(a2.len()).to().equal(34);
            });

            context("when no fill parameter is provided", @{
                it("fills the newly added indexes with nulls", @{
                    local a0 = (clone array); a0.resize(5);
                    local a1 = (clone array); a1.resize(7);
                    local a2 = (clone array); a2.resize(8);

                    expect(a0).to().equal([1.0, "abc", false, null, null]);
                    expect(a1).to().equal([1.0, "abc", false, null, null, null, null]);
                    expect(a2).to().equal([1.0, "abc", false, null, null, null, null, null]);
                });
            });


            context("when a fill parameter is provided", @{
                it("fills the newly added indexes with the fill parameter value", @{
                    local a0 = (clone array); a0.resize(5, "qqq");
                    local a1 = (clone array); a1.resize(7, 123);
                    local a2 = (clone array); a2.resize(8, true);

                    expect(a0).to().equal([1.0, "abc", false, "qqq", "qqq"]);
                    expect(a1).to().equal([1.0, "abc", false, 123, 123, 123, 123]);
                    expect(a2).to().equal([1.0, "abc", false, true, true, true, true, true]);
                });

                it("does not copy the fill parameter value", @{
                    local by_reference = { key = "value" };
                    local a0 = (clone array); a0.resize(5, by_reference);

                    expect(a0[3]).to().beIdenticalTo(by_reference);
                    expect(a0[4]).to().beIdenticalTo(by_reference);

                    by_reference.key = "qwerty";
                    expect(a0[3].key).to().equal("qwerty");
                    expect(a0[4].key).to().equal("qwerty");
                });
            });
        });
    });
});
