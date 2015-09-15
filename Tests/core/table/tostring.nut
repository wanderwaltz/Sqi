//
//  core/table/tostring.nut
//  Sqi
//
//  Created by Egor Chiglintsev on 16.09.15.
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

SqTest.spec("table", @{
    describe("tostring", @{
        it("returns a string", @{
            expect(typeof({}.tostring())).to().equal(typeof(""));
            expect(typeof({ qwerty = "asdfg" }.tostring())).to().equal(typeof(""));
        });

        context("when having a delegate", @{
            it("returns the delegate's _tostring() metamethod value if present", @{
                local delegate = {
                    _tostring = function(){
                        return "expected_value";
                    }
                };

                local table = {};
                table.setdelegate(delegate);

                expect(table.tostring()).to().equal("expected_value");
            });
        });

        context("when having a _tostring() metamethod in the default delegate", @{
            requires("SQUIRREL_EXTENSIONS_VERSION", "0.0.1");
            requires("SQXTD_GET_DEFAULT_DELEGATE_EXTENSION_VERSION", "0.0.1");

            it("returns the default delegate's _tostring() value", @{
                local default_delegate = getdefaultdelegate({});
                local original_implementation = default_delegate._tostring;

                default_delegate._tostring = function(){
                    return "default delegate tostring";
                };

                expect({}.tostring()).to().equal("default delegate tostring");

                default_delegate._tostring = original_implementation;
            });


            it("overrides the default delegate _tostring() metamethod with the table "
               "delegate's implementation if present", @{
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