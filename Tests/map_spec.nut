//
//  map_spec.nut
//  Sqi
//
//  Created by Egor Chiglintsev on 04.09.15.
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

SqTest.spec("map", @{
    // The spec for map function is not true for vanilla Squirrel3,
    // it has been added by SqXtdLib

    describe("integer", @{
        context("when mapped", @{
            it("should receive itself as an implicit `this` parameter to map function", @{
                local actual = {
                    parameter = null
                };

                (1).map(@(x)(actual.parameter = this));

                expect(actual.parameter).to().equal(1);
            });


            it("should receive itself as an explicit parameter to map function", @{
                local actual = {
                    parameter = null
                };

                (1).map(@(x)(actual.parameter = x));

                expect(actual.parameter).to().equal(1);
            });


            it("should return the new value", @{
                expect((2).map(@(x)this+5)).to().equal(7);
            });
        });
    });


    describe("float", @{
        context("when mapped", @{
            it("should receive itself as an implicit `this` parameter to map function", @{
                local actual = {
                    parameter = null
                };

                (1.5).map(@(x)(actual.parameter = this));

                expect(actual.parameter).to().equal(1.5);
            });


            it("should receive itself as an explicit parameter to map function", @{
                local actual = {
                    parameter = null
                };

                (1.5).map(@(x)(actual.parameter = x));

                expect(actual.parameter).to().equal(1.5);
            });


            it("should return the new value", @{
                expect((2.5).map(@(x)this+5.5)).to().equal(8);
            });
        });
    });


    describe("string", @{
        context("when mapped", @{
            it("should receive itself as an implicit `this` parameter to map function", @{
                local actual = {
                    parameter = null
                };

                ("qwerty").map(@(x)(actual.parameter = this));

                expect(actual.parameter).to().equal("qwerty");
            });


            it("should receive itself as an explicit parameter to map function", @{
                local actual = {
                    parameter = null
                };

                ("qwerty").map(@(x)(actual.parameter = x));

                expect(actual.parameter).to().equal("qwerty");
            });


            it("should return the new value", @{
                expect(("qwerty").map(@(x)this.len())).to().equal(6);
            });
        });
    });


    describe("bool", @{
        context("when mapped", @{
            it("should receive itself as an implicit `this` parameter to map function", @{
                local actual = {
                    parameter = null
                };

                (true).map(@(x)(actual.parameter = this));

                expect(actual.parameter).to().equal(true);
            });


            it("should receive itself as an explicit parameter to map function", @{
                local actual = {
                    parameter = null
                };

                (true).map(@(x)(actual.parameter = x));

                expect(actual.parameter).to().equal(true);
            });


            it("should return the new value", @{
                expect((true).map(@(x)this || false)).to().equal(true);
            });
        });
    });


    describe("table", @{
        context("when mapped", @{
            it("should receive itself as an implicit `this` parameter to map function", @{
                local actual = {
                    parameter = null
                };

                local table = {
                    name = "John Appleseed"
                };

                table.map(@(x)(actual.parameter = this));

                expect(actual.parameter).to().equal(table);
            });


            it("should receive itself as an explicit parameter to map function", @{
                local actual = {
                    parameter = null
                };

                local table = {
                    name = "John Appleseed"
                };

                table.map(@(x)(actual.parameter = x));

                expect(actual.parameter).to().equal(table);
            });


            it("should return the new value", @{
                expect(({}).map(@(x)this.len())).to().equal(0);
            });
        });
    });


    describe("array", @{
        // note that Squirrel3 provides a default map implementation for array type;
        // SqXtdLib does not replace this implementation

        context("when mapped", @{
            it("should receive itself as an implicit `this` parameter to map function", @{
                local actual = {
                    parameter = null
                };

                local array = [1,2,3];

                array.map(@(x)(actual.parameter = this));

                expect(actual.parameter).to().equal(array);
            });


            it("should return a new array with mapped elements", @{
                local initial_array = [1,2,3];
                local expected_array = [2,4,6];
                local mapped_array = initial_array.map(@(x)x*2);

                foreach (i, x in mapped_array) {
                    expect(x).to().equal(expected_array[i]);
                }
            });
        });
    });


    describe("null", @{
        context("when mapped", @{
            it("should return null regardless of the function", @{
                expect(null.map(@(x)"qwerty")).to().equal(null);
            });
        });
    });
});
