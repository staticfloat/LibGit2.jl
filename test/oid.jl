context("test OID") do
    # Test constructor
    HEX1 = "15b648aec6ed045b5ca6f57f8b7831a8b4757298"
    HEX2 = "15b648aec6ed045b5ca6f57f8b7831a8b4757299"

    # test string constructor
    oid1 = Oid(HEX1)

    # Test equality
    oid2 = Oid(HEX1)
    @test oid1 == oid2

    oid2 = Oid(HEX2)
    @test oid1 != oid2

    # test array constructor
    @test Oid(hex2bytes(HEX1)) == Oid(HEX1)

    # test pointer constructor
    @test Oid(pointer(hex2bytes(HEX1))) == Oid(HEX1)

    # constructors throw argument errors on invalid inputs
    @test_throws ArgumentError Oid(HEX1[2:end-1])
    @test_throws ArgumentError Oid(hex2bytes(HEX1)[1:end-1])
    @test_throws ArgumentError Oid(convert(Ptr{Uint8}, C_NULL))

    # test raw
    @test bytes2hex(raw(Oid(HEX1))) == HEX1

    # Test comparisons
    @test is(oid1 < oid2, true)
    @test is(oid1 <= oid2, true)
    @test is(oid1 == oid2, false)
    @test is(oid1 > oid2, false)
    @test is(oid1 >= oid2, false)

    # Test hash
    oid1 = Oid(HEX1)
    oid2 = Oid(HEX1)

    s = Set{Oid}({oid1, oid2})
    @test length(s) == 1

    push!(s, Oid("0000000000000000000000000000000000000000"))
    push!(s, Oid("0000000000000000000000000000000000000001"))
    @test length(s) == 3

    # Test iszero
    @test iszero(Oid()) == true
    @test iszero(oid1) == false
    @test iszero(Oid(zeros(Uint8, 20))) == true
end

context("test SHA1") do
    sha = sha1"15b648aec6ed045b5ca6f57f8b7831a8b4757298"

    #test sha1 constructors
    @test isa(sha, Sha1)

    # invalid string length
    @test_throws ArgumentError Sha1("15b648aec6ed045b5ca6f57f8b7831a8b475729")
end
