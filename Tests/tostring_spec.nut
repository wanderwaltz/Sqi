//
//  tostring_spec.nut
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

SqTest.spec("tosring", function(){
    describe("tables", function(){
        context("when converted to string", function(){
            // The spec for tables tostring conversion is not true for vanilla Squirrel3,
            // this functionality have been added by SqXtdLib and are possible with
            // changes to the Squirrel language introduced in
            // https://github.com/wanderwaltz/Squirrel fork of the Squirrel language source.

            it("should list all table slots", function(){
                local table = {
                    name = "John Appleseed",
                    age  = 27
                };

                expect(table.tostring()).to().equal("{\n\tname = John Appleseed\n\tage = 27\n}");
                // {
                //      name = John Appleseed
                //      age = 27
                // }
            });

            it("should indent nested tables with tabs", function(){
                local table = {
                    key = "value"
                    nestedTable = {
                        x = "y"
                    }
                };

                expect(table.tostring()).to().equal("{\n\tnestedTable = {\n\t\tx = y\n\t}\n\tkey = value\n}");
                // {
                //      key = value
                //      nestedTable = {
                //          x = y
                //      }
                // }
            });
        });


        context("when having a _tostring() metamethod in the default delegate", function(){
            it("should return the default delegate's _tostring() value", function(){
                local default_delegate = getdefaultdelegate({});
                local original_implementation = default_delegate._tostring;

                default_delegate._tostring = function(){
                    return "default delegate tostring";
                };

                expect({}.tostring()).to().equal("default delegate tostring");

                default_delegate._tostring = original_implementation;
            });
        });


        context("when having a delegate", function(){
            it("should return the _tostring() metamethod value if present", function(){
                local delegate = {
                    _tostring = function(){
                        return "expected_value";
                    }
                };

                local table = {};
                table.setdelegate(delegate);

                expect(table.tostring()).to().equal("expected_value");
            });


            it("should override the default delegate _tostring() metamethod value if present", function(){
                local default_delegate = getdefaultdelegate({});
                local original_implementation = default_delegate._tostring;

                default_delegate._tostring = function(){
                    return "default delegate tostring";
                };

                local delegate = {
                    _tostring = function(){
                        return "expected_value";
                    }
                };

                local table = {};
                table.setdelegate(delegate);

                expect(table.tostring()).to().equal("expected_value");

                default_delegate._tostring = original_implementation;
            });
        });
    });
});
