//
//  core/integer/division.nut
//  Sqi
//
//  Created by Egor Chiglintsev on 08.09.15.
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

SqTest.spec("integer", @{
    describe("division", @{
        context("when dividing by another integer", @{
            context("when remainder is zero", @{
                it("returns the expected value", @{
                    expect(6/3).to().equal(2);
                });

                it("returns in an `integer` value", @{
                    expect(typeof(6/3)).to().equal(typeof(0));
                });
            });

            context("when remainder is nonzero", @{
                it("returns the division result rounded down", @{
                    expect(5/2).to().equal(2);
                    expect(1/10).to().equal(0);
                });

                it("returns an `integer` value", @{
                    expect(typeof(5/2)).to().equal(typeof(0));
                });
            });
        });

        context("when dividing by a float", @{
            it("returns the expected value", @{
                expect(5/2.0).to().equal(2.5);
            });

            it("returns a `float` value", @{
                expect(typeof(5/2.0)).to().equal(typeof(0.0));
            });
        });
    });
});
