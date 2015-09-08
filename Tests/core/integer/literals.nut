//
//  core/integer/literals.nut
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
    describe("literal", @{
        it("supports positive decimal integers", @{
            expect(123).to().equal(123);
            expect(11).to().equal(11);
            expect(0).to().equal(0);
        });

        it("supports negative decimal integers", @{
            expect(-33).to().equal(-33);
            expect(-15).to().equal(-15);
        });

        it("supports positive hexadecimal integers", @{
            expect(0xFF).to().equal(255);
            expect(0xA).to().equal(10);
            expect(0x0).to().equal(0);
        });

        it("supports positive octal integers", @{
            expect(013).to().equal(11);
            expect(020).to().equal(16);
            expect(000).to().equal(0);
        });

        it("supports negative hexadecimal integers", @{
            expect(-0xFA).to().equal(-250);
            expect(-0xC).to().equal(-12);
        });

        it("supports negative octal integers", @{
            expect(-043).to().equal(-35);
            expect(-07).to().equal(-7);
        });
    });
});