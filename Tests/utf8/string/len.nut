//
//  utf8/string/len.nut
//  Sqi
//
//  Created by Egor Chiglintsev on 15.09.15.
//  Copyright (c) 2015  Egor Chiglintsev
//
//  Sentences that contain all letters commonly used in a language
//  Copyright (c) 2012 Markus Kuhn <http://www.cl.cam.ac.uk/~mgk25/>
//      See http://www.cl.cam.ac.uk/~mgk25/ucs/examples/quickbrown.txt
//
//      Special thanks to the people from all over the world who contributed
//      these sentences since 1999.
//
//      A much larger collection of such pangrams is now available at
//      http://en.wikipedia.org/wiki/List_of_pangrams
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

SqTest.spec("string", @{
    requires("SQUTF8_STRING_EXTENSION_VERSION", "0.0.1");

    describe("len", @{
        context("for ASCII strings", @{
            it("returns the number of characters in the string", @{
                expect("".len()).to().equal(0);
                expect("one".len()).to().equal(3);
                expect("two".len()).to().equal(3);
                expect("three".len()).to().equal(5);
                expect("four".len()).to().equal(4);
            });
        });


        context("for UTF-8 strings", @{
            it("returns the number of UTF-8 code points in the string", @{
            // Sentences that contain all letters commonly used in a language
            // --------------------------------------------------------------
            //
            // By Markus Kuhn <http://www.cl.cam.ac.uk/~mgk25/> -- 2012-04-11
            // See http://www.cl.cam.ac.uk/~mgk25/ucs/examples/quickbrown.txt
            //
            // NOTE: Some of the languages are commented out currently because Squirrel
            //       does not support automatic concatenations of consecutive string
            //       literals and thus longer strings are not possible to include
            //       without messing the formatting too much.
            //
            // Danish (da)
            // ---------
                expect("Quizdeltagerne spiste jordbær med fløde, mens cirkusklovnen Wolther spillede på xylofon.".len()).to().equal(88);
            //        (= Quiz contestants were eating strawbery with cream while Wolther
            //           the circus clown played on xylophone.)

            // German (de)
            // -----------
                expect("Falsches Üben von Xylophonmusik quält jeden größeren Zwerg".len()).to().equal(58);
            //        (= Wrongful practicing of xylophone music tortures every larger dwarf)
            //
                expect("Zwölf Boxkämpfer jagten Eva quer über den Sylter Deich".len()).to().equal(54);
            //        (= Twelve boxing fighters hunted Eva across the dike of Sylt)
            //
                expect("Heizölrückstoßabdämpfung".len()).to().equal(24);
            //        (= fuel oil recoil absorber)
            //        (jqvwxy missing, but all non-ASCII letters in one word)
            //
            // Greek (el)
            // ----------
                expect("Γαζέες καὶ μυρτιὲς δὲν θὰ βρῶ πιὰ στὸ χρυσαφὶ ξέφωτο".len()).to().equal(52);
            //        (= No more shall I see acacias or myrtles in the golden clearing)
            //
                expect("Ξεσκεπάζω τὴν ψυχοφθόρα βδελυγμία".len()).to().equal(33);
            //        (= I uncover the soul-destroying abhorrence)
            //
            // English (en)
            // ------------
                expect("The quick brown fox jumps over the lazy dog".len()).to().equal(43);
            //
            // Spanish (es)
            // ------------
                expect("El pingüino Wenceslao hizo kilómetros bajo exhaustiva lluvia y frío, añoraba a su querido cachorro.".len()).to().equal(99);
            //        (Contains every letter and every accent, but not every combination
            //         of vowel + acute.)
            //
            // French (fr)
            // -----------
            //   Portez ce vieux whisky au juge blond qui fume sur son île intérieure, à
            //   côté de l'alcôve ovoïde, où les bûches se consument dans l'âtre, ce
            //   qui lui permet de penser à la cænogenèse de l'être dont il est question
            //   dans la cause ambiguë entendue à Moÿ, dans un capharnaüm qui,
            //   pense-t-il, diminue çà et là la qualité de son œuvre.
            //
            //   l'île exiguë
            //   Où l'obèse jury mûr
            //   Fête l'haï volapük,
            //   Âne ex aéquo au whist,
            //   Ôtez ce vœu déçu.
            //
            //   Le cœur déçu mais l'âme plutôt naïve, Louÿs rêva de crapaüter en
            //   canoë au delà des îles, près du mälström où brûlent les novæ.
            //
            // Irish Gaelic (ga)
            // -----------------
                expect("D'fhuascail Íosa, Úrmhac na hÓighe Beannaithe, pór Éava agus Ádhaimh".len()).to().equal(68);
            //
            // Hungarian (hu)
            // --------------
                expect("Árvíztűrő tükörfúrógép".len()).to().equal(22);
            //        (= flood-proof mirror-drilling machine, only all non-ASCII letters)
            //
            // Icelandic (is)
            // --------------
                expect("Kæmi ný öxi hér ykist þjófum nú bæði víl og ádrepa".len()).to().equal(50);
            //
                expect("Sævör grét áðan því úlpan var ónýt".len()).to().equal(34);
            //        (some ASCII letters missing)
            //
            // Japanese (jp)
            // -------------
            //
            //   Hiragana: (Iroha)
            //
            //   いろはにほへとちりぬるを
            //   わかよたれそつねならむ
            //   うゐのおくやまけふこえて
            //   あさきゆめみしゑひもせす
            //
            //   Katakana:
            //
            //   イロハニホヘト チリヌルヲ ワカヨタレソ ツネナラム
            //   ウヰノオクヤマ ケフコエテ アサキユメミシ ヱヒモセスン
            //
            // Hebrew (iw)
            // -----------
                expect("? דג סקרן שט בים מאוכזב ולפתע מצא לו חברה איך הקליטה".len()).to().equal(52);
            //
            // Polish (pl)
            // -----------
                expect("Pchnąć w tę łódź jeża lub ośm skrzyń fig".len()).to().equal(40);
            //        (= To push a hedgehog or eight bins of figs in this boat)
            //
            // Russian (ru)
            // ------------
                expect("В чащах юга жил бы цитрус? Да, но фальшивый экземпляр!".len()).to().equal(54);
            //        (= Would a citrus live in the bushes of south? Yes, but only a fake one!)
            //
                expect("Съешь же ещё этих мягких французских булок да выпей чаю".len()).to().equal(55);
            //        (= Eat some more of these fresh French loafs and have some tea)
            //
            // Thai (th)
            // ---------
            //
            //   [--------------------------|------------------------]
            //   ๏ เป็นมนุษย์สุดประเสริฐเลิศคุณค่า  กว่าบรรดาฝูงสัตว์เดรัจฉาน
            //   จงฝ่าฟันพัฒนาวิชาการ           อย่าล้างผลาญฤๅเข่นฆ่าบีฑาใคร
            //   ไม่ถือโทษโกรธแช่งซัดฮึดฮัดด่า     หัดอภัยเหมือนกีฬาอัชฌาสัย
            //   ปฏิบัติประพฤติกฎกำหนดใจ        พูดจาให้จ๊ะๆ จ๋าๆ น่าฟังเอย ฯ
            //
            //   [The copyright for the Thai example is owned by The Computer
            //   Association of Thailand under the Royal Patronage of His Majesty the
            //   King.]
            //
            // Turkish (tr)
            // ------------
                expect("Pijamalı hasta, yağız şoföre çabucak güvendi.".len()).to().equal(45);
            //        (=Patient with pajamas, trusted swarthy driver quickly)
            //
            //
            // Special thanks to the people from all over the world who contributed
            // these sentences since 1999.
            //
            // A much larger collection of such pangrams is now available at
            //
            //   http://en.wikipedia.org/wiki/List_of_pangrams
            });
        });
    });
});