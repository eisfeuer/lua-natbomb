local Zbomb = require('../natbomb')

describe('natbomb', function ()
    describe('implode', function()
        it ('return first number when non spaces given', function ()
            assert.are.same(42, Zbomb.implode({}, {42}))
            assert.are.same(42, Zbomb.implode({}, {42, 472}))
        end)

        it ('returns nil when no numbers are given', function ()
            assert.are.same(nil, Zbomb.implode({}, {}))
        end)

        it ('implodes makes a single value from two values', function ()
            assert.are.same(6, Zbomb.implode({2}, {1, 2}))
            assert.are.same(5, Zbomb.implode({3}, {0, 5}))
        end)

        it ('ignores values > #digits+1 in the value table', function ()
            assert.are.same(5, Zbomb.implode({2}, {1, 1, 2}))
        end)

        it ('fills digit spaces with 0 when value table is smaller then the digits table', function () 
            assert.are.same(nil, Zbomb.implode({2}, {}))
            assert.are.same(320, Zbomb.implode({3,3}, {5}))
            assert.are.same(2624, Zbomb.implode({3, 4, 2}, {5, 1}))
        end)

        it ('clip digits when number is bigger then allowed', function ()
            assert.are.same(1, Zbomb.implode({2}, {0, 5}))
        end)
    end) -- describe implode

    describe('explode', function ()
        it ('returns rest space when no spaces are given', function ()
            assert.are.same({42}, Zbomb.explode({}, 42))
            assert.are.same({0}, Zbomb.explode({}, 0))
        end)

        it ('returns exploded numbers', function ()
            assert.are.same({1, 2}, Zbomb.explode({2}, 6))
            assert.are.same({0, 2}, Zbomb.explode({2}, 2))
        end)

        it ('filles missing values with nil', function ()
            assert.are.same({0, 2, 0}, Zbomb.explode({2, 3}, 16))
        end)

        it ('has to be the same value when imploded again', function ()
            assert.are.same(7, Zbomb.implode({1,2}, Zbomb.explode({1,2}, 7)))
            assert.are.same(472, Zbomb.implode({2,4,3}, Zbomb.explode({2,4,3}, 472)))
            assert.are.same(2462, Zbomb.implode({6,2,2,4}, Zbomb.explode({6,2,2,4}, 2462)))
            assert.are.same(290572945, Zbomb.implode({3, 6, 7, 2, 4}, Zbomb.explode({3, 6, 7, 2, 4}, 290572945)))
            assert.are.same(7, Zbomb.implode({2, 2, 2, 2, 2, 2}, Zbomb.explode({2, 2, 2, 2, 2, 2}, 7)))
        end)
    end) -- describe explode
end) -- describe zbomb