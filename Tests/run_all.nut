#!/usr/bin/sqi
//
//  run_all.nut
//  Sqi
//
//  Created by Egor Chiglintsev on 03.09.15.
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

SqTest <- {};
::import("../Vendor/SqTest/SqTest", SqTest);

SqTest.import_spec("core/integer");
SqTest.import_spec("core/float");
SqTest.import_spec("core/bool");
SqTest.import_spec("core/string");
SqTest.import_spec("core/table");
SqTest.import_spec("core/array");
SqTest.import_spec("sqxtd/table");

SqTest.import_spec("sqxtd/integer");
SqTest.import_spec("sqxtd/float");
SqTest.import_spec("sqxtd/bool");
SqTest.import_spec("sqxtd/array");
SqTest.import_spec("sqxtd/string");
SqTest.import_spec("sqxtd/null");

SqTest.import_spec("utf8/string");

SqTest.import_spec("getdefaultdelegate_spec");

SqTest.run({ hide_successful = true });
