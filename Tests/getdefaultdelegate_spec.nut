//
//  getdefaultdelegate_spec.nut
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

SqTest.spec("getdefaultdelegate", function(){
    // The spec for getdefaultdelegate function is not true for vanilla Squirrel3,
    // it has been added by SqXtdLib

    context("by default", function(){
        it("should exist in root table", function(){
            expect(getroottable()).to().haveSlot("getdefaultdelegate");
        });


        it("should be a function", function(){
            expect(typeof(::getdefaultdelegate)).to().equal(typeof(function(){}));
        });


        it("should return a table for any object", function(){
            expect(typeof(::getdefaultdelegate(1))).to().equal(typeof({}));
        });


        it("should return the same table for any object of a given type", function(){
            local oneDelegate = ::getdefaultdelegate(1);
            local twoDelegate = ::getdefaultdelegate(2);

            expect(oneDelegate).to().equal(twoDelegate);
        });


        it("should return different tables for objects of different types", function(){
            local numberDelegate = ::getdefaultdelegate(1);
            local stringDelegate = ::getdefaultdelegate("qwerty");

            expect(numberDelegate).notTo().equal(stringDelegate);
        });
    });


    context("when asked to", function(){
        it("should provide a default delegate for number type", function(){
            expect(::getdefaultdelegate(1)).notTo().equal(null);
        });


        it("should provide a default delegate for string type", function(){
            expect(::getdefaultdelegate("qwerty")).notTo().equal(null);
        });


        it("should provide a default delegate for table type", function(){
            expect(::getdefaultdelegate({})).notTo().equal(null);
        });


        it("should provide a default delegate for array type", function(){
            expect(::getdefaultdelegate([])).notTo().equal(null);
        });


        it("should provide a default delegate for null type", function(){
            expect(::getdefaultdelegate(null)).notTo().equal(null);
        });


        it("should provide a default delegate for class type", function(){
            expect(::getdefaultdelegate(class{})).notTo().equal(null);
        });


        it("should provide a default delegate for instance type", function(){
            local theClass = class{};
            local instance = theClass();
            expect(::getdefaultdelegate(instance)).notTo().equal(null);
        });
    });
});
