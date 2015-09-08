//
//  core/string/tofloat.nut
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

// Inspired by RubySpec,
// See https://github.com/rubyspec/rubyspec/blob/archive/core/string/to_f_spec.rb

SqTest.spec("string", @{
    describe("tofloat", @{
        it("returns the string converted to float", @{
            expect("0.5".tofloat()).to().equal(0.5);
            expect("1.25".tofloat()).to().equal(1.25);
            expect("-12.5".tofloat()).to().equal(-12.5);
        });

        it("returns a `float` value", @{
            expect(typeof("0.5".tofloat())).to().equal(typeof(0.1));
            expect(typeof("1.25".tofloat())).to().equal(typeof(0.1));
            expect(typeof("-12.5".tofloat())).to().equal(typeof(0.1));
        });

        it("treats leading characters of self as a floating point number", @{
            expect("123.45e1".tofloat()).to().equal(1234.5);
            expect("45.67 degrees".tofloat()).to().equal(45.67);
            expect("0".tofloat()).to().equal(0.0);
            expect(".5".tofloat()).to().equal(0.5);
            expect(".5e1".tofloat()).to().equal(5.0);
            expect("5e".tofloat()).to().equal(5.0);
            expect("5E".tofloat()).to().equal(5.0);
        });


        it("allows for varying signs", @{
            expect("+123.45e1".tofloat()).to().equal(123.45e1);
            expect("-123.45e1".tofloat()).to().equal(-123.45e1);
            expect("123.45e+1".tofloat()).to().equal(123.45e+1);
            expect("123.45e-1".tofloat()).to().equal(123.45e-1);
            expect("+123.45e+1".tofloat()).to().equal(123.45e+1);
            expect("+123.45e-1".tofloat()).to().equal(123.45e-1);
            expect("-123.45e+1".tofloat()).to().equal(-123.45e+1);
            expect("-123.45e-1".tofloat()).to().equal(-123.45e-1);
        });


        it("throws an error if conversion fails", @{
            expect(@()"blah".tofloat()).to().throwError();
            expect(@()"bad".tofloat()).to().throwError();
            expect(@()"thx1138".tofloat()).to().throwError();
        });
    });
});