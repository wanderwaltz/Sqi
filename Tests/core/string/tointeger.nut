//
//  core/string/tointeger.nut
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
// See https://github.com/rubyspec/rubyspec/blob/archive/core/string/to_i_spec.rb

SqTest.spec("string", @{
    describe("tointeger", @{
        it("converts the string to integer and returns it", @{
            expect("123".tointeger()).to().equal(123);
            expect("-1".tointeger()).to().equal(-1);
            expect("0".tointeger()).to().equal(0);
        });


        it("returns an integer", @{
            expect(typeof("123".tointeger())).to().equal(typeof(1));
        });


        it("ignores leading whitespaces", @{
            local strings = [" 123", "       123", "\r\n\r\n123",
                             "\t\t123", "\r\n\t\n123", " \t\n\r\t 123"];

            foreach (i, s in strings) {
                expect(s.tointeger()).to().equal(123);
            }
        });


        it("ignores subsequent invalid characters", @{
            expect("123asdf".tointeger()).to().equal(123);
            expect("123#123".tointeger()).to().equal(123);
            expect("123.456".tointeger()).to().equal(123);
            expect("123 456".tointeger()).to().equal(123);
        });


        it("throws an error if the string cannot be converted to integer", @{
            expect(@()"asdfg".tointeger()).to().throwError();
            expect(@()"--12".tointeger()).to().throwError();
            expect(@()"++23".tointeger()).to().throwError();
        });


        it("accepts + at the beginning of the string", @{
            expect("+12".tointeger()).to().equal(12);
        });


        it("does not detect hexadecimal integers", @{
            expect("0xFF".tointeger()).to().equal(0); // 0xFF == 255
            expect("-0xA".tointeger()).to().equal(0); // -0xA == -10
        });


        it("does not detect octal integers", @{
            expect("013".tointeger()).to().equal(13);   //  013 == 11
            expect("-010".tointeger()).to().equal(-10); // -010 == -8
        });
    });
});