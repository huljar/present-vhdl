package util is
    type key_enum is (K_80, K_128);
    type key_lookup is array(key_enum) of integer;
    constant key_bits: key_lookup := (
        K_80  =>  80,
        K_128 => 128
    );
end package;
