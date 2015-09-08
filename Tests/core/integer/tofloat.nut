//
//  core/integer/tofloat.nut
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
    describe("tofloat", @{
        it("returns the integer converted to float", @{
            expect((1).tofloat()).to().equal(1.0);
            expect((0).tofloat()).to().equal(0.0);
            expect((-1234).tofloat()).to().equal(-1234.0);
        });

        it("returns a `float` value", @{
            expect(typeof((1).tofloat())).to().equal(typeof(0.0));
            expect(typeof((0).tofloat())).to().equal(typeof(0.0));
            expect(typeof((-1234).tofloat())).to().equal(typeof(0.0));

            expect(typeof((1).tofloat())).notTo().equal(typeof(0));
            expect(typeof((0).tofloat())).notTo().equal(typeof(0));
            expect(typeof((-1234).tofloat())).notTo().equal(typeof(0));
        });
    });
});