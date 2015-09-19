//
//  sqxtd/null/get.nut
//  Sqi
//
//  Created by Egor Chiglintsev on 20.09.15.
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

SqTest.spec("null", @{
    requires("SQXTD_NULL_EXTENSION_VERSION", "0.0.1");
    // The spec for `null` is not true for vanilla Squirrel3, these properties
    // have been added by SqXtdLib and are possible with  changes to the
    // Squirrel language introduced in https://github.com/wanderwaltz/Squirrel
    // fork of the Squirrel language source.

    describe("get", @{
        // The goal was to make `null` behave more like Objective-C `nil` which
        // responds to any selector and returns `nil` back.

        context("with default SqXtdLib null extension", @{
            it("returns null for any literal key", @{
                expect(null.someKey).to().equal(null);
                expect(null.otherKey).to().equal(null);
                expect(null.qwerty).to().equal(null);
            });

            it("returns null for any string key", @{
                expect(null["some string key"]).to().equal(null);
                expect(null["name"]).to().equal(null);
                expect(null[""]).to().equal(null);
                expect(null["abc"]).to().equal(null);
            });

            it("returns null for any integer key", @{
                expect(null[123]).to().equal(null);
                expect(null[0]).to().equal(null);
                expect(null[-2]).to().equal(null);
                expect(null[-15622]).to().equal(null);
            });

            it("returns null for any bool key", @{
                expect(null[true]).to().equal(null);
                expect(null[false]).to().equal(null);
            });

            it("returns null for any array key", @{
                expect(null[[1,2,3]]).to().equal(null);
                expect(null[[]]).to().equal(null);
            });

            it("returns null for any table key", @{
                expect(null[{}]).to().equal(null);
                expect(null[{ name = "John Appleseed" }]).to().equal(null);
            });

            it("returns null for any function key", @{
                expect(null[@(x)x+1]).to().equal(null);
                expect(null[function(){return false}]).to().equal(null);
            });
        });


        context("when having a custom _get metamethod in the default delegate", @{
            beforeAll(@{
                local null_delegate = getdefaultdelegate(null);
                null_default_delegate_original_get <- null_delegate._get;
                null_delegate._get = @(key) {
                    return key;
                };
            });

            it("returns the _get metamethod return value", @{
                expect(null.key).to().equal("key");
                expect(null["asdfg"]).to().equal("asdfg");
                expect(null[12]).to().equal(12);
                expect(null[true]).to().equal(true);
                expect(null[[1,"abc",false]]).to().equal([1,"abc",false]);
            });

            afterAll(@{
                getdefaultdelegate(null)._get = null_default_delegate_original_get;
            });
        });
    });
});