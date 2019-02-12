pub type TestAtom = :: string_cache :: Atom < TestAtomStaticSet > ;
pub struct TestAtomStaticSet ;
impl :: string_cache :: StaticAtomSet for TestAtomStaticSet { fn get ( ) -> & 'static :: string_cache :: PhfStrSet { static SET : :: string_cache :: PhfStrSet = :: string_cache :: PhfStrSet { key : 8795782494440154893u64 , disps : & [ ( 6u32 , 8u32 , ) , ( 0u32 , 0u32 , ) , ( 0u32 , 6u32 , ) , ] , atoms : &[
"body",
"font-weight",
"area",
"html",
"a",
"",
"br",
"address",
"head",
"b",
"id",
] , hashes : & [ 3643424721u32 , 38245096u32 , 3625907873u32 , 3793479691u32 , 4182356116u32 , 1794383639u32 , 3820983257u32 , 1145770315u32 , 4082119416u32 , 1048724515u32 , 243892743u32 , ] } ;
& SET } fn empty_string_index ( ) -> u32 { 5u32 } } # [ macro_export ] macro_rules ! test_atom {
( "body" ) => { $ crate :: atom::tests::TestAtom { unsafe_data : 0x2u64 , phantom : :: std :: marker :: PhantomData , } } ;
( "font-weight" ) => { $ crate :: atom::tests::TestAtom { unsafe_data : 0x100000002u64 , phantom : :: std :: marker :: PhantomData , } } ;
( "area" ) => { $ crate :: atom::tests::TestAtom { unsafe_data : 0x200000002u64 , phantom : :: std :: marker :: PhantomData , } } ;
( "html" ) => { $ crate :: atom::tests::TestAtom { unsafe_data : 0x300000002u64 , phantom : :: std :: marker :: PhantomData , } } ;
( "a" ) => { $ crate :: atom::tests::TestAtom { unsafe_data : 0x400000002u64 , phantom : :: std :: marker :: PhantomData , } } ;
( "" ) => { $ crate :: atom::tests::TestAtom { unsafe_data : 0x500000002u64 , phantom : :: std :: marker :: PhantomData , } } ;
( "br" ) => { $ crate :: atom::tests::TestAtom { unsafe_data : 0x600000002u64 , phantom : :: std :: marker :: PhantomData , } } ;
( "address" ) => { $ crate :: atom::tests::TestAtom { unsafe_data : 0x700000002u64 , phantom : :: std :: marker :: PhantomData , } } ;
( "head" ) => { $ crate :: atom::tests::TestAtom { unsafe_data : 0x800000002u64 , phantom : :: std :: marker :: PhantomData , } } ;
( "b" ) => { $ crate :: atom::tests::TestAtom { unsafe_data : 0x900000002u64 , phantom : :: std :: marker :: PhantomData , } } ;
( "id" ) => { $ crate :: atom::tests::TestAtom { unsafe_data : 0xA00000002u64 , phantom : :: std :: marker :: PhantomData , } } ;
}